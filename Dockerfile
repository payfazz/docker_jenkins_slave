FROM alpine

RUN set -eux \
 && apk -U add bash curl docker-cli git make openjdk8-jre openssh-client rsync \
 && curl -sSLf https://raw.githubusercontent.com/payfazz/docker-sh/master/install.sh | sh \
 && curl -sSLf -o /usr/local/bin/stdiotunnel https://github.com/payfazz/stdiotunnel/releases/download/v1.0.3/stdiotunnel-linux-x86_64 \
 && chmod 755 /usr/local/bin/stdiotunnel \
 && curl -sSLf -o /usr/local/bin/docker_pid1 https://github.com/win-t/docker_pid1/releases/download/v3.2.0/docker_pid1 \
 && chmod 755 /usr/local/bin/docker_pid1 \
 && curl -sSLf -o /usr/local/bin/swuser https://github.com/win-t/switch-user/releases/download/v1.0.0/swuser \
 && chmod 755 /usr/local/bin/swuser \
 && adduser -h /jenkins -D jenkins \
 && mkdir /logs \
 && ln -sf /dev/stdout /logs/out.txt \
 && ln -sf /dev/stderr /logs/err.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
