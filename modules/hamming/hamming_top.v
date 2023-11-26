`timescale 1ps / 1ps

module humming_coder12_8 (
    input  wire        clk, 
    input  wire        rst_n,
    input  wire [7:0]  data,
    input  wire [11:0] hc_in,
    output wire [7:0]  q,
    output wire [11:0] hc_out
);

    hamming_encoder HE(
        .clk    (clk),
        .rst_n  (rst_n),
        .data   (data),
        .hc_out (hc_out)
    );

    hamming_decoder HD(
        .clk   (clk),
        .rst_n (rst_n),
        .hc_in (hc_in),
        .q     (q)
    );

endmodule
