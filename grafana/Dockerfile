FROM grafana/grafana
MAINTAINER PreviousNext <info@previousnext.com.au>

ENV GF_DASHBOARDS_JSON_ENABLED true
ENV GF_DASHBOARDS_JSON_PATH /etc/grafana/dashboards.d
ADD ["dashboards", "$GF_DASHBOARDS_JSON_PATH"]
