`timescale 1ps / 1ps

module bpsk_modulator #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    en,
    input  wire [DATA_WIDTH-1:0]   data,
    output reg  [SAMPLE_WIDTH-1:0] signal_out 
);

    reg [SAMPLE_WIDTH-1:0] sine_rom [SAMPLE_NUMBER-1:0];
    reg [SAMPLE_WIDTH-1:0] neg_sine_rom [SAMPLE_NUMBER-1:0];

    reg [$clog2(SAMPLE_NUMBER)-1:0] signal_cnt; // sine sample counter in output signal
    reg [$clog2(DATA_WIDTH)-1:0]    sel_cnt;    // bit counter in select signal
    reg [DATA_WIDTH-1:0]            sel;        // register for input select signal

    initial 
        begin
            $readmemb("sine_value.dat", sine_rom);
            $readmemb("neg_sine_value.dat", neg_sine_rom);
        end

    always @(posedge clk or negedge rst)
        begin
            if (~rst)
                begin 
                    signal_cnt <= 0;
                    sel_cnt    <= 0;
                end 
            else if (en)
                begin
                    signal_out <= sel[sel_cnt] ? sine_rom[signal_cnt] : neg_sine_rom[signal_cnt];                         
                    signal_cnt <= signal_cnt + 1;
                    if (signal_cnt == SAMPLE_NUMBER-1) // one period of sine
                        begin
                            sel_cnt <= sel_cnt + 1;
                            sel     <= data;
                            if (sel_cnt == DATA_WIDTH-1) // in[11:0]
                                begin
                                    sel_cnt <= 0;
                                end                  
                        end
                end
            else 
                begin 
                    signal_out <= 12'bz;
                end
        end

endmodule
