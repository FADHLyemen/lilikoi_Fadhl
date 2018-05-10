#FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install software-properties-common -y
#RUN add-apt-repository ppa:webupd8team/java -y
RUN add-apt-repository ppa:openjdk-r/ppa 
RUN apt-get update
RUN apt-get install openjdk-8-jdk -y
#RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
#RUN apt-get install oracle-java7-installer -y


