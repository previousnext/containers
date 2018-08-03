FROM  previousnext/passenger:base
LABEL maintainer="admin@previousnext.com.au"

# These get run on build.
ONBUILD COPY . /data
ONBUILD RUN chown -R www-data:www-data /data
