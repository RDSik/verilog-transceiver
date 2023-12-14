open_project transceiver.xpr

read_ip ../platform/xilinx/clk_wiz/clk_wiz.xci
generate_target all [get_files *clk_wiz.xci]

read_mem ../modules/bpsk/sine_value.dat

read_mem ../modules/bpsk/neg_sine_value.dat

close_project
exit
