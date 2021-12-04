#!/bin/bash

if [[ -n $USERNAME ]] && [[ -n $PASSWORD ]] && [[ -n $UID ]];then
    useradd -m -s /bin/bash -u $UID $USERNAME
    usermod -aG sudo $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
fi

/usr/sbin/sshd -D