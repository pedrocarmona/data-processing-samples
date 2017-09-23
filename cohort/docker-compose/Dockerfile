#
# Docker file to build  local image to fix the users permission
# and install extra packages
#

FROM jupyter/scipy-notebook

ARG host_uid
ARG host_gid

ENV NB_UID ${host_uid}
ENV NB_GID ${host_gid}

USER root

RUN usermod -u $NB_UID $NB_USER && chown -R $NB_UID $CONDA_DIR
RUN groupmod -g $NB_GID -o $(id -g -n $NB_USER)

USER jovyan

# Install jupyterlab

RUN conda install --yes -c conda-forge jupyterlab

RUN conda install --yes -c bioconda mysqlclient

RUN jupyter serverextension enable --py jupyterlab --sys-prefix
