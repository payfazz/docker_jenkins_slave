#!/bin/sh

set -eu

if [ "$(id -u)" = "0" ]; then
  exec 0</dev/null
  exec 1>>/logs/out.txt
  exec 2>>/logs/err.txt
  chown jenkins:jenkins -R /logs /jenkins
  export HOME=$(getent passwd jenkins | cut -d: -f6)
  UID=$(id -u jenkins)
  GID=$(id -g jenkins)
  GIDS=",$GID"
  DOCKER_GID=$(stat -c %g /var/run/docker.sock 2>/dev/null || :)
  if [ -n "$DOCKER_GID" ]; then
    GIDS="$GIDS,$DOCKER_GID"
  fi
  exec swuser $UID,$GID$GIDS docker_pid1 "$0"
  exit 1
fi

cd /jenkins

if [ -z "${JENKINS_URL:-}" ]; then
  echo "JENKINS_URL is not set" >&2
  exit 1
fi
JENKINS_URL="${JENKINS_URL%/}/"

if [ -z "${NODE_NAME:-}" ]; then
  echo "NODE_NAME is not set" >&2
  exit 1
fi

if [ -z "${SECRET:-}" ]; then
  echo "SECRET is not set" >&2
  exit 1
fi
echo "$SECRET" > secret.txt
( ( sleep 10; rm secret.txt ) & ) &
unset SECRET

curl -sSLf -o agent.jar "${JENKINS_URL}jnlpJars/agent.jar"
exec java -jar agent.jar -jnlpUrl "${JENKINS_URL}computer/${NODE_NAME}/slave-agent.jnlp" -secret @secret.txt
