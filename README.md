# Lab 06 - Docker

## Objectives

- Gain familiarity with common Docker commands: FROM, RUN, COPY, WORKDIR, CMD

- Understand Docker build cache

- Learn how to run docker containers non-interactively and interactively

- Follow general best practices to make containers reproducible, and lightweight

- Use a bind-mount to persist files generated in a container on the host

## Accept the github classroom repository

Instead of cloning this repo to the SCC, we are instead going to use the github 
codespaces functionality, which allows you to open an integrated development
environment in the cloud using the repository as a template. By default, this
environment is created from an Ubuntu image and pre-installed with a selection 
of popular tools and utilities. 

After you accept the github classroom link, please go directly to the github
repository and click on the large green `code` button. Switch tabs and open a 
codespace. 

## Basic Docker Commands


### Pulling an image
We are going to demonstrate how docker can help us install and run different
versions of python. First, go to [docker hub](https://hub.docker.com) and search
for python in the search bar at the top. The first search result should be the
official python docker image. Click on it to go to the python docker image
page. For now, run the following command in your terminal:

```
docker pull python
```

Use the `docker images` command to view the images you have available on your system.

```
docker images
```

What version of python is installed? Can you tell from the output of the `docker
images` command? (Hint: no, you can't)

To find out what version of python is installed, you can use the `docker run`
command to start a container from the image and then open a bash shell to
interact with the container.

```
docker run -it python bash
```

This will start a container from the python image and open a bash shell to
interact with the container. You can then use the `python --version` command
to see what version of python is installed.

```
python --version
```

What version of python is installed?

When you are done, you can exit the container by typing `exit` and pressing enter.

### Pulling a specific version of an image

Back on the docker hub python image page, look at the right side of the page for
the "Tag summary" section. Use the dropdown menu to select a version of python that
is not the `latest` and has `slim` in the tag name. 

Find the blue button that says "Run in Docker Desktop" and click on the three dots
next to it. Copy the command that appears in the pop-up. It will look something
like below:

```
docker pull python:<version>
```

Use the `docker images` command to view the images you have available on your system.

```
docker images
```

Try creating a container from the specific version of the python image you pulled,
similar to how we did it for the `latest` version above, and then run the `python
--version` command to see what version of python is installed.

```
docker run -it python:<version> bash
```

What version of python is installed?

When you are done, you can exit the container by typing `exit` and pressing enter.

## Creating a simple Docker image and container

If you navigate to the simple/ directory, you'll notice that we have three
files: a Dockerfile, a requirements.txt, and a genome fasta file. 

Briefly take a look at each file, based on the lecture, you should be able to get a rough
sense for what the Dockerfile is doing. We are creating an image with python and biopython
installed, copying a script located in the current directory into the container image, and
then running the script. 

Please use the following command to build a docker image from this Dockerfile:

```
docker build -t python_script:latest .
```

Upon completion, you should be able to see your docker image if you use the following command:

```
docker images
```

Take note of the difference between REPOSITORY and TAG as well as the size of the created
image.

## Running a container from this image

We have only built the image, we still need to create a container or instance from this
image. 

Run the following command:

```
docker run --name test1 python_script
```

What do you expect the output to be? What is the output?

That was an example of running a docker container non-interactively. We can choose to run 
containers `interactively`, which you'll often use to debug or troubleshoot commands. The
following command will attach your terminal to the containers stdin/stdout so that you can 
interact with a bash shell or other program. 

```
docker run -it python_script bash
```

Use the `ls` command and take note of what files are present. Try to open a python 
interpreter and `import Bio`. This is the environment that your container created and
you should have access to the same files you copied and the tools you installed in the
Dockerfile. You may exit the container using `exit`.

## A slightly more advanced version

1. Navigate to the advanced/ directory and use what we've just done, LLMs, or the internet,
and try to complete the files in this directory to build an image with FastQC, create a container from it,
and run fastqc on the provided fastq. 

    - Ensure that your YML file specifies the correct name for the environment - `fastqc_env`
    - Create this YML file just as you've done for the other tools in this course
    - The command to create an environment from a file is `conda env create -f <yml_file>`
    - You will need to build the image first as you did before. 

Build the image using the following command:

```
docker build -t fastqc_container:latest .
```

2. Try running your container once:

```
docker run --name fastqc fastqc_container
```

Observe what happens? Does it run? Where is the output?

Recall that containers are isolated and by default store any files non-persistently
inside the container unless otherwise specified. When a container is destroyed, 
any files inside will also be lost. Typically speaking, we will want to persist 
files from a docker container to a more permanent location. One way of accomplishing 
this is by using a bind-mount, which will connect the host filesystem to the container 
filesystem and allow for various read / write operations.

Add the following flag to your docker run command for this new container:

```
docker run --volume $(pwd):/app --name fastqc2 fastqc_container
```

This will enable you to create files in the container and persist the files onto the host filesystem. In 
this case, you can see that we are binding the present working directory on the host to the /app directory
inside the container where FastQC is running and producing its outputs. 

After you run this command, you should now see the outputs of FastQC appear in your current directory.
Prior to this, those files would have existed in the container and would have been deleted when the container 
exited.  

## Managing your images and containers

Remember that you can use the `docker images` command to view all the images you have available on your system.

### Images

```
docker images
```

To remove an image, you can use the `docker rmi` command.

```
docker rmi <image_name / container ID>
```

To remove an image, you will need to first remove any containers that are using it.

You can also use the `docker ps -a` command to view all the containers you have available on your system.

### Containers 

```
docker ps -a
```

To remove a container, you can use the `docker rm` command.

```
docker rm <container_name / container ID>
```

## BF528 Containers

Navigate to the class_containers/ directory. You do not need to do anything for this part, but take a look
at the files contained within. 

These are how the containers we use for this class were built. Try to understand the purpose of each line on
your own. We'll go through it together and talk about the specific considerations that were necessary. 

## Extra - Creating your own Dockerfile and hosting it on GitHub Container Registry

You do not need to do this (you will not be doing this for our class), but you 
can follow these steps if you are interested in learning how to create and host
your own docker images. 

If you've managed to do everything before this, you can try to create your own
Docker image, push it to GitHub Container Registry, and pull it from GitHub Container Registry.

When you've used docker images in your nextflow pipelines, container 'ghcr.io/bf528/<container_name>:latest', you've been using the GitHub Container Registry to pull images that I pre-built for you. The GitHub Container Registry is very similar to the Docker Hub and
is meant to host docker images for public and private use. 

When you've run nextflow with the `-profile singularity` flag, you were instructing
nextflow to pull these docker images and use singularity to create containers with them
for your processes. 

I will describe the process of creating a docker image and pushing it to the GitHub Container Registry in general and point you to additional resources as the process is a bit involved. 
You can host GitHub Container Registry images using your organization (your username)

1. Create a Github Repository and commit/push the Dockerfile and any other files
needed to build the image.

2. Actually [build](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#building-container-images) the image

3. [Sign into](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic) the GitHub Container Registry

3. [Push the image](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#pushing-container-images)

4. [Change the package visibility](https://docs.github.com/en/packages/learn-github-packages/configuring-a-packages-access-control-and-visibility)

5. [Pull the image](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#pulling-container-images)

6. Optional: [Associate the package with a repository](https://docs.github.com/en/packages/learn-github-packages/connecting-a-repository-to-a-package)

## Commonly used commands

### Building an image
docker build -t <image_tag> .

### Running a container from an image
docker run --name <container_name> <image_name>

### Listing all containers
docker ps -a

### Removing a container
docker rm <container_name>

### Listing all images
docker images

### Removing an image
docker rmi <image_name>

### Running a container interactively - (-i | --interactive) and (-t | --tty)
docker run -it /bin/bash

From the Docker documentation: The -i flag is most often used together with the 
-t flag to bind the I/O streams of the container to a pseudo terminal, creating 
an interactive terminal session for the container