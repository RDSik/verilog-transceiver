//! @title digital_transceiver module design
//! @author Dmitry Ryabikov

`default_nettype none
`timescale 1ps / 1ps

module transceiver_top #(
    parameter CLKS_PER_BIT  = 1_000_000/115_200, //! 1 MHz and 115_200 Baud
    parameter SAMPLE_NUMBER = 256,               //! numbers of sample in one sine period
    parameter SAMPLE_WIDTH  = 12,                //! sample width
    parameter DATA_WIDTH    = 12                 //! data width
) (
    input  wire clk,  //! clock  input (1 MHz for simulation for normal working on board swith to 100 MHz)
    input  wire rst,  //! reset  input (negative)
    input  wire data, //! data   input 
    input  wire en,   //! enable input
    output wire q     //! quit   output
);                    
    
    // wire                             clk10_out; //! 10 MHz clock from PLL
    wire                             done;            //! uart transmit done output
    wire                             active;          //! uart transmit active output 
    wire                             data_valid;      //! uart transmit data valid output
    wire [7:0]                       uart_rx_out;     //! uart receive instance output
    wire [7:0]                       decoder_out;     //! hamming decoder instance output 
    wire [DATA_WIDTH-1:0]            encoder_out;     //! hamming encoder instance output 
    wire [$clog2(SAMPLE_NUMBER)-1:0] cnt_out;         //! sine generator counter output
    wire [DATA_WIDTH-1:0]            demodulator_out; //! binary phase shift key demodulator instance output
    wire [SAMPLE_WIDTH-1:0]          modulator_out;   //! binary phase shift key modulator instance output 
    wire [SAMPLE_WIDTH-1:0]          neg_sin_out;     //! negative sine generator output
    wire [SAMPLE_WIDTH-1:0]          sin_out;         //! sine generator output

    UART_RX #(                       //! uart receive instance
        .CLKS_PER_BIT (CLKS_PER_BIT)
    ) uart_rx_inst (
        // .i_Clock     (clk10_out),
        .i_Clock     (clk),
        .i_Rst_L     (rst),
        .i_RX_Serial (data),
        .o_RX_DV     (data_valid),
        .o_RX_Byte   (uart_rx_out)
    );

    hamming_encoder encoder_inst (   //! hamming encoder instance
        // .clk   (clk10_out), 
        .clk    (clk),
        .rst_n  (rst),
        .wren   (en),
        .data   (uart_rx_out),
        .hc_out (encoder_out)
    );

    sin_generator #(                 //! sine generator instance (generate sine and negative sine sample from .dat files using a counter)
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH)
    ) sin_generator_inst (
        .clk         (clk),
        .rst         (rst),
        .en          (en),
        .sin_out     (sin_out),
        .neg_sin_out (neg_sin_out),
        .cnt_out     (cnt_out)
    );

    bpsk_modulator #(                //! binary phase shift key modulator instance
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH),
        .DATA_WIDTH    (DATA_WIDTH)
    ) bpsk_modulator_inst (
        .clk        (clk),
        .rst        (rst),
        .en         (en),
        .data       (encoder_out),
        .sin_in     (sin_out),
        .neg_sin_in (neg_sin_out),
        .cnt_in     (cnt_out),
        .signal_out (modulator_out)
    );

    bpsk_demodulator #(              //! binary phase shift key demodulator instance 
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH),
        .DATA_WIDTH    (DATA_WIDTH)
    ) bpsk_demodulator_inst (
        .clk        (clk),
        .rst        (rst),
        .en         (en),
        .signal_in  (modulator_out),
        .sin_in     (sin_out),
        .neg_sin_in (neg_sin_out),
        .cnt_in     (cnt_out),
        .q          (demodulator_out)
    );

    hamming_decoder decoder_inst (   //! hamming decoder instance
        // .clk   (clk10_out), 
        .clk   (clk),
        .rst_n (rst),
        .rden  (en),
        .hc_in (demodulator_out),
        .q     (decoder_out)
    );
    
    UART_TX #(                       //! uart transmit instance
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

    // clk_wiz clk_wiz_inst (        //! PLL for 10 MHz clock 
        // .clk100_in (clk),
        // .clk10_out (clk10_out)
    // );

endmodule
