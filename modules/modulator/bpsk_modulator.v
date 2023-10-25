`timescale 1ps / 1ps

module bpsk_modulator #(
    parameter SINE_WIDTH = 12,
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  en,
    input  wire [DATA_WIDTH-1:0] in_byte,
    output reg  [SINE_WIDTH-1:0] signal_out 
);

    reg [SINE_WIDTH-1:0] sine_rom [2**DATA_WIDTH-1:0];
    reg [SINE_WIDTH-1:0] neg_sine_rom [2**DATA_WIDTH-1:0];

    reg [DATA_WIDTH-1:0]         sine_cnt; // output sine signal counter
    reg [DATA_WIDTH-1:0]         sel;      // register for input select signal
    reg [$clog2(DATA_WIDTH)-1:0] sel_cnt;  // select signal counter

    initial 
        begin
            $readmemb("sine_value.dat", sine_rom);
            $readmemb("neg_sine_value.dat", neg_sine_rom);
        end

    always @(posedge clk or posedge arst)
        begin
            if (arst)
                begin 
                    sine_cnt <= 0;
                    sel_cnt <= 0;
                end 
            else if (en)
                begin
                    signal_out <= sel[sel_cnt] ? sine_rom[sine_cnt] : neg_sine_rom[sine_cnt];                         
                    sine_cnt <= sine_cnt + 1;
                    if (sine_cnt == 8'd255) // one period of sine
                        begin
                            sel <= in_byte;
                            sel_cnt <= sel_cnt + 1;                  
                        end
                end
            else 
                begin
                    signal_out <= 12'bz;
                end
        end

endmodule
