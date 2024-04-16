vcd file transceiver_tb.vcd;
add log -r /*
add wave sim:/dut/*
run -all
wave zoom full