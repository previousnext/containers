FROM debian:sid
ARG CHROME_VERSION=68
ARG CHROME_DRIVER_VERSION=2.41
VOLUME /tmp

RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl unzip && \
    curl -Ls -o /tmp/google-chrome.deb https://s3-ap-southeast-2.amazonaws.com/pnx-misc/apt-archive/google-chrome-stable/${CHROME_VERSION}-amd64-linux.deb && \
    apt install -y /tmp/google-chrome.deb && \
    curl -Ls -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver_linux64.zip -d /opt &&\
    rm /tmp/chromedriver_linux64.zip && \
    mv /opt/chromedriver /opt/chromedriver-$CHROME_DRIVER_VERSION && \
    chmod 755 /opt/chromedriver-$CHROME_DRIVER_VERSION && \
    ln -fs /opt/chromedriver-$CHROME_DRIVER_VERSION /usr/local/bin/chromedriver && \
    apt-get purge --auto-remove -y curl unzip gnupg && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && \
    useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome && \
    chown -R chrome:chrome /home/chrome

USER chrome

EXPOSE 9515

ENTRYPOINT [ "chromedriver" ]
CMD [ "--whitelisted-ips=" ]
