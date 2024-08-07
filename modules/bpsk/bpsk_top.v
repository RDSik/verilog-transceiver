`default_nettype none

module bpsk_top #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                  clk,
    input  wire                  arstn,
    input  wire                  en,
    input  wire [DATA_WIDTH-1:0] data,
    output wire [DATA_WIDTH-1:0] q
);

    wire [SAMPLE_WIDTH-1:0         ] sin_out;
    wire [SAMPLE_WIDTH-1:0         ] neg_sin_out;
    wire [$clog2(SAMPLE_NUMBER)-1:0] cnt_out;
    wire [SAMPLE_WIDTH-1:0         ] modulator_out;

    sin_generator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH )    
    ) sin_generator_inst (
        .clk         (clk        ),
        .arstn       (arstn      ),
        .en          (en         ),
        .sin_out     (sin_out    ),
        .neg_sin_out (neg_sin_out),
        .cnt_out     (cnt_out    )
    );

    bpsk_modulator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH ),
        .DATA_WIDTH    (DATA_WIDTH   )
    ) bpsk_modulator_inst (
        .clk        (clk          ),
        .arstn      (arstn        ),
        .en         (en           ),
        .data       (data         ),
        .sin_in     (sin_out      ),
        .neg_sin_in (neg_sin_out  ),
        .cnt_in     (cnt_out      ),
        .signal_out (modulator_out)
    );

    bpsk_demodulator #(
        .SAMPLE_NUMBER (SAMPLE_NUMBER),
        .SAMPLE_WIDTH  (SAMPLE_WIDTH ),
        .DATA_WIDTH    (DATA_WIDTH   )
    ) bpsk_demodulator_inst (
        .clk        (clk          ),
        .arstn      (arstn        ),
        .en         (en           ),
        .signal_in  (modulator_out),
        .sin_in     (sin_out      ),
        .neg_sin_in (neg_sin_out  ),
        .cnt_in     (cnt_out      ),
        .q          (q            )
    );

endmodule
