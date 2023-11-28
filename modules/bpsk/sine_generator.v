`timescale 1ps / 1ps

module sine_generator #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12
) (
    input  wire                             clk,
    input  wire                             rst,
    input  wire                             en,
    output reg  [SAMPLE_WIDTH-1:0]          sine_out,
    output reg  [SAMPLE_WIDTH-1:0]          neg_sine_out,
    output reg  [$clog2(SAMPLE_NUMBER)-1:0] signal_cnt 
);

    reg [SAMPLE_WIDTH-1:0] sine_rom [SAMPLE_NUMBER-1:0];
    reg [SAMPLE_WIDTH-1:0] neg_sine_rom [SAMPLE_NUMBER-1:0];

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
                end 
            else if (en)
                begin
                    sine_out     <= sine_rom[signal_cnt];           
                    neg_sine_out <= neg_sine_rom[signal_cnt];
                    if (signal_cnt == SAMPLE_NUMBER-1)
                        begin
                            signal_cnt <= 0;
                        end                            
                    else 
                        begin
                            signal_cnt <= signal_cnt + 1;
                        end
                end            
        end

endmodule
