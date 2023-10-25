`timescale 1ps / 1ps

module transceiver_top #(
    parameter SINE_WIDTH = 12,
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  in_bit,
    input  wire                  en,
    output wire                  err,
    output wire                  done,
    output wire [DATA_WIDTH-1:0] out_byte,
    output wire [SINE_WIDTH-1:0] signal_out
);                    
    
    wire [DATA_WIDTH-1:0] data;
    // wire                  clk100;
    // wire                  clk10; 
        
    receiver #(
        .DATA_WIDTH (DATA_WIDTH)
    ) receiver_inst (
        // .clk       (clk10),
        .clk       (clk),
        .arst      (arst),
        .in_bit    (in_bit),
        .done      (done),
        .out_byte  (data)
    );

    bpsk_modulator #(
        .SINE_WIDTH (SINE_WIDTH),
        .DATA_WIDTH (DATA_WIDTH)
    ) bpsk_modulator_inst (
        // .clk        (clk100),
        .clk        (clk),
        .arst       (arst),
        .en         (en),
        .in_byte    (data),
        .signal_out (signal_out)
    );

    decoder #(
        .DATA_WIDTH (DATA_WIDTH)
    ) decoder_inst (
        // .clk      (clk10),
        .clk      (clk),
        .arst     (arst),
        .in_byte  (data),
        .err      (err),
        .out_byte (out_byte)
    );

    // clk_wiz clk_wiz_inst (
        // .clk(clk),
        // .clk100(clk100),
        // .clk10(clk10)
    // );

endmodule
