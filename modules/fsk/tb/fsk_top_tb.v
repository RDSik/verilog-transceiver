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
        data1 = 0; 
        data2 = 0; 
        s = 0; 
        f1 = 0; 
        f2 = 0;  
        forever #2 f1 = ~f1;  
    end 

initial
    begin
        forever #4 f2 = ~f2; 
    end

initial 
    begin 
        data1 = 1; 
        #30; 
        data1 = 0; 
        #30; 
        s = 1; 
        data2 = 1; 
        #30; 
        data2 = 0; 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, s=%b, data1=%b, data2=%b, f1=%b, f2=%b, q1=%b, q2=%b", $time, clk, s, data1, data2, f1, f2, q1, q2);
	
initial 
	#100 $stop;

endmodule 
