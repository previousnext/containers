FROM  previousnext/php:5.6-base
LABEL maintainer="admin@previousnext.com.au"

# These get run on build.
ONBUILD COPY . /data
ONBUILD RUN chown -R www-data:www-data /data