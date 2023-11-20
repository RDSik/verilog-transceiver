`timescale 1ps / 1ps

module fsk_top_tb();

reg clk;
reg data1;
reg data2;
reg s;
reg f1;
reg f2;

wire q1;
wire q2;
wire modulator_out;

integer i;

fsk_top dut (
    .clk   (clk),
    .data1 (data1),
    .data2 (data2),
    .f1    (f1),
    .f2    (f2),
    .q1    (q1),
    .q2    (q2)
);

assign modulator_out = dut.modulator_out;

initial 
    begin  
        clk = 0;      
        for (i = 0; i <= 100; i = i + 1)
            begin
                #1; s = $urandom_range(0,1); data1 = $urandom_range(0,1); data2 = $urandom_range(0,1);  f1 = $urandom_range(0,1); f2 = $urandom_range(0,1);  
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, s=%b, data1=%b, data2=%b, f1=%b, f2=%b, q1=%b, q2=%b", $time, clk, s, data1, data2, f1, f2, q1, q2);
	
initial 
	#100 $stop;

endmodule 
