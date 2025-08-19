#!/bin/bash

print_help() {
    echo "Usage: $0 -c <command> -p <pipe filepath>"
    echo ""
    echo "vim command to use: :autocmd BufWritePost * silent! !echo \"p\" > ~/pipe &"
}

CMD=""
PIPE=""
#HELP=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -h)
      HELP=1
      shift
      ;;
    -c|--command)
      CMD="$2"
      shift # past argument
      shift # past value
      ;;
    -p|--pipe)
      PIPE="$2"
      shift
      shift
      ;;
    *)
      echo "Unknown option $1"
      shift
      ;;
  esac
done

if [ -n "${HELP}" ]; then
    print_help
    exit
fi

if [ -z "${CMD}" ] || [ -z "${PIPE}" ]; then
    print_help
    exit
fi

if ! [ -p ${PIPE} ]; then
    echo "Building pipe ${PIPE}"
    mkfifo ${PIPE}
else
    echo "Pipe ${PIPE} exists, reusing"
fi

PIPE=$(readlink -f ${PIPE})

echo "Use nvim script: :autocmd BufWritePost * silent! !echo \"p\" > ${PIPE} &"

while true
do
    while read i
    do
        echo -n "";
    done < ${PIPE};
    echo "-> ${CMD}"
    ${CMD}
done

