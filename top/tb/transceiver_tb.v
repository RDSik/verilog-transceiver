`timescale 1ps / 1ps

module transceiver_tb();

reg         clk;
reg         arst;
reg         data;
reg         en;

wire        done;
wire        q;
wire [11:0] signal_out;

integer i;

transceiver_top transceiver_inst (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .data       (data),
    .done       (done),
    .q          (q),
    .signal_out (signal_out)
);

initial 
    begin        
        clk = 0;
        #1; arst = 1; en = 0;
        #1; arst = 0; en = 1;
        for (i = 0; i <= 10000; i = i + 1)
            begin
                #1; data = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, done=%b, signal_out=%b, q=%b", $time, clk, data, done, signal_out, q);
	
initial 
	#10000 $stop;

endmodule
