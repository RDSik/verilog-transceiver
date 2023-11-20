`timescale 1ps / 1ps

module hamming_decoder_tb();

reg         clk;
reg         rst;
reg [11:0]  data;

wire [7:0]  q;
wire        g0_error;
wire        g1_error;
wire        g2_error;
wire        g3_error;

integer i;

hamming_decoder dut (
    .clk        (clk),
    .rst        (rst),
    .data       (data),
    .q          (q)
);

assign g0_error = dut.g0_error;
assign g1_error = dut.g1_error;
assign g2_error = dut.g2_error;
assign g3_error = dut.g3_error;

initial 
    begin        
        clk = 1;
        #1; rst = 0;
        #1; rst = 1;
        for (i = 0; i <= 50; i = i + 1)
            begin
                #2; data = $urandom_range(0,4095); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, q=%b", $time, clk, data, q);
	
initial 
	#100 $stop;

endmodule
