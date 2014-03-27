#!/bin/bash

MOJO_MODE=development carton exec -- plackup ./script/app.psgi
