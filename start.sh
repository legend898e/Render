#!/bin/bash

echo "Starting ttyd on port 7681..."

# Start ttyd with a real bash shell
exec ttyd -p 7681 -t titleFixed="Web Terminal" bash -l
