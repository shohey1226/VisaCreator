#!/bin/bash

export PLENV_ROOT=/opt/perl5
export PATH=$PATH:$PLENV_ROOT/bin;
eval "$(plenv init -)"

MOJO_MODE=qa plackup --port 5000 ./script/app.psgi
