#!/bin/bash

print_help() {
    echo "Usage: $0 -f <file> -r"
    echo ""
    echo "-f <Dockerfile path> Default: ./Dockerfile"
    echo "-r force recreate container"
    echo "-v verobse"
}

vecho() {
    if [[ ${VERBOSE} -eq 1 ]]; then
        echo "$@"
    fi
}

HELP=0
VERBOSE=0
REBUILD=0
DOCKER_IMAGE_SOURCE_FILE=$(readlink -f ./Dockerfile)
DOCKER_IMAGE_NAME=""
DOCKER_CONTAINER_NAME=""
DOCKER_ARGS_RUN=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -h)
      HELP=1
      shift
      ;;
    -v)
      VERBOSE=1
      shift
      ;;
    -f)
      DOCKER_IMAGE_SOURCE_FILE="$2"
      shift
      shift
      ;;
    -r)
      REBUILD=1
      shift
      ;;
    *)
      echo "Unknown option $1"
      shift
      ;;
  esac
done

if [[ ${HELP} -eq 1 ]]; then
    print_help
    exit
fi

DOCKER_IMAGE_NAME=("autoimagename_"$(md5sum ${DOCKER_IMAGE_SOURCE_FILE}))
DOCKER_CONTAINER_NAME="${USER}_${DOCKER_IMAGE_NAME}"

vecho "REBUILD=${REBUILD} DOCKER_IMAGE_SOURCE_FILE=${DOCKER_IMAGE_SOURCE_FILE} DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME} DOCKER_CONTAINER_NAME=${DOCKER_CONTAINER_NAME}"

if [ -z "$(docker images -q ${DOCKER_IMAGE_NAME} 2> /dev/null)" ]; then
  vecho "Building image ${DOCKER_IMAGE_NAME}"
  docker build -t ${DOCKER_IMAGE_NAME} -f "${PATH_DOCKERFILE}" .
fi

if docker inspect "${DOCKER_CONTAINER_NAME}" > /dev/null 2>&1; then
  vecho "${DOCKER_CONTAINER_NAME} exists."
  if [[ ${REBUILD} -eq 1 ]]; then
    vecho "Removing container ${DOCKER_CONTAINER_NAME}"
    docker container rm ${DOCKER_CONTAINER_NAME}
    docker run -it --name ${DOCKER_CONTAINER_NAME} -v $(pwd):$(pwd) -w $(pwd) ${DOCKER_ARGS_RUN} ${DOCKER_IMAGE_NAME} /bin/bash
  else
    vecho "Reconnecting to container ${DOCKER_CONTAINER_NAME}"
    if $(docker inspect -f '{{.State.Status}}' "${DOCKER_CONTAINER_NAME}" | grep -q "running"); then
      docker attach "${DOCKER_CONTAINER_NAME}"
    else
      docker start "${DOCKER_CONTAINER_NAME}"
      docker attach "${DOCKER_CONTAINER_NAME}"
    fi
  fi
else
  docker run -it --name ${DOCKER_CONTAINER_NAME} -v $(pwd):$(pwd) -w $(pwd) ${DOCKER_ARGS_RUN} ${DOCKER_IMAGE_NAME} /bin/bash
fi

