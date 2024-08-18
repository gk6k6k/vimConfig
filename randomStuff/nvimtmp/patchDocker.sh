#!/bin/bash
SCRIPT_PATH=$(dirname $0)
md5=("autoimagename_"$(md5sum Dockerfile))
echo "${md5}" "${SCRIPT_PATH}"
docker build $SCRIPT_PATH -t ${md5} --build-arg IMAGE_NAME=${md5}
#
