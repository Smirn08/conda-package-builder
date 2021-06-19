FROM continuumio/miniconda3:latest AS builder

WORKDIR /root/

COPY environment.yml .

ENV ENV_NAME python-3.7.7-pyspark-2.4.8-pricing

RUN set -ex && \
    conda config --set ssl_verify false && \
    mkdir -p ${HOME}/.pip && \
    printf "[global]\ntrusted-host = pypi.python.org\n  pypi.org\n  files.pythonhosted.org\n" > $HOME/.pip/pip.conf && \
    git config --global http.sslVerify false && \
    conda env create -n ${ENV_NAME} -f environment.yml && \
    conda install -c conda-forge conda-pack && \
    conda pack -n ${ENV_NAME} -o ${ENV_NAME}.tar.gz
