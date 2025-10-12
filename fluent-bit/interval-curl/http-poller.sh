#!/bin/sh

# Read SOURCE_URL, DEST_URL, POLL_INTERVAL from environment variables
: "${POLL_INTERVAL:=60}"

while true; do
  curl -X POST -H "Content-Type: application/json" -d "$(curl -s $SOURCE_URL)" $DEST_URL
  sleep $POLL_INTERVAL
done
