module bpsk_demodulator #(
    parameter SAMPLE_NUMBER = 256,
    parameter SAMPLE_WIDTH  = 12,
    parameter DATA_WIDTH    = 12
) (
    input  wire                             clk,
    input  wire                             arstn,
    input  wire                             en,
    input  wire [SAMPLE_WIDTH-1:0         ] signal_in,
    input  wire [SAMPLE_WIDTH-1:0         ] sin_in,
    input  wire [SAMPLE_WIDTH-1:0         ] neg_sin_in,
    input  wire [$clog2(SAMPLE_NUMBER)-1:0] cnt_in, 
    output reg  [DATA_WIDTH-1:0           ] q 
);

    reg [$clog2(DATA_WIDTH)-1:0] sel_cnt; //! bit counter in select signal
    reg [DATA_WIDTH-1:0        ] sel;     //! register for input select signal
    reg                          flag;

    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin
            sel_cnt <= 0;
            flag    <= 0;                 
        end else if (en) begin                
            sel[sel_cnt] <= flag ? 1 : 0;                    
            if (cnt_in == SAMPLE_NUMBER-1) begin //! one period of sin
                sel_cnt <= sel_cnt + 1;                            
                if (sel_cnt == DATA_WIDTH-1) begin //! out[11:0] bit
                    sel_cnt <= 0;
                    q       <= sel;
                end                
            end else if (signal_in == sin_in) begin
                flag <= 1;   
            end else if (signal_in == neg_sin_in) begin
                flag <= 0;
            end
        end else begin
            q <= 0;
        end
    end

endmodule
