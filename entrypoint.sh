#!/bin/bash
sudo service ssh start
PATH=$PATH:~/.local/bin jupyter lab --ip=0.0.0.0