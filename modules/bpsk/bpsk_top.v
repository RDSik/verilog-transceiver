`default_nettype none
`timescale 1ps / 1ps

module bpsk_top #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                  clk,
    input  wire                  rst,
    input  wire                  en,
    input  wire [DATA_WIDTH-1:0] data,
    output wire [DATA_WIDTH-1:0] q
);

    wire [SAMPLE_WIDTH-1:0]          sine_out;
    wire [SAMPLE_WIDTH-1:0]          neg_sine_out;
    wire [$clog2(SAMPLE_NUMBER)-1:0] signal_cnt_out;
    wire [SAMPLE_WIDTH-1:0]          modulator_out;

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
        .data        (data),
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
        .q           (q)
    );

endmodule
