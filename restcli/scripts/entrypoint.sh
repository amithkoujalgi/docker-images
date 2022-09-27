#!/bin/bash

if [[ -z "${MODE}" ]]; then
  echo "MODE env var not specified. Available modes: server, files"
  exit 1
else
  echo "Using MODE=${MODE}"
  if [[ "${MODE}" == "server" ]]; then
    cd /home/ubuntu/app
    python3 app_server.py
  elif [[ "${MODE}" == "files" ]]; then
    cd /home/ubuntu/scripts || exit
    if [[ "${SOURCE}" == "/" ]]; then
      export SOURCE=
    fi
    bash files.sh
  else
    echo "Invalid mode. Exiting..."
    exit 1
  fi
fi
