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

ADD ./.github/workflows/iverilog_run.sh /
ADD ./top/tb/transceiver_tb.v /
ADD ./top/transceiver_top.v /

RUN chmod +x ./iverilog_run.sh && \
    ./iverilog_run.sh
