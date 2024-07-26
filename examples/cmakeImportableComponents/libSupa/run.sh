#!/bin/bash

md5=("autoimagename_"$(md5sum Dockerfile))

if [ ! -f /.dockerenv ]; then
    if [ -z "$(docker images -q ${md5} 2> /dev/null)" ]; then
        docker build -t ${md5} .
    fi
    docker run -it -v $(pwd):$(pwd) -w $(pwd) ${md5} /bin/bash
else
    if [ ! -f /tmp/build/Makefile ]; then cmake -S . -B /tmp/build; fi; cmake --build /tmp/build/ -j
fi
