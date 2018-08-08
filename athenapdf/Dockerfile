FROM arachnysdocker/athenapdf-service:2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      unzip && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://www.latofonts.com/download/Lato2OFL.zip && unzip Lato2OFL.zip -d /usr/share/fonts

COPY fonts.conf /etc/fonts/conf.d/100-athena.conf

COPY aer.ttf /usr/share/fonts

RUN fc-cache -f -v
