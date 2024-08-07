module sin_generator #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter SIN_VALUE     = "sin_val.dat",
    parameter NEG_SIN_VALUE = "neg_sin_val.dat"
) (
    input  wire                             clk,
    input  wire                             arstn,
    input  wire                             en,
    output reg  [SAMPLE_WIDTH-1:0         ] sin_out,
    output reg  [SAMPLE_WIDTH-1:0         ] neg_sin_out,
    output reg  [$clog2(SAMPLE_NUMBER)-1:0] cnt_out
);

    reg [SAMPLE_WIDTH-1:0] sin_rom [0:SAMPLE_NUMBER-1];
    reg [SAMPLE_WIDTH-1:0] neg_sin_rom [0:SAMPLE_NUMBER-1];

    initial begin
        $readmemb(SIN_VALUE, sin_rom);
        $readmemb(NEG_SIN_VALUE, neg_sin_rom);
    end

    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin                     
            cnt_out <= 0;
        end else if (en) begin
            neg_sin_out <= neg_sin_rom[cnt_out];
            sin_out     <= sin_rom[cnt_out];                               
            if (cnt_out == SAMPLE_NUMBER-1) begin
                cnt_out <= 0;
            end else begin
                cnt_out <= cnt_out + 1;
            end
        end else begin
            neg_sin_out <= 'bz;
            sin_out     <= 'bz;    
        end
    end

endmodule
