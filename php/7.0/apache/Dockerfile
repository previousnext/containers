FROM       previousnext/php:7.0-base
MAINTAINER nick_schuch

# These get run on build.
ONBUILD ADD . /data
ONBUILD RUN chown -R www-data:www-data /data