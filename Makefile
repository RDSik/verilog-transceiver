TOP_NAME    := transceiver
IVERILOG    := iverilog
GTKWAVE     := gtkwave
GTKW_FILE   := top/tb/gtkw.gtkw

SRC_FILES   += top/transceiver_top.v
SRC_FILES   += top/tb/transceiver_tb.v
SRC_FILES   += modules/hamming/hamming_decoder.v
SRC_FILES   += modules/hamming/hamming_encoder.v
SRC_FILES   += modules/bpsk/bpsk_modulator.v
SRC_FILES   += modules/bpsk/bpsk_demodulator.v
SRC_FILES   += modules/bpsk/sin_generator.v
SRC_FILES   += modules/uart/UART/Verilog/source/UART_RX.v
SRC_FILES   += modules/uart/UART/Verilog/source/UART_TX.v

.PHONY: all clean

all: build execute simulate

build:
	$(IVERILOG) -o $(TOP_NAME) $(SRC_FILES)

execute:
	vvp $(TOP_NAME)

simulate: 
	$(GTKWAVE) $(TOP_NAME)_tb.vcd

clean:
	rm $(TOP_NAME)
	rm $(TOP_NAME)_tb.vcd