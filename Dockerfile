FROM andrewosh/binder-base
USER root
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update   
RUN apt-get install openjdk-7-jdk 
USER main

ADD verify verify