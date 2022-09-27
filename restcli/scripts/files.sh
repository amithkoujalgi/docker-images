#!/bin/bash

if [[ -z "${SOURCE}" ]]; then
  SOURCE=/home/ubuntu/api-tests
else
  echo "Using SOURCE=${SOURCE} from env var..."
fi

sudo mkdir -p /home/ubuntu/api-tests/test-reports
sudo chmod -R 777 /home/ubuntu/api-tests
cd /home/ubuntu/api-tests/ || exit
python3 /home/ubuntu/scripts/line_clean.py

if [[ -d $SOURCE ]]; then
  for file in "$SOURCE"/*; do
    if [[ $file == *http ]]; then
      java -jar /home/ubuntu/restcli.jar --insecure --env-dir=/home/ubuntu/api-tests/ --log-level BODY --env $TEST_ENV $file
    else
      echo ""
    fi
  done
elif [[ -f $SOURCE ]]; then
  java -jar /home/ubuntu/restcli.jar --insecure --env-dir=/home/ubuntu/api-tests/ --log-level BODY --env $TEST_ENV $SOURCE
else
  echo "$SOURCE is not valid"
  exit 1
fi
