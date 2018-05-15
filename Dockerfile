FROM jupyter/datascience-notebook:1085ca054a5f
#RUN pip install --no-cache-dir notebook==5.*

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Specify the default command to run
#CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]

USER root

#ENV R_BASE_VERSION 3.4.4

RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
		#	littler \
        #        r-cran-littler \
		#r-base=${R_BASE_VERSION}* \
		#r-base-dev=${R_BASE_VERSION}* \
		#r-recommended=${R_BASE_VERSION}* \
        #&& echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
        #&& echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r \
    liblzma-dev \
	libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    && R CMD javareconf\
	&& apt-get install r-cran-rjava -y\
	&& apt-get install libgdal1-dev libproj-dev -y
	
# R install section

# R -e 'install.packages("devtools",repos = "http://cran.us.r-project.org")' && \
RUN    R -e 'install.packages("RWeka", repos = "http://cran.us.r-project.org")' \
       R -e 'install.packages("corrplot", repos = "http://cran.us.r-project.org")'
	
#RUN R -e 'devtools::install_version("e1071", version = "1.6-8", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("gbm", version = "2.1.3", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("glmnet", version = "2.0-13", repos = "http://cran.us.r-project.org")'	
#RUN R -e 'devtools::install_version("foreach", version = "1.4.4", repos = "http://cran.us.r-project.org")'	
#RUN R -e 'devtools::install_version("randomForest", version = "4.6-12", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("Matrix", version = "1.2-12", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("randomForest", version = "4.6-12", repos = "http://cran.us.r-project.org")'
##RUN R -e 'devtools::install_version("rJava", version = "0.9-9", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("Hmisc", version = "4.1-1", repos = "http://cran.us.r-project.org")'
#RUN R -e 'devtools::install_version("Hmisc", version = "4.1-1", repos = "http://cran.us.r-project.org")'
	
RUN conda uninstall \
         'r-devtools=1.13*' 
		 #'r-devtools=1.13.4'
	
RUN conda install --quiet --yes \
	'r-base=3.4.1' \
	'r-rjava=0.9*' \
    'r-cluster=2.0.6'\
	'r-e1071=1.6_8'\
	'r-gbm=2.1*' \
	'r-glmnet=2.0*'\
	'r-foreach=1.4.4'\
	'r-randomForest=4.6_12'\
	'r-matrix=1.2_12'\
	'r-hmisc=4.0_3'\
	#'r-formula=1.2_2'\
	'r-survival=2.41_3'\
	'r-reshape2=1.4.3'\     
	'r-infotheo=1.2*'\
	'r-dplyr=0.7.4'\
	'r-devtools=1.13.4'\
	#'r-corrplot=0.77'\
	'r-pROC=1.10.0'\
	#'rweka=0.4.34'\       
	'r-caret=6.0_78'\
	'r-ggplot2=2.2.1'&&\
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR 
    #Rscript -e 'source("http://bioconductor.org/biocLite.R")' -e 'biocLite("pathifier")'
    #&& Rscript -e 'devtools::install_github(c("hadley/multidplyr","jeremystan/tidyjson","ropenscilabs/skimr"))'
  #&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  #&& rm -rf /var/lib/apt/lists/*	
	
