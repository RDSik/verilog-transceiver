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

RUN pwd && \
    ls

ADD ./top/tb/timescale.vh /
ADD ./top/tb/transceiver_tb.v /
ADD ./top/transceiver_top.v /
ADD ./modules/bpsk/sin_generator.v /
ADD ./modules/bpsk/bpsk_modulator.v /
ADD ./modules/bpsk/bpsk_demodulator.v /
ADD ./modules/hamming/hamming_decoder.v /
ADD ./modules/hamming/hamming_encoder.v /
ADD ./modules/uart/UART/Verilog/source/UART_RX.v /
ADD .modules/uart/UART/Verilog/source/UART_TX.v /

RUN iverilog -o transceiver transceiver_tb.v transceiver_top.v
RUN vvp transceiver
