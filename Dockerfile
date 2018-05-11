FROM andrewosh/binder-base
USER root
RUN apt-get install -f
RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update
RUN apt-get install openjdk-7-jre 


