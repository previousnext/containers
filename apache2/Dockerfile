FROM  ubuntu:16.04
LABEL maintainer="admin@previousnext.com.au"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends apache2 && \
    a2enmod rewrite && \
    rm -fR /var/www/html && \
    rm -f /etc/apache2/conf-enabled/other-vhosts-access-log.conf && \
    rm -f /etc/apache2/sites-enabled/000-default.conf && \
    rm -rf /var/lib/apt/lists/*

ADD apache2.conf /etc/apache2/apache2.conf

RUN mkdir -p /etc/apache2/logs && \
    chown -R www-data:www-data /etc/apache2/logs && \
    ln -sf /proc/self/fd/1 /etc/apache2/logs/access.log && \
    ln -sf /proc/self/fd/1 /etc/apache2/logs/error.log

EXPOSE 80

ONBUILD ADD . /data
ONBUILD RUN chown -R www-data:www-data /data

ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]
