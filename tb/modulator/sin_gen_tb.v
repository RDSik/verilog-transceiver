`timescale 1ns / 1ns

module sin_gen_tb();

reg        clk;
reg        arst;

wire [11:0] sin_out;
wire [7:0]  cnt;

sin_gen #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .sin_out    (sin_out)
);

assign cnt = dut.cnt;

initial 
    begin        
        clk = 0; 
        #1; arst = 1;
        #1; arst = 0;
    end

always #1 clk = !clk;

initial 
    $monitor("time=%g, clk=%b, cnt=%b, sin_out=%b", $time, clk, cnt, sin_out);
    
initial 
	#1000 $stop;

endmodule
