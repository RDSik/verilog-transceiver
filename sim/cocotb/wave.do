onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /transceiver_top/clk
add wave -noupdate /transceiver_top/arstn
add wave -noupdate /transceiver_top/data
add wave -noupdate /transceiver_top/en
add wave -noupdate /transceiver_top/q
add wave -noupdate /transceiver_top/done
add wave -noupdate /transceiver_top/active
add wave -noupdate /transceiver_top/data_valid
add wave -noupdate /transceiver_top/uart_rx_out
add wave -noupdate /transceiver_top/decoder_out
add wave -noupdate /transceiver_top/encoder_out
add wave -noupdate /transceiver_top/cnt_out
add wave -noupdate /transceiver_top/demodulator_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_top/neg_sin_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_top/sin_out
add wave -noupdate -format Analog-Step -height 74 -max 1997.9999999999998 -min -2048.0 /transceiver_top/modulator_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5565665524625 ns} 0}
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
WaveRestoreZoom {0 ns} {26254200000001 ns}
run -all
wave zoom full
