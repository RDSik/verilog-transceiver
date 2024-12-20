`timescale 1ps / 1ps

module bpsk_top_tb();

reg        clk;
reg        arstn;
reg        en;
reg [11:0] data;

wire [11:0] q;
wire [11:0] sin_out;
wire [11:0] neg_sin_out;
wire [7:0]  cnt_out;
wire [11:0] modulator_out;

bpsk_top #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk   (clk),
    .arstn (arstn),
    .en    (en),
    .data  (data),
    .q     (q)
);

assign sin_out = dut.sin_out;
assign neg_sin_out = dut.neg_sin_out;
assign cnt_out = dut.cnt_out;
assign modulator_out = dut.modulator_out;

initial begin
    clk = 1; data = $urandom_range(0,4095);
    #1; arstn = 0; en = 0;
    #1; arstn = 1; en = 1;    
end

always #1 clk = ~clk;
	
initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, bpsk_top_tb);
    $monitor("time=%g, clk=%b, data=%b, q=%b", $time, clk, data, q);
end

initial #15000 $stop;

endmodule
