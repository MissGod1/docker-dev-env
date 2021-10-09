#!/bin/bash

export COMPOSE_PROJECT_NAME=$(whoami) 

case $1 in
build)
    read -p 'Please set user password:' password
    docker-compose build \
    --build-arg NAME=$(whoami) \
    --build-arg PASSWORD=$password \
    --build-arg UID=$(id -u)
    ;;
start)
    if [ ! -d "code/" ];then
        mkdir code
    fi
    docker-compose up
    ;;
remove)
    docker-compose down
    ;;
*)
    echo "$0 [build|start|remove]"
    ;;
esac