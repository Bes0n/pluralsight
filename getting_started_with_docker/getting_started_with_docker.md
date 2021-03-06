# Getting Started with Docker

- [INTRODUCTION](#course-introduction)
- [INSTALLING DOCKER](#installing-docker)
- [WORKING WITH CONTAINERS](#working-with-containers)
- [SWARM MODE AND MICROSERVICES](#swarm-mode-and-microservices)


## Course Introduction
### Introduction

Course agenda: 
* Intall Docker 
* Working with Containers 
* Working with Apps

## Installing Docker 
### Module Intro
We will look for:
* Desktop installs 
* Server installs 
* Cloud installs 
  * Docker Azure
  * Docker AWS
  
### Docker for Windows
Pre-reqs:
* Window 10 
* 64-bit
* Clean(ish) install 

Use cases:
* Test
* Dev
 
Docker is a running Linux virtual Machine on Hyper-V called MobiLinux

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img1.JPG)

How to install Docker?

* Enable Hyper-V feature from Program and Features 
* If hardware virtualizaion is not running on your PC - enable it from BIOS
* Download Docker for Windows
* Check your version after Docker installation: *docker version*

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img2.JPG)

You can see on screenshot that Client - windows/amd64, where docker is installed and Server - linux/amd64, our virtual linux machine. 

### Docker for Mac
Pre-reqs and how docker installs on Mac

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img3.JPG)

How to install Docker?
* Download Docker for Mac from Website. 
* Run installation, move Docker App to Application folder
* Wait until Docker will warm up
* Docker on Mac will work only with linux containers 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img4.JPG)


### Docker for Windows Server 2016 
Described instructions in course outdated, instead go to https://hub.docker.com/editions/enterprise/docker-ee-server-windows

### Docker for Linux
For ubuntu run simple command:
* ``` wget q-o- https://get.docker.com/ | sh ``` 
* ``` wget q-o- https://test.docker.com/ | sh ``` - for release candidate (rc) builds
* ``` wget q-o- https://experimental.docker.com/ | sh ``` - for rc build with experimental features 

After installation if you're planning to use Docker as a non root user. you should add your user to the "docker" group with something like:
``` sudo usermod -aG docker your-user ```

## Working with Containers
### What Is a Container?

So, hypervisor virtualization virtualizes physical server resources and builds virtual machines. Container engines like Docker, they're more like operating system virtualization, they create virtual operating systems, assign one to each container, inside of which we run applications. And they're way more lightweight than VMs. 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img5.JPG)

### The 'docker run' Command
First useful commands:
* ``` docker version ```
* ``` docker info ``` - you can see all information about docker, containers, images and so on 
* ``` docker run hello-world ``` - looking for image, couldn't find it and pull image, download,install and create a container

* ``` docker ps ``` - get list of running containers 
* ``` docker images ``` - get list of images 

### Theory of Pulling and Running Containers
Logic is simple:
* Client ask for daemon to run *hello world* image. 
* Daemon replies that images not found and check on docker hub is this image exists
* Daemon pull an image and run a container with that image, execute command and then stops the container, with leaving downloaded image. 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img6.JPG)

### Working with Images
Images ~ Stopped containers
Containers ~ Running Images 

* ``` docker pull ``` - pull an image without running container
* ``` docker pull ubuntu:14.04```  - pull image with defined version 
* ``` docker rmi ubuntu:14.04 ``` - remove your image with tag 

### Container Lifecycle
You can start stop container - without loosing your data. 
Container is like a VMs - start, stop, restart. 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img7.JPG)

Let's execute following command: 
* ``` docker run -d --name web -p 80:8080 nigelpoulton/pluralsight-docker-ci``` - where *-d* means detached mode, don't interfere with your terminal. *--name* name of the container, *-p* is a port 

* Port 80 is local and port 8080 is container port. Like a redirection to container 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img8.JPG)

* ``` docker run -it --name temp ubuntu:latest /bin/bash ``` - run container in interactive mode with image ubuntu and execute bash shell 
* ``` Ctrl + P + Q ``` - exit from container without killing it 

* ``` docker stop name or container id ``` - stop running container 

* ``` docker stop $(docker ps -aq) ``` - stop all containers listed by *docker ps -a* and be quiet - *-q* 

### Lesson Recap

* ``` docker run <image> ``` 
* ``` docker run -d/-it <image> ``` - detached or interactive 

* ``` docker pull ```
* ``` docker images ```
* ``` docker rmi ```

* ``` docker ps ```
* ``` docker stop ```
* ``` docker rm ```

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img9.JPG)

## Swarm Mode and Microservices
### Module Intro
Plan: 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img10.JPG)

### Swarm Mode Theory
Docker clustering is true native clustering - called SWARM 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img11.JPG)

Below is an example of running service with 5 replicas 
``` $ docker service create --name web-fe --replicas 5 ```

### Configuring Swarm Mode
* ``` docker swarm init --advertise-addr 172.31.12.161:2377 --listen-addr 172.31.12.161:2377``` - enable docker swarm mode 
* Ports:
  * Engine port: 2375
  * Secure Engine port: 2376 
  * Swarm port: 2377 
  
To join node into the swarm you just need to enter ``` docker swarm join-token manager ``` or ``` docker swarm join-token worker ```

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img12.JPG)

Manager nodes doing 2 jobs: as a manager node and worker node. 

### Services
* For register service with swarm 
``` docker service create --name psight1  -p 8080 --replicas 5 nigelpoulton/pluralsight-docker-ci ```
* For checking service status:
  * ``` docker service ps psgiht1 ``` 
  * ``` docker service inspect psight1 ```
  
![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img13.JPG)  

### Scaling Services
If some node falls down, docker scale service trying to compensate failed node with working. 

``` docker service scale >> docker service update --replicas ``` 

* you can change replicas scale by entering command:
``` docker service update --replicas 10 psight1 ```

### Rolling Updates
* let's create new network:
``` docker network create -d overlay ps-net ``` - network name ps-net 
* register new service:
docker service create --name psight2 --network ps-net -p 80:80 --replicas 12 nigepoulton/tu-demo:v1

* to inspect your service:
``` docker service inspect --pretty psight2 ``` 

* for update service, we have to run following command:
``` docker service update --image nigelpoulton/tu-demo:v2 --update-parallelism 2 \ --update-delay 10s psight2 ```

### Stacks and Distribution Application Bundles 
* *Stack* - application made up of multiple services and we deploy these stacks from what we're calling DAB files, distributed application bundles. 

![img](https://github.com/Bes0n/pluralsight/blob/master/getting_started_with_docker/images/img14.JPG)  

* we have to push our images on docker hub and store their names in docker-compose.yml file with *image:* name 
* then we're creating bundle ``` docker-compose bundle ```
* stack creation: ``` docker stack deploy voteapp ```
* get list of the docker stack tasks: ``` docker stack tasks voteapp```
* to inspect your service ``` docker service inspect voteapp_vote
* clear everything from stack: ``` docker stack rm voteapp```

### Recap 
* ``` docker swarm init ``` - initiate docker swarm 
* ``` docker swarm join ``` - join swarm from other nodes 
* ``` docker service create ``` - create a service inside a swarm
* ``` docker service scale ``` - change how many services need to run 
* ``` docker service update ``` - make an update of your running service
* ``` docker stack deploy ``` - deploy stack with combined services in your swarm 
