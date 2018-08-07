FROM debian:sid
ARG CHROME_VERSION=68
VOLUME /tmp

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl && \
    curl -Ls -o /tmp/google-chrome.deb https://s3-ap-southeast-2.amazonaws.com/pnx-misc/apt-archive/google-chrome-stable/${CHROME_VERSION}-amd64-linux.deb && \
    apt install -y /tmp/google-chrome.deb && \
    apt-get purge --auto-remove -y curl gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && \
    useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome && \
    chown -R chrome:chrome /home/chrome

USER chrome

EXPOSE 9222

ENTRYPOINT [ "google-chrome-stable" ]
CMD [ "--headless", "--disable-gpu", "--no-sandbox", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
