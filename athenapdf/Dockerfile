FROM arachnysdocker/athenapdf-service:2

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50 04EE7237B7D453EC 648ACFD622F3D138 EF0F382A1A7B6500 DCC9EFBF77E11517
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      unzip && \
    rm -rf /var/lib/apt/lists/*

RUN wget -nv http://www.latofonts.com/download/Lato2OFL.zip && unzip Lato2OFL.zip -d /usr/share/fonts

COPY fonts.conf /etc/fonts/conf.d/100-athena.conf
COPY aer.ttf /usr/share/fonts
RUN fc-cache -f -v
