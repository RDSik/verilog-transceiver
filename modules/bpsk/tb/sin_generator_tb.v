`timescale 1ps / 1ps

module sin_generator_tb();

reg         clk;
reg         arstn;
reg         en;

wire [11:0] sin_out;
wire [11:0] neg_sin_out;
wire [7:0]  cnt_out;

sin_generator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12)
) dut (
    .clk         (clk),
    .arstn       (arstn),
    .en          (en),
    .sin_out     (sin_out),
    .neg_sin_out (neg_sin_out),
    .cnt_out     (cnt_out)
);

initial begin        
    clk = 0;
    #1; arstn = 0; en = 0;
    #1; arstn = 1; en = 1;
end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, sin_out=%b, neg_sin_out=%b, cnt_out=%b", $time, clk, sin_out, neg_sin_out, cnt_out);
	
initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, sin_generator_tb);
    #8000 $stop;
end

endmodule
