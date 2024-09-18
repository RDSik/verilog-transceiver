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

RUN pwd

ADD ./.github/workflows/iverilog_run.sh /

RUN chmod +x ./.github/workflows/iverilog_run.sh && \
    ./.github/workflows/iverilog_run.sh
