FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    make \
    cmake \
    cpp \
    curl \
    gcc \
    git \
    python3-pip \
    python3-dev \
    python3-scipy \
    libfftw3-dev \
    libmbedtls-dev \
    libboost-program-options-dev \
    libconfig++-dev \
    jq \
    libboost-dev \
    gpsd \
    gpsd-clients \
    mariadb-server \
    libmariadb-dev \
    libitpp-dev \
    librtlsdr-dev \
    libuhd-dev \
    libopenblas-dev \
    libncurses5-dev \
    libpcsclite-dev \
    libatlas-base-dev \
    lib32z1-dev

RUN ln -s /usr/bin/mariadb_config /usr/bin/mysql_config

COPY ./src/requirements.txt /app/src/requirements.txt
RUN pip3 install -r /app/src/requirements.txt

# Drivers for B200:
RUN apt-get install -y libuhd-dev uhd-host

# Drivers for bladerf:
RUN apt-get install -y \
    libbladerf-dev \
    bladerf-fpga-hostedx40 \
    bladerf-fpga-hostedx115 \
    bladerf-fpga-hostedxa4 \
    bladerf-fpga-hostedxa9

COPY ./ /app
WORKDIR /app/src/srsLTE/build
RUN cmake ../
RUN make
WORKDIR /app/src

EXPOSE 5000
