FROM nginx:1.13.6-alpine

ARG RIOT_WEB_VERSION="0.13.4"

RUN set -ex \
    && apk add --update \
        ca-certificates \
        openssl \
        bash \
    && update-ca-certificates \
    && cd /tmp \
    && wget https://github.com/vector-im/riot-web/releases/download/v${RIOT_WEB_VERSION}/riot-v${RIOT_WEB_VERSION}.tar.gz \
    && tar -xzvf riot-v${RIOT_WEB_VERSION}.tar.gz \
    && mkdir -p /var/www \
    && mv riot-v${RIOT_WEB_VERSION} /var/www/riot \
    && cp /var/www/riot/config.sample.json /var/www/riot/config.json \
    && apk del ca-certificates openssl \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

COPY default.conf /etc/nginx/conf.d/default.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
