#!/bin/bash

PATH_DOCKERFILE=$(readlink -f ./Dockerfile)
ARGS_DOCKER=""

if [[ $# -ge 1 ]]; then
    if [ -f $1 ]; then
        PATH_DOCKERFILE=$(readlink -f $1)
    else
        ARGS_DOCKER=$1
    fi
fi

if [[ $# -ge 2 ]]; then
    ARGS_DOCKER=$2
fi

if [ ! -f ${PATH_DOCKERFILE} ]; then
    echo "File not found: ${PATH_DOCKERFILE}"
    exit 1
fi

#echo "run ${PATH_DOCKERFILE} ${ARGS_DOCKER}"

DOCKER_IMAGE_NAME=("autoimagename_"$(md5sum ${PATH_DOCKERFILE}))

if [ ! -f /.dockerenv ]; then
    if [ -z "$(docker images -q ${DOCKER_IMAGE_NAME} 2> /dev/null)" ]; then
        docker build -t ${DOCKER_IMAGE_NAME} -f "${PATH_DOCKERFILE}" .
    fi
    #docker run -it --user $(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd) ${ARGS_DOCKER} ${DOCKER_IMAGE_NAME} /bin/bash
    docker run -it -v $(pwd):$(pwd) -w $(pwd) ${ARGS_DOCKER} ${DOCKER_IMAGE_NAME} /bin/bash
else
    echo ""
    #build backend
    #echo "cmake -S ./backend/ -B /tmp/build -DCMAKE_TOOLCHAIN_FILE=/tmp/toolchain/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release"
    #echo "cmake --build /tmp/build/ -j"
fi
