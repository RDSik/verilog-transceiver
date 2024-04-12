`timescale 1ps / 1ps

module sine_generator_tb();

reg         clk;
reg         arstn;
reg         en;

wire [11:0] sine_out;
wire [11:0] neg_sine_out;
wire [7:0]  signal_cnt;

sine_generator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12)
) dut (
    .clk          (clk),
    .rst_n        (arstn),
    .en           (en),
    .sine_out     (sine_out),
    .neg_sine_out (neg_sine_out),
    .signal_cnt   (signal_cnt)
);

initial begin        
    clk = 0;
    #1; arstn = 0; en = 0;
    #1; arstn = 1; en = 1;
end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, sine_out=%b, neg_sine_out=%b, signa;_cnt=%b", $time, clk, sine_out, neg_sine_out, signal_cnt);
	
initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, sine_generator_tb);
    #8000 $stop;
end

endmodule
