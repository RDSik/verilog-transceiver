`timescale 1ps / 1ps

module bpsk_demodulator2 #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                             clk,
    input  wire                             rst,
    input  wire                             en,
    input  wire [SAMPLE_WIDTH-1:0]          signal_in,
    input  wire [SAMPLE_WIDTH-1:0]          sine_in,
    input  wire [SAMPLE_WIDTH-1:0]          neg_sine_in,
    input  wire [$clog2(SAMPLE_NUMBER)-1:0] cnt_in, 
    output reg  [DATA_WIDTH-1:0]            q 
);

    
    
endmodule
