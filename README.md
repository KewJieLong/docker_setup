## Usage of Docker

The idea of using Docker is we can first [build](#build-docker-image) a docker images where act as virtual machine, and
this Virtual machine is configured and installed all the dependency / library for our code to run. Once we make the
docker work in one computer instance, we can easily [export](#export-docker-image) the workable docker image to another instance.
While in another instance, we just need to [import](#import-docker-image) and [create](#start-container-with-image) a
docker container with the images. Lastly, we just need to [ssh](#ssh-into-docker) into the docker container, it will
just work as your first instance.


## Build Docker image

### Prepare Dockerfile

In order to build the docker image, we need to prepare Dockerfile. You can find hte Dockerfile in script folder. In your
terminal, cd into script folder and run the command below.

```
docker build --tag deeplearning .
```

For example, the script above will use the Dockerfile to create a docker image called **deeplearning**. You can create
your own Dockerfile and build your own Docker.

## Break down of Dockerfile

In this section, we briefly go through how to prepare a Dockerfile

```
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
```

1) First, we need to define which docker images to use. There are a lot of different varieties to use in
   [Docker Hub](https://hub.docker.com/), For example, you can search for ubuntu official docker image, and do
   `FROM ubuntu:18.04`, which then the docker will use ubuntu images to create the image for you. You can treat it as a
   OS for your virtual machine. In the sample scripts, we use `FROM tensorflow/tensorflow:1.15.2-gpu-py3`, which is a
   family member of tensorflow version 1.15 GPU version.
   
2) Next, we install some library such as `nano` for editing, `tmux` for terminal control, `htop` for observing CPU
   usage and other library for cv2 to work probably.
   
3) You may also copy some scripts into your docker image, in the sample, we copy `start_tmux_script.sh`
   and `requiements.txt`, which we use `start_tmux_script.sh` to start our split screen and multi windows,
   while `requirements.txt` is used to installed python library.
   
4) Lastly, we install the python library by `RUN pip3 install -r requirements.txt`

Note that we avoid to use root user in docker as if we use root user in docker, all the file created in the docker container 
will be belong to root user, which we will need to have root user access to delete/modify the file.  

## Export docker image
Once the docker is built, we can export by doing:

```
docker save -o deeplearning_image_tarfile.tar deeplearning
```
This command will save the **deeplearning** image as **deeplearning_image_tarfile.tar**.  


## Import docker image
Once the docker image is exported. we can import the docker image by doing:
```
docker load < deeplearning_image_tarfile.tar
```
This command will load the **deeplearning_image_tarfile.tar** as a docker image named **deeplearning**.


## start container with image

Start the docker container with **deeplearning** docker images. 
```
docker run -it -v /kew:/kew --shm-size 50G --gpus all -d --name deeplearning deeplearning:latest
```
This command will start a docker container with **deeplearning** image under the container name of **deeplearning**. 

`-i`: Keep STDIN open even if not attached

`-t`: Allocate a pseudo-tty

`-v`: mount point for the docker container and the computer storage. E.g: in ths script above, i mount `/kew` in my 
local machine to `/kew` in the docker container. So that i can access `/kew` folder in my docker container.

`--gpus all`: Which gpu is accessible to the docker container 

`-d`: Start the docker container in detach mode

`--shm-size 50G`: to avoid pytorch shared memory issue

`--name`: name for the docker container


## ssh into docker
```
docker exec -it deeplearning /bin/bash
```

## Docker images command

#### Do `docker image -a` show built docker images

#### Do `docker rmi IMAGE_ID` to remove the docker image. IMAEG_ID is obtained from `docker image -a `


## Docker container command

#### Do `docker ps -a` to show all docker container 

#### Do `docker container rm CONTAINER_ID` to remove the container. CONTAINER_ID is obtained from `docker ps -a`

## Docker proxy issue

We are not sure the reason, but sometime we might suffer internet issue where the docker container do not have internet
connection. We follow the solution
at [stackoverflow](https://stackoverflow.com/questions/61552339/pip-install-not-working-inside-docker-container)
to solve the problem.

The solution is as follow:

Create a /etc/docker/daemon.json with the following content:

```
{
  "dns": ["myDNS"]
}

```

Where the *myDNS* is obtained using the following:

```
nmcli dev show | grep 'DNS'
```



 