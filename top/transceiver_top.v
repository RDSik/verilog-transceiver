`timescale 1ns / 1ns

module transceiver_top (
    input  wire       clk,
    input  wire       arst, // asynchronous reset
    input  wire       in,
    output wire       err,
    output wire [7:0] out_byte
);                    
    
    wire [8:0] data;
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

decoder #(
    .DATA_WIDTH (8)
) decoder_inst (
    .clk      (clk),
    .arst     (arst),
    .data     (data),
    .err      (err),
    .out_byte (out_byte)
);

/*bpsk_modulator #(
    .DATA_WIDTH (12),
    .ADDR_WIDTH (8)
) dut (
    .clk        (clk),
    .arst       (arst),
    .en         (),
    .s          (),
    .signal_out ()
);*/

endmodule