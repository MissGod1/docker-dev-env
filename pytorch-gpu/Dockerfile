FROM missgod1/pytorch:1.9.0-cuda11.1-cudnn8-runtime

ARG NAME
ARG UID
ARG PASSWORD

# add user
RUN useradd -m -s /bin/bash -u $UID $NAME \
    && usermod -aG sudo $NAME \
    && echo "$NAME:$PASSWORD" | chpasswd
# RUN service ssh start
# RUN echo "$NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /workspace

USER root

ENTRYPOINT ["/usr/sbin/sshd", "-D"]