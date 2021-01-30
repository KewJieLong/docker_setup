FROM tensorflow/tensorflow:1.15.2-gpu-py3 
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get install -y libsm6 libxext6 libxrender-dev
RUN apt update && apt install -y libsm6 libxext6
RUN apt install nano
RUN apt install -y git
RUN apt-get install -y tmux
RUN apt-get install -y htop

COPY start_tmux_script.sh .
COPY requirements.txt .

RUN pip3 install -r requirements.txt