FROM andrewosh/binder-base
USER root
ENTRYPOINT "/bin/sh"

ADD sayhi.sh /usr/local/bin/sayhi.sh

ADD verify verify


#RUN add-apt-repository ppa:openjdk-r/ppa  
#RUN apt-get update   
#RUN apt-get install openjdk-7-jdk 


