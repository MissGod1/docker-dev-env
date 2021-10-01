ARG VERSION

FROM huggingface/transformers-pytorch-$VERSION

ARG NAME
ARG UID
ARG PASSWORD

# Add aliyun apt-get
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list

# Install application
RUN apt-get update
RUN apt-get remove -y openssh-server --purge
RUN apt-get install -y openssh-server wget git sudo

# Configure ssh
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
RUN mkdir -p /run/sshd

# add user
RUN useradd -m -s /bin/bash -u $UID $NAME
RUN usermod -aG sudo $NAME
RUN echo "$NAME:$PASSWORD" | chpasswd
# RUN service ssh start
RUN echo "$NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#Configure jupyter
USER $NAME

# Add aliyun pipy
RUN pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
RUN pip config set install.trusted-host mirrors.aliyun.com

# Install python module
RUN pip install --upgrade pip
RUN pip install jupyterlab jupyterlab-lsp python-lsp-server[all]
RUN pip install ipympl ipywidgets xeus-python jupyterlab-system-monitor lckr-jupyterlab-variableinspector

RUN PATH=$PATH:~/.local/bin jupyter lab --generate-config

RUN p=$(python3 -c "from notebook.auth import passwd; print(passwd('$PASSWORD', 'sha1'))") \
    && sed -i "s/#c.ServerApp.password = ''/c.ServerApp.password = '$p'/g" ~/.jupyter/jupyter_lab_config.py
RUN sed -i "s/#c.ServerApp.password_required = False/c.ServerApp.password_required = True/g" ~/.jupyter/jupyter_lab_config.py

WORKDIR /workspace

COPY entrypoint.sh /tmp/

# USER root
# ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0"]
ENTRYPOINT ["/tmp/entrypoint.sh"]