# Getting Started with Docker

- [INTRODUCTION](#course-introduction)
- [INSTALLING DOCKER](#installing-docker)
- [WORKING WITH CONTAINERS](#working-with-containers)

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