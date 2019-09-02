FROM alpine/git:latest AS clone

RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/larowlan/tl.git

FROM php:latest
COPY --from=clone /data/tl/tl.phar /tl
ENTRYPOINT ["/tl"]
