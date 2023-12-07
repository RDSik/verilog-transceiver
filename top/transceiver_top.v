`default_nettype none
`timescale 1ps / 1ps

module transceiver_top #(
    parameter CLKS_PER_BIT  = 1_000_000/115_200,
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire clk,
    input  wire rst,
    input  wire data,
    input  wire en,
    output wire q  
);                    
    
    // wire                             clk10_out;
    wire                             done;
    wire                             active;
    wire                             data_valid;
    wire [7:0]                       uart_rx_out;    
    wire [7:0]                       decoder_out;
    wire [DATA_WIDTH-1:0]            encoder_out; 
    wire [$clog2(SAMPLE_NUMBER)-1:0] signal_cnt_out;
    wire [DATA_WIDTH-1:0]            demodulator_out;
    wire [SAMPLE_WIDTH-1:0]          modulator_out;
    wire [SAMPLE_WIDTH-1:0]          neg_sine_out;
    wire [SAMPLE_WIDTH-1:0]          sine_out;

    UART_RX #(
        .CLKS_PER_BIT (CLKS_PER_BIT)
    ) uart_rx_inst (
        // .i_Clock     (clk10_out),
        .i_Clock     (clk),
        .i_Rst_L     (rst),
        .i_RX_Serial (data),
        .o_RX_DV     (data_valid),
        .o_RX_Byte   (uart_rx_out)
    );

    hamming_encoder encoder_inst (
        // .clk   (clk10_out), 
        .clk    (clk),
        .rst_n  (rst),
        .wren   (en),
        .data   (uart_rx_out),
        .hc_out (encoder_out)
    );

    sine_generator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH)
    ) sine_generator_inst (
        .clk          (clk),
        .rst          (rst),
        .en           (en),
        .sine_out     (sine_out),
        .neg_sine_out (neg_sine_out),
        .signal_cnt   (signal_cnt_out)
    );

    bpsk_modulator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH),
        .DATA_WIDTH    (DATA_WIDTH)
    ) bpsk_modulator_inst (
        .clk         (clk),
        .rst         (rst),
        .en          (en),
        .data        (encoder_out),
        .sine_in     (sine_out),
        .neg_sine_in (neg_sine_out),
        .cnt_in      (signal_cnt_out),
        .signal_out  (modulator_out)
    );

    bpsk_demodulator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH),
        .DATA_WIDTH    (DATA_WIDTH)
    ) bpsk_demodulator_inst (
        .clk         (clk),
        .rst         (rst),
        .en          (en),
        .signal_in   (modulator_out),
        .sine_in     (sine_out),
        .neg_sine_in (neg_sine_out),
        .cnt_in      (signal_cnt_out),
        .q           (demodulator_out)
    );

    hamming_decoder decoder_inst (
        // .clk   (clk10_out), 
        .clk   (clk),
        .rst_n (rst),
        .rden  (en),
        .hc_in (demodulator_out),
        .q     (decoder_out)
    );
    
    UART_TX #(
        .CLKS_PER_BIT (CLKS_PER_BIT)
    ) uart_tx_inst (
        // .i_Clock     (clk10_out),
        .i_Clock     (clk),
        .i_Rst_L     (rst),
        .i_TX_DV     (data_valid),
        .i_TX_Byte   (decoder_out),
        .o_TX_Active (active),
        .o_TX_Done   (done),
        .o_TX_Serial (q)
    );

    // clk_wiz clk_wiz_inst (
        // .clk_in     (clk),
        // .clk10_out (clk10_out)
    // );

endmodule
