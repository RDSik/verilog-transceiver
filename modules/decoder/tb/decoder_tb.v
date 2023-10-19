`timescale 1ps / 1ps

module decoder_tb();

reg        clk;
reg        arst;
reg [8:0]  in;

wire       err;
wire [7:0] out_byte;
wire       parity;

integer i;

decoder #(
    .DATA_WIDTH (8)
) dut (
    .clk      (clk),
    .arst     (arst),
    .in       (in),
    .err      (err),
    .out_byte (out_byte)
);

assign parity = dut.parity;

initial 
    begin        
        clk = 0; 
        #1; arst = 1;
        #2; arst = 0;
        for (i = 0; i <= 255; i = i + 1)
            begin
                #2; in = $urandom_range(0,511); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, in=%b, err=%b, out_byte=%b", $time, clk, in, err, out_byte);
	
initial 
	#300 $stop;

endmodule
