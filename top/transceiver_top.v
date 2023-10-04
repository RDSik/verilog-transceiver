`timescale 1ps / 1ps

module transceiver_top #(
    parameter DATA_WIDTH = 12,
              ADDR_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  in,
    input  wire                  en,
    output wire                  err,
    output wire                  done,
    output wire [ADDR_WIDTH-1:0] out_byte,
    output wire [DATA_WIDTH-1:0] signal_out
);                    
    
    wire [ADDR_WIDTH:0] data; 
    
receiver #(
    .DATA_WIDTH (ADDR_WIDTH)
) receiver_inst (
    .clk  (clk),
    .arst (arst),
    .in   (in),
    .done (done),
    .out  (data)
);

bpsk_modulator #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
) bpsk_modulator_inst (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in         (data),
    .signal_out (signal_out)
);

decoder #(
    .DATA_WIDTH (ADDR_WIDTH)
) decoder_inst (
    .clk      (clk),
    .arst     (arst),
    .in       (data),
    .err      (err),
    .out_byte (out_byte)
);

endmodule
