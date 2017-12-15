FROM ruby:latest

RUN gem install request-log-analyzer
COPY ./cloud_front.rb /root/cloud_front.rb

VOLUME /data
WORKDIR /data

ENTRYPOINT [ \
  "request-log-analyzer", \
  "--format", "/root/cloud_front.rb", \
  "--output", "html", \
  "--file", "report.html" \
]

CMD ["/data"]
