FROM jupyter/datascience-notebook:1085ca054a5f
RUN pip install --no-cache-dir notebook==5.*

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]

USER root

RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    && R CMD javareconf\ 
	&& ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/local/lib
   && Rscript -e "install.packages('rJava',type = 'source', repos='http://cran.rstudio.com/' )"
