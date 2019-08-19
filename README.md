# What is this ?

Docker image for jenkins slave, specialized for building with docker environment

## What is included ?

This image inlucde:
- java 8 jre (needed for jenkins slave)
- docker cli
- ssh client
- stdiotunnel
- rsync

## How to use ?

The environment variable:
- `JENKINS_URL`, where is the jenkins master, exampe: `https://jenkins.example.com`
- `NODE_NAME`, what the name of this node, example: `mynode-1`
- `SECRET`, secret code that will be used to connect to master, example: `fffcd095b0a6479abf9374b4abbb816873c351b8c99f641a5ff257643724abcb`

example:

    docker run --rm -e JENKINS_URL=https://jenkins.example.com -e NODE_NAME=mynode-1 -e SECRET=fffcd095b0a6479abf9374b4abbb816873c351b8c99f641a5ff257643724abcb -v /var/run/docker.sock:/var/run/docker.sock wint/jenkins_slave


This image intended to forward docker socket on the host (that is why we include docker-cli), it mean that the container is gain root access to the host.

So do not run another service inside this instance machine.

The only way to isolate this node is to isolate the instance vm.
