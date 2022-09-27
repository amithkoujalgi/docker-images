#!/bin/bash

#SOURCE=${BASH_SOURCE[0]}
#while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
#  DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
#  SOURCE=$(readlink "$SOURCE")
#  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
#done
#DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
#MOUNT_PATH=$DIR/tests
SCRIPT_FILE_NAME=$(basename "$0")

function usage() {
  printf "\nInvalid arguments provided! \n\n[Usage]: ./$SCRIPT_FILE_NAME <tests-directory-path> <test-http-file-or-dir> <env>"
  printf "\n\n[Example]: ./$SCRIPT_FILE_NAME /home/someuser/tests get-requests.http dev\n\n"
  exit 1
}

if [ $# == 0 ]; then
  usage
fi

if [ $# != 3 ]; then
  usage
fi

MOUNT_PATH=$1
SOURCE=$2
TESTS_ENV=$3

if [ ! -d "$MOUNT_PATH" ]; then
  echo "$MOUNT_PATH does not exist."
fi
pwd
pip install -r app/requirements.txt
echo "Mounting $MOUNT_PATH on to /home/ubuntu/api-tests..."

#docker run -it \
#  -e MODE=files \
#  -e SOURCE="$SOURCE" \
#  -e TEST_ENV="$TESTS_ENV" \
#  -v "$MOUNT_PATH":/home/ubuntu/api-tests \
#  api-tests:1.0

docker run -it \
  -e MODE=server \
  -p 8000:8000 \
  api-tests:1.0
