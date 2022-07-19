#!/bin/bash
REPO_PATH=$(pwd)
MDSUM=($(md5sum ${REPO_PATH}/Dockerfile))
IMAGE_NAME="autodoc_"$MDSUM"image"
CONTAINER_NAME=${IMAGE_NAME}_container
PARAM_IMAGENAME=0

while getopts ":hi" opt; do
    case ${opt} in
    i )
      PARAM_IMAGENAME=1
      ;;
    t )
      ;;
    \? ) echo "Usage: cmd [-h] [-t]"
      exit
      ;;
  esac
done

if ! [ $(docker images ${IMAGE_NAME} | grep $IMAGE_NAME | wc -l) = "1" ]
then
    docker build $REPO_PATH -t ${IMAGE_NAME}
fi

if [[ "$PARAM_IMAGENAME" == 1 ]]
then
    echo ${IMAGE_NAME}
    exit
fi

if [ ! $(docker container ls | grep ${CONTAINER_NAME} | wc -l) = "1" ]
then
    VOLUMES="--volume /tmp/.X11-unix:/tmp/.X11-unix" # default volume list
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

#Notes
#Remove all -> docker system prune -a
#kill it -> docker stop NAME # docker_testy_container

