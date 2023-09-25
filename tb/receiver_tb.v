`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 21:45:38
// Design Name: 
// Module Name: receiver_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module receiver_tb();

reg        clk;
reg        arst;
reg        in;

wire       done;
wire [8:0] out;
wire [3:0] state;
wire       parity;

integer i;

receiver dut (
    .clk  (clk),
    .arst (arst),
    .in   (in),
    .done (done),
    .out  (out)
);

assign state = dut.state;
assign parity = dut.data[8];

initial 
    begin        
        clk = 0; 
        #5; arst = 1;
        #5; arst = 0;
        for (i = 0; i <= 127; i = i + 1)
            begin
                #5; in = $urandom_range(0,1); 
            end 
    end

always #5 clk = !clk;

initial 
    $monitor("time=%g, clk=%b - in=%b - done=%b - out=%b", $time, clk, in, done, out);
	
initial 
	#550 $stop;

endmodule
