#!/bin/bash

if [[ -n $USERNAME ]] && [[ -n $PASSWORD ]];then
    useradd -m -s /bin/bash $USERNAME
    usermod -aG sudo $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
fi

/usr/sbin/sshd -D