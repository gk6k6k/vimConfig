#!/bin/bash
REPO_PATH=$(pwd)
SCRIPT_PATH=$(dirname $0)
MDSUM=($(md5sum ${SCRIPT_PATH}/Dockerfile))
IMAGE_NAME="autodoc_"$MDSUM"image"
CONTAINER_NAME=${IMAGE_NAME}_container

PARRENT_IMAGENAME=$($SCRIPT_PATH/dockerRun.sh -i)

if ! [ $(docker images ${IMAGE_NAME} | grep $IMAGE_NAME | wc -l) = "1" ]
then
    docker build $SCRIPT_PATH -t ${IMAGE_NAME} --build-arg IMAGE_NAME=${PARRENT_IMAGENAME}
fi

if [ ! $(docker container ls | grep ${CONTAINER_NAME} | wc -l) = "1" ]
then
    VOLUMES="--volume /tmp/.X11-unix:/tmp/.X11-unix"
    if test -f "${REPO_PATH}/dockerVolume.sh"
    then
        for i in $(/bin/bash $REPO_PATH/dockerVolume.sh)
        do
            VOLUMES="${VOLUMES} --volume $i"
        done
    fi

    docker container run --rm $VOLUMES --env DISPLAY=$DISPLAY --interactive --tty --name ${CONTAINER_NAME} ${IMAGE_NAME}
else
    docker exec --env DISPLAY=$DISPLAY --interactive --tty ${CONTAINER_NAME} /bin/bash
fi

