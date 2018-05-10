FROM andrewosh/binder-base
USER root
#ENTRYPOINT "/bin/sh"

#ADD sayhi.sh /usr/local/

#ADD verify verify

RUN ENV DEBIAN_FRONTEND noninteractive
RUN add-apt-repository ppa:openjdk-r/ppa -y  
RUN apt-get update -y  
RUN apt-get install openjdk-7-jdk -y


