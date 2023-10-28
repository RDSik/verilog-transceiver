`timescale 1ps / 1ps

module receiver_tb();

reg        clk;
reg        arst;
reg        in_bit;

wire       done;
wire [3:0] state;
wire [7:0] out_byte;
wire [7:0] data;
wire       parity;

integer i;

receiver #(
    .DATA_WIDTH (8)
) dut (
    .clk    (clk),
    .arst   (arst),
    .in_bit (in_bit),
    .done   (done),
    .out    (out_byte)
);

assign state = dut.state;
assign data = dut.data;
assign parity = dut.parity;

initial 
    begin        
        clk = 0; 
        #1; arst = 1;
        #1; arst = 0;
        for (i = 0; i <= 255; i = i + 1)
            begin
                #1; in_bit = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, in_bit=%b, done=%b, out=%b", $time, clk, in_bit, done, out_byte);
	
initial 
	#300 $stop;

endmodule
