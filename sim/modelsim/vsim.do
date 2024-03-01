vcd file transceiver_tb.vcd
vcd add -r /*
add wave -position insertpoint sim:/transceiver_tb/dut/*
run -all
view wave