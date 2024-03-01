module bpsk_modulator #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                             clk,
    input  wire                             rst_n,
    input  wire                             en,
    input  wire [DATA_WIDTH-1:0]            data,
    input  wire [SAMPLE_WIDTH-1:0]          sin_in,
    input  wire [SAMPLE_WIDTH-1:0]          neg_sin_in,
    input  wire [$clog2(SAMPLE_NUMBER)-1:0] cnt_in, 
    output reg  [SAMPLE_WIDTH-1:0]          signal_out 
);

    reg [$clog2(DATA_WIDTH)-1:0] sel_cnt; //! bit counter in select signal
    reg [DATA_WIDTH-1:0]         sel;     //! register for input select signal

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin                 
            sel_cnt <= 0;
        end 
        else if (en) begin
            signal_out <= sel[sel_cnt] ? sin_in : neg_sin_in;                    
            if (cnt_in == SAMPLE_NUMBER-1) begin //! one period of sin
                sel_cnt <= sel_cnt + 1;                            
                if (sel_cnt == DATA_WIDTH-1) begin //! in[11:0] bit
                    sel_cnt <= 0;
                    sel     <= data;
                end                  
            end
        end
        else begin                
            signal_out <= 'bz;
        end
    end

endmodule
