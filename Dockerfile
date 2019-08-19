FROM alpine

RUN set -eux \
 && apk -U add bash curl docker-cli openjdk8-jre rsync \
 && curl -sSLf -o /usr/local/bin/stdiotunnel https://github.com/payfazz/stdiotunnel/releases/download/v1.0.3/stdiotunnel-linux-x86_64 \
 && chmod 755 /usr/local/bin/stdiotunnel \
 && curl -sSLf -o /usr/local/bin/docker_pid1 https://github.com/win-t/docker_pid1/releases/download/v3.1.3/docker_pid1 \
 && chmod 755 /usr/local/bin/docker_pid1 \
 && curl -sSLf -o /usr/local/bin/swuser https://github.com/win-t/switch-user/releases/download/v1.0.0/swuser \
 && chmod 755 /usr/local/bin/swuser \
 && adduser -h /jenkins -D jenkins \
 && mkdir /logs \
 && ln -sf /dev/stdout /logs/out.txt \
 && ln -sf /dev/stderr /logs/err.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]