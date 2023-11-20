`timescale 1ps / 1ps

module fsk_top (
    input  wire clk,
    input  wire data1,
    input  wire data2,
    input  wire s,
    input  wire f1,
    input  wire f2,
    output wire q1,
    output wire q2,
    output wire modulator_out 
); 

    fsk_modulator fsk_modulator_inst (
        .clk   (clk),
        .data1 (data1),
        .data2 (data2),
        .s     (s),
        .f1    (f1),
        .f2    (f2),
        .q     (modulator_out)
    ); 
    
    fsk_demodulator fsk_demodulator_inst (
        .clk  (clk),
        .data (modulator_out),
        .s    (s),
        .q1   (q1),
        .q2   (q2)
    ); 

endmodule 
