open_project transceiver.xpr

read_ip ../platform/xilinx/clk_wiz/clk_wiz.xci
generate_target all [get_files *clk_wiz.xci]

read_mem ../top/sim/modelsim/sin_value.dat

read_mem ../top/sim/modelsim/neg_sin_value.dat

close_project
exit
