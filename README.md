## Build Docker image

docker build --tag image_name .

## Export docker image

docker save -o tar_filename.tar image_name 

## Import docker image

docker load < tar_filename.tar

## start container with image

docker run -it -v /kew:/kew --shm-size 50G --gpus all -d --name deeplearning deeplearning:latest

## ssh into docker 

docker exec -it  deeplearning /bin/bash


## Docker proxy issue 

https://stackoverflow.com/questions/61552339/pip-install-not-working-inside-docker-container


