`timescale 1ps / 1ps

module uart_rx #(
    parameter CLOCK_RATE = 100_000_000, // 100 MHz
    parameter BAUD_RATE  = 115_200, 
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  data,
    output reg                   dv, // data valid signal
    output reg [DATA_WIDTH-1:0]  q
);
    
    localparam CLK_PER_BIT = CLOCK_RATE/BAUD_RATE;
    localparam [2:0] IDLE    = 3'b000, 
                     START   = 3'b001, 
                     RX_DATA = 3'b010, 
                     STOP    = 3'b011, 
                     CLEANUP = 3'b100;

    reg [2:0]                     state;
    reg [$clog2(DATA_WIDTH)-1:0]  bit_cnt; // bit counter in rx_byte register
    reg [$clog2(CLK_PER_BIT)-1:0] clk_cnt; // clock counter

    always @(posedge clk or posedge arst)
        begin
            if (arst)
                begin 
                    state <= IDLE;               
                end
            else
                begin
                    case (state)
                        IDLE: 
                            begin
                                bit_cnt <= 0;
                                clk_cnt <= 0;
                                rx_dv   <= 0;
                                if (data == 0)
                                    begin
                                        state <= START;
                                    end
                                else
                                    begin
                                        state <= IDLE;
                                    end
                            end
                        START:
                            begin
                                if (clk_cnt == (CLK_PER_BIT-1)/2)
                                    begin
                                        if (data == 0)
                                            begin
                                                clk_cnt <= 0;
                                                state   <= RX_DATA;
                                            end
                                        else
                                            begin
                                                state <= IDLE;        
                                            end
                                    end
                                else
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= START;
                                    end
                            end
                        RX_DATA:
                            begin
                                if (clk_cnt < CLK_PER_BIT-1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= RX_DATA;
                                    end
                                else
                                    begin 
                                        q[bit_cnt] <= data;
                                        clk_cnt    <= 0;
                                        if (bit_cnt < 7)
                                            begin
                                                bit_cnt <= bit_cnt + 1;
                                                state   <= RX_DATA;
                                            end
                                        else
                                            begin 
                                                bit_cnt <= 0;
                                                state   <= STOP;
                                            end
                                    end
                            end
                        STOP:
                            begin
                                if (clk_cnt < CLK_PER_BIT-1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= STOP;
                                    end
                                else
                                    begin 
                                        dv      <= 1;
                                        clk_cnt <= 0;
                                        state   <= CLEANUP;                                        
                                    end
                            end
                        CLEANUP:
                            begin
                                dv    <= 0;
                                state <= IDLE;
                            end
                        default: state <= IDLE;
                    endcase
                end
        end

endmodule
