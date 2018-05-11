FROM andrewosh/binder-base
USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -f
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update
RUN apt-get install openjdk-7-jre 
USER main
ADD install.R install.R                *


