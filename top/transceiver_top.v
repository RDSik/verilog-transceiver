`timescale 1ps / 1ps

module transceiver_top (
    input  wire        clk,
    input  wire        arst, // asynchronous reset
    input  wire        in,
    output wire        err,
    output wire        en,
    output wire [11:0] signal_out
);                    
    
    wire [8:0] data;
    wire [7:0] out_byte; 
    wire done;
    
receiver #(
    .DATA_WIDTH (8)
) receiver_inst (
    .clk  (clk),
    .arst (arst),
    .in   (in),
    .done (done),
    .out  (data)
);

bpsk_modulator #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .en         (en),
    .in         (data),
    .signal_out (signal_out)
);

decoder #(
    .DATA_WIDTH (8)
) decoder_inst (
    .clk      (clk),
    .arst     (arst),
    .data     (data),
    .err      (err),
    .out_byte (out_byte)
);

endmodule