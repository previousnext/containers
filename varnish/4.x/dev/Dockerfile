FROM  alpine:3.5
LABEL maintainer="admin@previousnext.com.au"

EXPOSE 8080

RUN apk update && \
    apk upgrade && \
    apk add varnish=4.1.3-r0

ADD default.vcl /etc/varnish/default.vcl

CMD ["varnishd", "-F", "-f", "/etc/varnish/default.vcl", "-s", "malloc,100M", "-a", "0.0.0.0:8080"]
