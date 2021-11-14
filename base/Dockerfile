FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

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
    && echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt-get update && apt-get remove -y openssh-server --purge && apt-get install -y openssh-server wget git sudo \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config \
    && mkdir -p /run/sshd \
    && pip3 install --upgrade pip -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com \
    && pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple/ \
    && pip3 config set install.trusted-host mirrors.aliyun.com \
    && pip3 install transformers tqdm wandb datasets \
    && rm -rf /usr/bin/python3 /usr/bin/python3-config \
    && ln -s /opt/conda/bin/python3 /usr/bin/python3 \
    && ln -s /opt/conda/bin/python3-config /usr/bin/python3-config \
    && apt-get clean \
    && rm -rf ~/.cache/pip

ENTRYPOINT ["/bin/bash"]