`timescale 1ps / 1ps

module transceiver_top (
    input  wire        clk,
    input  wire        rst,
    input  wire        data,
    input  wire        en,
    output wire        done,
    output wire        q,
    output wire [11:0] modulator_out 
);                    
    
    wire        data_valid;
    wire [7:0]  uart_rx_out;
    wire [11:0] encoder_out; 
    wire [7:0]  decoder_out;
        
    UART_RX #(
        .CLKS_PER_BIT (1000000/115200)
    ) uart_rx_inst (
        .i_Clock     (clk),
        .i_Rst_L     (rst),
        .i_RX_Serial (data),
        .o_RX_DV     (data_valid),
        .o_RX_Byte   (uart_rx_out)
    );

    hamming_encoder encoder_inst (
        .clk  (clk),
        .rst  (rst),
        .data (uart_rx_out),
        .q    (encoder_out)
    );

    hamming_decoder decoder_inst (
        .clk  (clk),
        .rst  (rst),
        .data (encoder_out),
        .q    (decoder_out)
    );
    
    UART_TX #(
        .CLKS_PER_BIT (1000000/115200)
    ) uart_tx_inst (
        .i_Clock     (clk),
        .i_Rst_L     (rst),
        .i_TX_DV     (data_valid),
        .i_TX_Byte   (decoder_out),
        .o_TX_Active (),
        .o_TX_Done   (done),
        .o_TX_Serial (q)
    );
    
    bpsk_modulator #(
        .SAMPLE_NUMBER (256),
        .SAMPLE_WIDTH  (12),
        .DATA_WIDTH    (12)
    ) bpsk_modulator_inst (
        .clk        (clk),
        .rst        (rst),
        .en         (en),
        .data       (encoder_out),
        .signal_out (modulator_out)
    );

endmodule
