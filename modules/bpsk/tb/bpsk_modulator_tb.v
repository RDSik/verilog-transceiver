`timescale 1ps / 1ps

module bpsk_modulator_tb();

reg         clk;
reg         rst;
reg         en;
reg [11:0]  data;

wire [11:0] signal_out;
wire [7:0]  signal_cnt;
wire [3:0]  sel_cnt;
wire [11:0] sel;

bpsk_modulator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk        (clk),
    .rst        (rst),
    .en         (en),
    .data       (data),
    .signal_out (signal_out)
);

assign sel_cnt = dut.sel_cnt;
assign signal_cnt = dut.signal_cnt;
assign sel = dut.sel;

initial 
    begin        
        clk = 0; data = $urandom_range(0,4095);
        #1; rst = 0; en = 0;
        #1; rst = 1; en = 1;
        #1000; en = 0;
        #1000; en = 1;
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, signal_out=%b", $time, clk, data, signal_out);
	
initial 
	#8000 $stop;

endmodule
