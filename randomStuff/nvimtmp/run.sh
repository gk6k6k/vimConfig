#!/bin/bash

md5=("autoimagename_"$(md5sum Dockerfile))

if [ ! -f /.dockerenv ]; then
    if [ -z "$(docker images -q ${md5} 2> /dev/null)" ]; then
        docker build -t ${md5} .
    fi
    docker run -it -v $(pwd):$(pwd) -w $(pwd) -p 3000:3000 -p 3001:3001 ${md5} /bin/bash
else
    #build backend
    cmake -S ./backend/ -B /tmp/build -DCMAKE_TOOLCHAIN_FILE=/tmp/toolchain/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
    cmake --build /tmp/build/ -j
fi


