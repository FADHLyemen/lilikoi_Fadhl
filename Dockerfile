#FROM andrewosh/binder-base:latest
#FROM rocker/tidyverse:latest
FROM jupyter/datascience-notebook:160eb5183ace
#FROM jupyter/base-notebook:b4dd11e16ae4
#LABEL maintainer="Peter Gensler <peterjgensler@gmail.com>"
#USER root
#RUN apt-get install openjdk-7-jdk
#RUN apt-get install software-properties-common
#RUN apt-get install -f
#RUN add-apt-repository ppa:openjdk-r/ppa  
#RUN apt-get update
#RUN apt-get install openjdk-7-jre

# Make ~/.R
#RUN mkdir -p $HOME/.R
RUN pip install --no-cache-dir notebook==5.*
# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
#ENV NB_USER jovyan
#ENV NB_UID 1000
#ENV HOME /home/${NB_USER}

#RUN adduser --disabled-password \
 #   --gecos "Default user" \
 #   --uid ${NB_UID} \
 #   ${NB_USER}
	
# $HOME doesn't exist in the COPY shell, so be explicit
#COPY R/Makevars /root/.R/Makevars
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
   && R CMD javareconf \
   #&& install2.r --error \
      #  ggstance ggrepel ggthemes \
        ###My packages are below this line
        #tidytext janitor corrr officer devtools pacman \
        #tidyquant timetk tibbletime sweep broom prophet \
        #forecast prophet lime sparklyr h2o rsparkling unbalanced \
        #formattable httr rvest xml2 jsonlite \
        #textclean naniar writexl \
	&& R -e "install.packages('rJava', repos = 'http://cran.us.r-project.org')" \
   # && Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))' \
   # && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
 # && rm -rf /var/lib/apt/lists/*               *


