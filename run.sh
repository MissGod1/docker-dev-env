#!/bin/bash

export COMPOSE_PROJECT_NAME=$(whoami) 

case $1 in
build)
    case $2 in
    cpu|gpu)
        # uid=$(id -u)
        # name=$(whoami)
        chmod 777 entrypoint.sh
        read -p 'Please set root & jupyter password:' password
        docker-compose build --build-arg VERSION=$2 \
        --build-arg NAME=$(whoami) \
        --build-arg PASSWORD=$password \
        --build-arg UID=$(id -u) \
        $2
        ;;
    *)
        echo "$0 build cpu|gpu"
        ;;
    esac
    ;;
start)
    case $2 in
    cpu|gpu)
        if [ ! -d "code/" ];then
            mkdir code
        fi
        docker-compose up $2
        ;;
    *)
        echo "$0 start cpu|gpu"
        ;;
    esac
    ;;
remove)
    docker-compose down $2
    ;;
*)
    echo "$0 [build|start|remove] [cpu|gpu]"
    ;;
esac