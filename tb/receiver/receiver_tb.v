`timescale 1ps / 1ps

module receiver_tb();

reg        clk;
reg        arst;
reg        in;

wire       done;
wire [8:0] out;
wire [3:0] state;
wire       parity;

integer i;

receiver #(
    .DATA_WIDTH (8)
) dut (
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
        #1; arst = 1;
        #1; arst = 0;
        for (i = 0; i <= 255; i = i + 1)
            begin
                #1; in = $urandom_range(0,1); 
            end 
    end

always #1 clk = !clk;

initial 
    $monitor("time=%g, clk=%b, in=%b, done=%b, out=%b", $time, clk, in, done, out);
	
initial 
	#300 $stop;

endmodule
