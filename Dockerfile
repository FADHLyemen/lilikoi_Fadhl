FROM jupyter/datascience-notebook:1085ca054a5f
RUN pip install --no-cache-dir vdom==0.5
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
USER root

# R packages
RUN conda uninstall 'r-base=3.4.1' 
RUN conda install 'r-base=3.4.3' \
    'r-irkernel=0.8*'

RUN apt-get update && apt-get install -y gnupg2
## Install Java FROM cardcorp/r-java 
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" \
      | tee /etc/apt/sources.list.d/webupd8team-java.list \
    &&  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" \
      | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" \
        | /usr/bin/debconf-set-selections \
    && apt-get update \
	&& apt-get install -y --no-install-recommends \
	    littler \
                r-cran-littler \
    && apt-get install -y oracle-java8-installer \
    && update-alternatives --display java \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && R CMD javareconf

## make sure Java can be found in rApache and other daemons not looking in R ldpaths
RUN echo "/usr/lib/jvm/java-8-oracle/jre/lib/amd64/server/" > /etc/ld.so.conf.d/rJava.conf
RUN /sbin/ldconfig

## Install rJava package
RUN ln -s /bin/tar /bin/gtar 
RUN apt-get install g++ 
RUN  R -e 'install.packages("devtools",repos = "http://cran.us.r-project.org")' \ 
     R -e  'devtools::install_version("e1071", version = "1.6-8", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("caret", version = "6.0-79", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("pamr", version = "1.55", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("gbm", version = "2.1.3", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("glmnet", version = "2.0-13", repos = "http://cran.us.r-project.org")' \	
	 R -e  'devtools::install_version("foreach", version = "1.4.4", repos = "http://cran.us.r-project.org")'	\
	 R -e  'devtools::install_version("randomForest", version = "4.6-12", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("Matrix", version = "1.2-12", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("randomForest", version = "4.6-12", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("rJava", version = "0.9-9", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("RWeka", version = "0.4-36", repos = "http://cran.us.r-project.org")' \
	 R -e  'devtools::install_version("Hmisc", version = "4.1-1", repos = "http://cran.us.r-project.org")'  \
	 R -e  'devtools::install_version("Hmisc", version = "4.1-1", repos = "http://cran.us.r-project.org")'  \
	 R -e  'devtools::install_version("corrplot", version = "0.84", repos = "http://cran.us.r-project.org")'  \
	#R -e 'install.packages("https://bioconductor.org/packages/release/bioc/src/contrib/pathifier_1.18.0.tar.gz", repos = NULL, type = "source")' \
   && Rscript -e 'source("http://bioconductor.org/biocLite.R")' -e 'biocLite("pathifier")' \
   && Rscript -e 'devtools::install_git("git://github.com/fadhlyemen/lilikoi_Fadhl")' \
   && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
   && rm -rf /var/lib/apt/lists/*


  
  



