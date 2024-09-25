FROM ubuntu:latest  

ENV DIR /verilog-transceiver/top

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

# RUN git clone --recurse-submodules https://github.com/RDSik/verilog-transceiver.git && \
    # cd verilog-transceiver/top && \
    # iverilog -o transceiver tb/transceiver_tb.v transceiver_top.v ../modules/bpsk/bpsk_modulator.v  ../modules/bpsk/bpsk_demodulator.v ../modules/bpsk/sin_generator.v ../modules/hamming/hamming_decoder.v ../modules/hamming/hamming_encoder.v  ../modules/uart/UART/Verilog/source/UART_RX.v ../modules/uart/UART/Verilog/source/UART_TX.v && \
    # vvp transceiver
    
