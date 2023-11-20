`timescale 1ps / 1ps

module hamming_top (
    input  wire       clk, 
    input  wire       rst,
    input  wire [7:0] data, 
    output wire [7:0] q
);
   
   wire [11:0] encoder_out;

    hamming_encoder hamming_encoder_inst (
        .clk  (clk),
        .rst  (rst),
        .data (data),
        .q    (encoder_out)
    );

    hamming_decoder hamming_decoder_inst (
        .clk  (clk),
        .rst  (rst),
        .data (encoder_out),
        .q    (q)
    );

endmodule
