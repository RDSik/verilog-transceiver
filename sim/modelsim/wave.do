onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -color #ff9911 -radix hex -group TOP \
/transceiver_tb/dut/clk   \
/transceiver_tb/dut/arstn \
/transceiver_tb/dut/en    \

add wave -color #cccc00 -radix hex -group UART \
/transceiver_tb/dut/data        \
/transceiver_tb/dut/q           \
/transceiver_tb/dut/done        \
/transceiver_tb/dut/active      \
/transceiver_tb/dut/data_valid  \
/transceiver_tb/dut/uart_rx_out \

add wave -color #ee66ff -radix hex -group HAMMING \
/transceiver_tb/dut/decoder_out \
/transceiver_tb/dut/encoder_out \

add wave -color #1199ff -radix hex -group BPSK \
-radix unsigned /transceiver_tb/dut/cnt_out \
/transceiver_tb/dut/demodulator_out \
-format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/modulator_out \
-format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/neg_sin_out \
-format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/sin_out \

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8761 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {26250 ps}
run -all
wave zoom full
