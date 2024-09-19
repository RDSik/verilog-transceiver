open_project transceiver.xpr

read_ip ../platform/xilinx/clk_wiz/clk_wiz.xci
generate_target all [get_files *clk_wiz.xci]

read_mem ../top/sin_val.dat

read_mem ../top/neg_sin_val.dat

close_project
exit