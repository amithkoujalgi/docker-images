#!/bin/bash

docker container prune -f
docker rmi $(sudo docker images -f "dangling=true" -q)
DOCKER_BUILDKIT=0 docker build -t api-tests:1.0 .