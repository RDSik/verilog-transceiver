`timescale 1ps / 1ps

module transceiver_tb();

reg         clk;
reg         arst;
reg         in_bit;
reg         en;

wire        err;
wire        done;
wire [7:0]  out_byte;
wire [11:0] signal_out;

integer i;

transceiver_top #(
    .SINE_WIDTH (12),
    .DATA_WIDTH (8)
) transceiver_inst (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in_bit     (in_bit),
    .err        (err),
    .done       (done),
    .out_byte   (out_byte),
    .signal_out (signal_out)
);

initial 
    begin        
        clk = 0;
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        for (i = 0; i <= 10000; i = i + 1)
            begin
                #1; in_bit = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, in_bit=%b, done=%b, err=%b, signal_out=%b, out_byte=%b", $time, clk, in_bit, done, err, signal_out, out_byte);
	
initial 
	#10000 $stop;

endmodule
