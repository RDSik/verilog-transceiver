`timescale 1ns / 1ns

module bpsk_modulator #(
    parameter DATA_WIDTH = 12,
              ADDR_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  en,
    input  wire                  s,
    output wire [DATA_WIDTH-1:0] signal_out 
);

wire [DATA_WIDTH-1:0] sin;
wire [DATA_WIDTH-1:0] neg_sin;

neg_sin_gen #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
) neg_sin_gen_inst (
    .clk         (clk),
    .arst        (arst),
    .neg_sin_out (neg_sin)
);

sin_gen  #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
) sin_gen_inst (
    .clk     (clk),
    .arst    (arst),
    .sin_out (sin)
);

mux #(
    .DATA_WIDTH (DATA_WIDTH)
) mux_inst (
    .en         (en),
    .s          (s),
    .sin_in     (sin),
    .neg_sin_in (neg_sin),
    .signal_out (signal_out)
);

endmodule
