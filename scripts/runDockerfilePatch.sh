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

PATH_DOCKERFILE_PATCH=$(dirname "$0")/Dockerfile

DOCKER_IMAGE_NAME=("autoimagename_"$(md5sum ${PATH_DOCKERFILE}))
DOCKER_IMAGE_NAME_PATCH=("autoimagenamepatch_"$(md5sum ${PATH_DOCKERFILE_PATCH}))

if [ ! -f /.dockerenv ]; then
    if [ -z "$(docker images -q ${DOCKER_IMAGE_NAME} 2> /dev/null)" ]; then
        docker build -t ${DOCKER_IMAGE_NAME} "${PATH_DOCKERFILE%/*}/"
    fi
    if [ -z "$(docker images -q ${DOCKER_IMAGE_NAME_PATCH} 2> /dev/null)" ]; then
        echo "docker build -t ${DOCKER_IMAGE_NAME_PATCH} $(dirname "$0") --build-arg IMAGE_NAME=${DOCKER_IMAGE_NAME} --build-arg NVIM_INIT_PATH=$(dirname "$0")/../config/init.lua"
        docker build -t ${DOCKER_IMAGE_NAME_PATCH} $(dirname "$0") --build-arg IMAGE_NAME=${DOCKER_IMAGE_NAME} --build-arg NVIM_INIT_PATH=$(dirname "$0")/../config/init.lua
    fi
    #docker run -it --user $(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd) ${ARGS_DOCKER} ${DOCKER_IMAGE_NAME_PATCH} /bin/bash
    docker run -it -v $(pwd):$(pwd) -w $(pwd) ${ARGS_DOCKER} ${DOCKER_IMAGE_NAME_PATCH} /bin/bash
else
    echo ""
fi

