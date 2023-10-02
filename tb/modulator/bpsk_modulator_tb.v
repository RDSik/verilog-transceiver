`timescale 1ps / 1ps

module bpsk_modulator_tb();

reg         clk;
reg         arst;
reg         en;
reg [8:0]   in;

wire [11:0] signal_out;
wire [7:0] sine_cnt;
wire [2:0] sel_cnt;
wire       sel;

integer i;

bpsk_modulator #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in         (in),
    .signal_out (signal_out)
);

assign sel_cnt = dut.sel_cnt;
assign sine_cnt = dut.sine_cnt;
assign sel = dut.sel;

initial 
    begin        
        clk = 0; 
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        for (i = 0; i <= 5000; i = i + 1)
            begin
                #1; in = $urandom_range(0,511); 
            end 
    end

always #1 clk = !clk;

initial 
    $monitor("time=%g, clk=%b, in=%b, signal_out", $time, clk, in, signal_out);
	
initial 
	#5000 $stop;

endmodule
