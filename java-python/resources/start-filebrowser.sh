#!/bin/bash

if [[ -z "${FILEBROWSER_PORT}" ]]; then
  echo "FILEBROWSER_PORT env var not set. Defaulting to 8020..."
  FILEBROWSER_PORT=8020
else
  echo "Using FILEBROWSER_PORT=${FILEBROWSER_PORT} from env var..."
fi

filebrowser \
  --address 0.0.0.0 \
  --port $FILEBROWSER_PORT \
  --username root \
  --password $(filebrowser hash root) \
  -r /