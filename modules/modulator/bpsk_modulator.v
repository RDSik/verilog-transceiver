`timescale 1ps / 1ps

module bpsk_modulator #(
    parameter DATA_WIDTH = 12,
              ADDR_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  en,
    input  wire [ADDR_WIDTH:0]   in,
    output reg  [DATA_WIDTH-1:0] signal_out 
);

reg [DATA_WIDTH-1:0] sine_rom [2**ADDR_WIDTH-1:0];
reg [DATA_WIDTH-1:0] neg_sine_rom [2**ADDR_WIDTH-1:0];
reg [ADDR_WIDTH-1:0]         sine_cnt; // output sine signal counter
reg [$clog2(ADDR_WIDTH)-1:0] sel_cnt;  // select counter
reg                              sel;  // register for input select signal

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
                signal_out <= sel ? sine_rom[sine_cnt] : neg_sine_rom[sine_cnt];     
                sine_cnt <= sine_cnt + 1;
                if (sine_cnt == 8'd127)
                    begin
                        sel <= in[sel_cnt];
                        sel_cnt <= sel_cnt + 1;
                    end                
            end
    end

endmodule
