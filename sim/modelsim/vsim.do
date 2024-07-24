vcd file transceiver_tb.vcd;
add log -r /*
add wave -noupdate dut/done
add wave -noupdate dut/active
add wave -noupdate dut/data_valid
add wave -noupdate dut/uart_rx_out
add wave -noupdate dut/decoder_out
add wave -noupdate dut/encoder_out
add wave -noupdate dut/modulator_out
add wave -noupdate dut/demodulator_out
add wave -noupdate dut/sin_out
add wave -noupdate dut/neg_sin_out
add wave -noupdate -radix unsigned dut/cnt_out
run -all
wave zoom full