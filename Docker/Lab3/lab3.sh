# Task 1 Step 4
docker run -it --name my-volume-test -v data-volume:/data centos:8 /bin/bash 

# Task 2 Step 8
docker run -it -v /home/ubuntu/docker-folder:/var/myfiles/ centos:8 /bin/bash

# Task 4 Step 4a
docker run -itd --name container1 ubuntu-with-ping

# Task 4 Step 4b
docker run -itd --name container2 ubuntu-with-ping

# Task 4 Step 12
docker container stop container1 container2

docker container rm container1 container2