`timescale 1ps / 1ps

module hamming_top_tb();

reg        clk;
reg        rst;
reg [7:0]  data;

wire [7:0]  q;
wire [11:0] encoder_out;

integer i;

hamming_top dut (
    .clk        (clk),
    .rst        (rst),
    .data       (data),
    .q          (q)
);

assign encoder_out = dut.encoder_out;

initial 
    begin        
        clk = 1;
        #1; rst = 0;
        #1; rst = 1;
        for (i = 0; i <= 20; i = i + 1)
            begin
                #4; data = $urandom_range(0,255); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, q=%b", $time, clk, data, q);
	
initial 
	#100 $stop;

endmodule
