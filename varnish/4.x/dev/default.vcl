vcl 4.0;
import directors;

backend default {
    .host = "127.0.0.1";
    .port = "80";
    .connect_timeout = 600s;
    .first_byte_timeout = 600s;
    .between_bytes_timeout = 600s;
}

acl purge {
  "localhost";
  "127.0.0.1";
}

# Define the director that determines how to distribute incoming requests.
sub vcl_init {
  new bar = directors.fallback();
  bar.add_backend(default);
}

# Respond to incoming requests.
sub vcl_recv {
  set req.backend_hint = bar.backend();

  # Do not cache these paths.
  if (req.url ~ "^/status\.php$" ||
      req.url ~ "^/update\.php" ||
      req.url ~ "^/install\.php" ||
      req.url ~ "^/apc\.php$" ||
      req.url ~ "^/admin" ||
      req.url ~ "^/admin/.*$" ||
      req.url ~ "^/user" ||
      req.url ~ "^/search/.*$" ||
      req.url ~ "^/user/.*$" ||
      req.url ~ "^/users/.*$" ||
      req.url ~ "^/info/.*$" ||
      req.url ~ "^/flag/.*$" ||
      req.url ~ "^.*/ajax/.*$" ||
      req.url ~ "^.*/ahah/.*$" ||
      req.url ~ "^/system/files/.*$") {

    return (pass);
  }

  # Remove all cookies that Drupal doesn't need to know about. We explicitly
  # list the ones that Drupal does need, the SESS and NO_CACHE. If, after
  # running this code we find that either of these two cookies remains, we
  # will pass as the page cannot be cached.
  if (req.http.Cookie) {
    # 1. Append a semi-colon to the front of the cookie string.
    # 2. Remove all spaces that appear after semi-colons.
    # 3. Match the cookies we want to keep, adding the space we removed
    #    previously back. (\1) is first matching group in the regsuball.
    # 4. Remove all other cookies, identifying them by the fact that they have
    #    no space after the preceding semi-colon.
    # 5. Remove all spaces and semi-colons from the beginning and end of the
    #    cookie string.
    set req.http.Cookie = ";" + req.http.Cookie;
    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE)=", "; \1=");
    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

    if (req.http.Cookie == "") {
      # If there are no remaining cookies, remove the cookie header. If there
      # aren't any cookie headers, Varnish's default behavior will be to cache
      # the page.
      unset req.http.Cookie;
    }
    else {
      # If there is any cookies left (a session or NO_CACHE cookie), do not
      # cache the page. Pass it on to Apache directly.
      return (pass);
    }
  }
 # Check the incoming request type is "PURGE", not "GET" or "POST".
  if (req.method == "PURGE") {
    # Check if the IP is allowed.
    if (!client.ip ~ purge) {
      # Return error code 405 (Forbidden) when not.
      return (synth(405, "Not allowed."));
    }
    return (purge);
  }
  # Only allow BAN requests from IP addresses in the 'purge' ACL.
  if (req.method == "BAN") {
    # Same ACL check as above:
    if (!client.ip ~ purge) {
        return (synth(403, "Not allowed."));
    }

    # Logic for the ban, using the X-Cache-Tags header.
    if (req.http.X-Cache-Tags) {
        ban("obj.http.X-Cache-Tags ~ " + req.http.X-Cache-Tags);
    }
    else {
        return (synth(403, "X-Cache-Tags header missing."));
    }

    # Throw a synthetic page so the request won't go to the backend.
    return (synth(200, "Ban added."));
  }

}

# Set a header to track a cache HIT/MISS.
 sub vcl_deliver {
  # Remove ban-lurker friendly custom headers when delivering to client.
  unset resp.http.X-Url;
  unset resp.http.X-Host;
  # Comment these for easier Drupal cache tag debugging in development.
  unset resp.http.X-Cache-Tags;
  unset resp.http.X-Cache-Contexts;
  if (obj.hits > 0) {
    set resp.http.X-Varnish-Cache = "HIT";
  }
  else {
    set resp.http.X-Varnish-Cache = "MISS";
  }
}

sub vcl_backend_response {
  # Set ban-lurker friendly custom headers.
  set beresp.http.X-Url = bereq.url;
  set beresp.http.X-Host = bereq.http.host;
}

# In the event of an error, show friendlier messages.
sub vcl_backend_error {
     set beresp.http.Content-Type = "text/html; charset=utf-8";
     set beresp.http.Retry-After = "5";
     synthetic ({"
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
   <head>
     <title>"} + beresp.http.status + " " + beresp.http.response + {"</title>
   </head>
   <body>
     <h1>Error "} + beresp.http.status + " " + beresp.http.response + {"</h1>
     <p>"} + beresp.http.response + {"</p>
     <h3>Guru Meditation:</h3>
     <p>XID: "} + bereq.xid + {"</p>
     <hr>
     <p>Varnish cache server</p>
   </body>
</html>
"});
  return (deliver);
}
