#!/bin/bash

#SOURCE=${BASH_SOURCE[0]}
#while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
#  DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
#  SOURCE=$(readlink "$SOURCE")
#  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
#done
#DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
#TESTS_DIR=$DIR/tests
SCRIPT_FILE_NAME=$(basename "$0")

function usage() {
  printf "\nInvalid arguments provided! \n\n[Usage]: ./$SCRIPT_FILE_NAME <tests-directory-path> <test-http-file> <env>"
  printf "\n\n[Example]: ./$SCRIPT_FILE_NAME /home/someuser/tests get-requests.http dev\n\n"
  exit 1
}

if [ $# == 0 ]; then
  usage
fi

if [ $# != 3 ]; then
  usage
fi

TESTS_DIR=$1
TESTS_HTTP_FILE=$2
TESTS_ENV=$3

if [ ! -d "$TESTS_DIR" ]; then
  echo "$TESTS_DIR does not exist."
fi

echo "Mounting $TESTS_DIR on to /home/ubuntu/api-tests..."

docker run -it \
  -e TEST_ENV=$TESTS_ENV \
  -e TEST_SRC_FILE=$TESTS_HTTP_FILE \
  -v $TESTS_DIR:/home/ubuntu/api-tests \
  api-tests:1.0