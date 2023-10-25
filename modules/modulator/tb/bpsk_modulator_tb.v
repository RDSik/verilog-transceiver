`timescale 1ps / 1ps

module bpsk_modulator_tb();

reg         clk;
reg         arst;
reg         en;
reg [8:0]   in;

wire [11:0] signal_out;
wire [7:0] sine_cnt;
wire [3:0] sel_cnt;
wire [8:0] sel;

bpsk_modulator #(
    .SINE_WIDTH (12),
    .DATA_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in         (in),
    .signal_out (signal_out)
);

assign sel_cnt = dut.sel_cnt;
assign sine_cnt = dut.sine_cnt;
assign sel = dut.sel;

initial 
    begin        
        clk = 0; in = $urandom_range(0,511);
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        #1000; en = 0;
        #1000; en = 1;
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, in=%b, signal_out=%b", $time, clk, in, signal_out);
	
initial 
	#5000 $stop;

endmodule
