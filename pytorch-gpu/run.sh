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
*)
    docker-compose $1 $2
    ;;
esac