`timescale 1ns / 1ns

module mux #(
    parameter DATA_WIDTH = 12
) (
    input  wire                  en,
    input  wire                  s,
    input  wire [DATA_WIDTH-1:0] sin_in,
    input  wire [DATA_WIDTH-1:0] neg_sin_in, 
    output wire [DATA_WIDTH-1:0] signal_out
);

assign signal_out = en ? (s ? sin_in : neg_sin_in) : 0;

endmodule