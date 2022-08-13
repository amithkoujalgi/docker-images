#!/bin/bash

docker run \
  -p 8000:8000 \
  -p 8020:8020 \
  -it amithkoujalgi/ubuntu-java-python-nginx-php-node:1.0.0
