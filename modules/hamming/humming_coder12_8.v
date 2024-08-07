`default_nettype none

module humming_coder12_8 (
    input  wire        clk, 
    input  wire        arstn,
    input  wire        wren,
    input  wire        rden,
    input  wire [7:0 ] data,
    input  wire [11:0] hc_in,
    output wire [7:0 ] q,
    output wire [11:0] hc_out
);

    hamming_encoder HE(
        .clk    (clk   ),
        .rst_n  (arstn ),
        .wren   (wren  ),
        .data   (data  ),
        .hc_out (hc_out)
    );

    hamming_decoder HD(
        .clk   (clk  ),
        .rst_n (arstn),
        .rden  (rden ),        
        .q     (q    ),
        .hc_in (hc_in)
    );

endmodule
