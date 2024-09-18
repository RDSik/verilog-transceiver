FROM ubuntu:latest  

RUN apt-get -y update && \
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

RUN pwd && \
    ls

ADD ./top/tb/timescale.vh /
ADD ./top/tb/transceiver_tb.v /
ADD ./top/transceiver_top.v /

RUN iverilog -o transceiver transceiver_tb.v transceiver_top.v
RUN vvp transceiver
