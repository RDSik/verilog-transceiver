####################
# Clocks
####################

create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports clk]

####################
# I/O constraints
####################

# bank 0/13/33 LVCMOS33
# bank 34/35 Vadj

set_property -dict {PACKAGE_PIN F22 IOSTANDARD LVCMOS18} [get_ports en]
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS18} [get_ports rst]
set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports data]
set_property -dict {PACKAGE_PIN W8 IOSTANDARD LVCMOS33} [get_ports q]
