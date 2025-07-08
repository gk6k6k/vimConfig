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

DOCKER_IMAGE_NAME=("autoimagename_"$(md5sum ${PATH_DOCKERFILE}))

# https://stackoverflow.com/questions/21928691/how-to-continue-a-docker-container-which-has-exited
# docker run --name UserName_date_imageNAme https://stackoverflow.com/questions/57695744/how-to-name-a-container-with-docker-run

if [ ! -f /.dockerenv ]; then
    if [ -z "$(docker images -q ${DOCKER_IMAGE_NAME} 2> /dev/null)" ]; then
        docker build -t ${DOCKER_IMAGE_NAME} -f "${PATH_DOCKERFILE}" .
    fi
    echo "runing iamge ${DOCKER_IMAGE_NAME} ${ARGS_DOCKER}"
    DOCKER_CONTAINER_NAME="${USER}_${DOCKER_IMAGE_NAME}"

    if docker inspect "${DOCKER_CONTAINER_NAME}" > /dev/null 2>&1; then
        echo "${DOCKER_CONTAINER_NAME} exists."

        if $(docker inspect -f '{{.State.Status}}' "${DOCKER_CONTAINER_NAME}" | grep -q "running"); then
            echo "${DOCKER_CONTAINER_NAME} running."

            docker attach "${DOCKER_CONTAINER_NAME}"
        else
            echo "${DOCKER_CONTAINER_NAME} not running."

            docker start "${DOCKER_CONTAINER_NAME}"
            docker attach "${DOCKER_CONTAINER_NAME}"
        fi
    else
        docker run -it --name ${DOCKER_CONTAINER_NAME} -v $(pwd):$(pwd) -w $(pwd) ${ARGS_DOCKER} ${DOCKER_IMAGE_NAME} /bin/bash
    fi
fi
