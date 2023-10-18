FROM cm2network/steamcmd:root

ENV STEAM_USER anonymous 
ENV STEAM_PASSWORD anonymous

COPY startServer.sh /home/steam/arma3/
COPY server.cfg /home/steam/arma3/

# Install additional packages #
RUN set -x \ 
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget  \
    && apt-get remove --purge -y \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /home/steam/arma3/server/configs/profiles \
    && chown -R steam:steam /home/

USER steam

WORKDIR /home/steam/arma3/server/

VOLUME ["/home/steam/arma3/server"]

EXPOSE 2302/udp 2303/udp 2304/udp 2306/udp 

CMD [ "/home/steam/arma3/startServer.sh" ]