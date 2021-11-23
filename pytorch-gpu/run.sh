#!/bin/bash

export COMPOSE_PROJECT_NAME=$(whoami) 

docker-compose $*