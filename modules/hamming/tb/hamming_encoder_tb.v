`timescale 1ps / 1ps

module hamming_encoder_tb();

reg        clk;
reg        rst;
reg [7:0]  data;

wire [11:0] q;
wire        p0;
wire        p1;
wire        p2;
wire        p3;

integer i;

hamming_encoder dut (
    .clk        (clk),
    .rst        (rst),
    .data       (data),
    .q          (q)
);

assign p0 = dut.p0;
assign p1 = dut.p1;
assign p2 = dut.p2;
assign p3 = dut.p3;

initial 
    begin        
        clk = 1;
        #1; rst = 0;
        #1; rst = 1;
        for (i = 0; i <= 50; i = i + 1)
            begin
                #2; data = $urandom_range(0,255); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, q=%b", $time, clk, data, q);
	
initial 
	#100 $stop;

endmodule
