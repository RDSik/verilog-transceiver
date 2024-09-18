FROM ubuntu:latest  

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y \
    make \
    g++ \
    git \
    bison \
    flex \
    gperf \
    libreadline-dev \
    autoconf

RUN git clone https://github.com/steveicarus/iverilog && \
    cd iverilog && \
    autoconf && \
    ./configure && \
    make check && \
    make install

RUN git clone --recurse-submodules https://github.com/RDSik/verilog-transceiver.git && \
    cd verilog-transceiver/top/tb && \
    iverilog -o transceiver transceiver_tb.v ../transceiver_top.v && \
    vvp transceiver
