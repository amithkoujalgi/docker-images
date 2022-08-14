#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
TESTS_DIR=$DIR/tests

echo "Mounting $TESTS_DIR on to /home/ubuntu/api-tests..."
docker run \
  -e TEST_ENV=dev \
  -e TEST_SRC_FILE=get-requests.http \
  -v $TESTS_DIR:/home/ubuntu/api-tests \
  --entrypoint /bin/bash -it api-tests:1.0