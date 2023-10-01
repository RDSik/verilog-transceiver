`timescale 1ns / 1ns

module bpsk_modulator_tb();

reg         clk;
reg         arst;
reg         en;
reg         s;

wire [11:0] signal_out;

integer i;

bpsk_modulator #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .s          (s),
    .signal_out (signal_out)
);

initial 
    begin        
        clk = 0; 
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        for (i = 0; i <= 511; i = i + 1)
            begin
                #1; s = $urandom_range(0,1); 
            end 
    end

always #1 clk = !clk;

initial 
    $monitor("time=%g, clk=%b, s=%b, signal_out", $time, clk, s, signal_out);
	
initial 
	#600 $stop;

endmodule
