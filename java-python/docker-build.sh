#!/bin/bash

docker container prune -f
docker rmi $(sudo docker images -f "dangling=true" -q)
DOCKER_BUILDKIT=0 docker build -t amithkoujalgi/ubuntu-java-python-nginx-php-node:1.0.0 .