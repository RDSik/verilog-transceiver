`timescale 1ps / 1ps

module transceiver_tb();

reg         clk;
reg         arst;
reg         in;
reg         en;

wire        err;
wire        done;
wire [11:0] signal_out;

integer i;

transceiver_top #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) transceiver_inst (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in         (in),
    .err        (err),
    .done       (done),
    .signal_out (signal_out)
);

initial 
    begin        
        clk = 0;
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        for (i = 0; i <= 5000; i = i + 1)
            begin
                #10; in = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, in=%b, done=%b, err=%b, signal_out=%b", $time, clk, in, done, err, signal_out);
	
initial 
	#5000 $stop;

endmodule
