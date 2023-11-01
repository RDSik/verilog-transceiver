`timescale 1ps / 1ps

module transceiver_top (
    input  wire        clk,
    input  wire        arst, // asynchronous reset
    input  wire        data,
    input  wire        en,
    output wire        done,
    output wire        q,
    output wire [11:0] signal_out
);                    
    
    wire [7:0]  uart_rx_out;
    wire        dv;
    wire [11:0] encoder_out; 
    wire [7:0]  decoder_out;
        
    uart_rx #(
        .CLOCK_RATE (1_000_000), // 1 MHz
        .BAUD_RATE  (115_200),
        .DATA_WIDTH (8)
    ) uart_rx_inst (
        .clk  (clk),
        .arst (arst),
        .data (data),
        .dv   (dv),
        .q    (uart_rx_out)
    );

    hamming_encoder encoder_inst (
        .clk  (clk),
        .arst (arst),
        .data (uart_rx_out),
        .q    (encoder_out)
    );

    bpsk_modulator #(
        .SAMPLE_NUMBER (256),
        .SAMPLE_WIDTH  (12),
        .DATA_WIDTH    (12)
    ) bpsk_modulator_inst (
        .clk        (clk),
        .arst       (arst),
        .en         (en),
        .data       (encoder_out),
        .signal_out (signal_out)
    );

    hamming_decoder decoder_inst (
        .clk  (clk),
        .arst (arst),
        .data (encoder_out),
        .q    (decoder_out)
    );
    
    uart_tx #(
        .CLOCK_RATE (1_000_000), // 1 MHz
        .BAUD_RATE  (115_200),
        .DATA_WIDTH (8)
    ) uart_tx_inst (
        .clk    (clk),
        .arst   (arst),
        .dv     (dv),
        .data   (decoder_out),
        .active (active),
        .done   (done),
        .q      (q)
    );

endmodule
