onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /transceiver_tb/dut/clk
add wave -noupdate /transceiver_tb/dut/arstn
add wave -noupdate /transceiver_tb/dut/data
add wave -noupdate /transceiver_tb/dut/en
add wave -noupdate /transceiver_tb/dut/q
add wave -noupdate /transceiver_tb/dut/done
add wave -noupdate /transceiver_tb/dut/active
add wave -noupdate /transceiver_tb/dut/data_valid
add wave -noupdate /transceiver_tb/dut/uart_rx_out
add wave -noupdate /transceiver_tb/dut/decoder_out
add wave -noupdate /transceiver_tb/dut/encoder_out
add wave -noupdate -radix unsigned /transceiver_tb/dut/cnt_out
add wave -noupdate /transceiver_tb/dut/demodulator_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/modulator_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/neg_sin_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_tb/dut/sin_out
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
