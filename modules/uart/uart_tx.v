`timescale 1ps / 1ps

module uart_tx #(
    parameter CLOCK_RATE = 100_000_000, // 100 MHz
    parameter BAUD_RATE  = 115_200,
    parameter DATA_WIDTH = 8
) (     
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  dv,   // data valid signal   
    input  wire [DATA_WIDTH-1:0] data,
    output reg                   active,
    output reg                   done,
    output reg                   q
);

    localparam CLK_PER_BIT = CLOCK_RATE/BAUD_RATE;
    localparam [2:0] IDLE    = 3'b000, 
                     START   = 3'b001, 
                     TX_DATA = 3'b010, 
                     STOP    = 3'b011, 
                     CLEANUP = 3'b100;

    reg [DATA_WIDTH-1:0]          tx_data;
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
                                clk_cnt <= 0;
                                bit_cnt <= 0;                                
                                done    <= 0;
                                q       <= 1;
                                if (dv == 1)
                                    begin
                                        tx_data <= data;
                                        active  <= 1;                                        
                                        state   <= START;
                                    end
                                else
                                    begin
                                        state <= IDLE;
                                    end
                            end
                        START:
                            begin
                                q <= 0;
                                if (clk_cnt < CLK_PER_BIT - 1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= START;
                                    end
                                else 
                                    begin
                                        clk_cnt <= 0;
                                        state   <= TX_DATA;
                                    end
                            end 
                        TX_DATA:
                            begin
                                q <= tx_data[bit_cnt];
                                if (clk_cnt < CLK_PER_BIT - 1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= TX_DATA;
                                    end
                                else 
                                    begin
                                        clk_cnt <= 0;
                                        if (bit_cnt < 7)
                                            begin
                                                bit_cnt <= bit_cnt + 1;
                                                state   <= TX_DATA;
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
                                q <= 1;
                                if (clk_cnt < CLK_PER_BIT-1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state   <= STOP;
                                    end 
                                else
                                    begin
                                        clk_cnt <= 0;
                                        active  <= 0;
                                        done    <= 1;
                                        state   <= CLEANUP;                                        
                                    end
                            end 
                        CLEANUP:
                            begin
                                done  <= 0;
                                state <= IDLE;
                            end 
                        default : state <= IDLE; 
                    endcase
                end
        end
    
endmodule