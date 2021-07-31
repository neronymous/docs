#!/bin/bash

docker build . -t nero-docs:latest
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs nero-docs
