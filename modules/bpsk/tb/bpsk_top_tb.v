`timescale 1ps / 1ps

module bpsk_top_tb();

reg        clk;
reg        rst;
reg        en;
reg [11:0] data;

wire [11:0] q;
wire [11:0] sine_out;
wire [11:0] neg_sine_out;
wire [7:0]  signal_cnt_out;
wire [11:0] modulator_out;

bpsk_top #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk  (clk),
    .rst  (rst),
    .en   (en),
    .data (data),
    .q    (q)
);

assign sine_out = dut.sine_out;
assign neg_sine_out = dut.neg_sine_out;
assign signal_cnt_out = dut.signal_cnt_out;
assign modulator_out = dut.modulator_out;

initial begin
    clk = 1; data = $urandom_range(0,4095);
    #1; rst = 0; en = 0;
    #1; rst = 1; en = 1;    
end

always #1 clk = ~clk;
	
initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, bpsk_top_tb);
    $monitor("time=%g, clk=%b, data=%b, q=%b", $time, clk, data, q);
end

initial #15000 $stop;

endmodule
