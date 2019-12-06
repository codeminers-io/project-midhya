FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && \
    apt-get install -y \
        ca-certificates \
        build-essential \
        gfortran \
        g++ \
        git \
        python3 \
        python3-tk \
        python3-venv \
        python3-dev \
        python3-pip \
        libfreetype6-dev \
        dumb-init \
        libpq-dev \
	nodejs \
	npm \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	;

RUN mkdir /workdir

WORKDIR /workdir

COPY / /workdir/

RUN npm install

RUN pip3 install -U pip

RUN pip3 install -r rasa/requirements.txt --extra-index-url https://pypi.rasa.com/simple --user

RUN chgrp -R 0 . && chmod -R g=u .

RUN chmod a+rwx rasa/models/20191206-212157.tar.gz

EXPOSE 3000 5000
