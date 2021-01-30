# docker build --tag deeplearning .
docker run -it -v /kew:/kew --shm-size 50G --gpus all -d --name deeplearning deeplearning:latest
docker exec -it  deeplearning /bin/bash