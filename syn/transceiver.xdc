####################
# Clocks
####################

####################
# Clocks
####################

create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports clk]

####################
# I/O constraints
####################

