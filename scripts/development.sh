#!/bin/bash

# Arbitrary shell commands, some run in background
./scripts/compile.sh &
node ./scripts/web-server.js

# The magic line
#   $$ holds the PID for this script
#   Negation means kill by process group id instead of PID
trap "kill -TERM -$$" SIGINT
wait
