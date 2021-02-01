FROM tensorflow/tensorflow:1.15.2-gpu-py3

ENV username='docker'
ENV password='docker'

COPY start_tmux_script.sh .
COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
#
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y libsm6 libxext6 libxrender-dev
RUN apt update && apt install -y libsm6 libxext6
RUN apt install -y sudo
RUN apt install -y nano
RUN apt install -y git
RUN apt-get install -y tmux
RUN apt-get install -y htop

RUN useradd -m docker && echo "${username}:${password}" | chpasswd && adduser docker sudo
USER docker

RUN echo $password | chsh -s /bin/bash
