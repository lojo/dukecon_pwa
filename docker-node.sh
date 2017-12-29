#!/bin/bash

tty_option=""
tty -s && tty_option="-t"

goal="npm install && npm run build && npm run unit"
test $# -gt 0 && goal="$@"

exec docker run -i ${tty_option} --rm \
  -v "$PWD":/usr/src \
  -w /usr/src \
  dukecon/dukecon-node:latest \
  /bin/sh -c "${goal}"
