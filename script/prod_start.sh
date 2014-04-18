#!/bin/bash

MOJO_MODE=production carton exec -- plackup -E production -s Starlet --max-workers=10 --port 5000 ./script/app.psgi
