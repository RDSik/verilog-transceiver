`timescale 1ps / 1ps

module uart_tx #(
    parameter CLOCK_RATE = 1_000_000, // 100 MHz
    parameter BAUD_RATE  = 115_200,
    parameter DATA_WIDTH = 8
) (     
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  dv,   // data valid signal   
    input  wire [DATA_WIDTH-1:0] data,
    output wire                  active,
    output wire                  done,
    output reg                   q
);

    localparam CLK_PER_BIT = CLOCK_RATE/BAUD_RATE;
    localparam [2:0] IDLE    = 3'b000, 
                     START   = 3'b001, 
                     TX_DATA = 3'b010, 
                     STOP    = 3'b011, 
                     CLEANUP = 3'b100;

    reg                           tx_active;
    reg                           tx_done;
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
                                q <= 1;
                                tx_done <= 0;
                                clk_cnt <= 0;
                                bit_cnt <= 0;
                                if (dv == 1)
                                    begin
                                        tx_active <= 1;
                                        tx_data <= data;
                                        state <= START;
                                    end
                                else
                                    begin
                                        state <= IDLE;
                                    end
                            end
                        START:
                            begin
                                q <= 0;
                                if (clk_cnt <= CLK_PER_BIT - 1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state <= START;
                                    end
                                else 
                                    begin
                                        clk_cnt <= 0;
                                        state <= TX_DATA;
                                    end
                            end 
                        TX_DATA:
                            begin
                                q <= tx_data[bit_cnt];
                                if (clk_cnt < CLK_PER_BIT - 1)
                                    begin
                                        bit_cnt <= bit_cnt + 1;
                                        state <= TX_DATA;
                                    end
                                else 
                                    begin
                                        clk_cnt <= 0;
                                        if (bit_cnt < 7)
                                            begin
                                                clk_cnt <= clk_cnt + 1;
                                                state <= TX_DATA;
                                            end
                                        else
                                            begin
                                                bit_cnt <= 0;
                                                state <= STOP;
                                            end
                                    end
                            end
                        STOP:
                            begin
                                q <= 1;
                                if (clk_cnt < CLK_PER_BIT-1)
                                    begin
                                        clk_cnt <= clk_cnt + 1;
                                        state <= STOP;
                                    end 
                                else
                                    begin
                                        tx_done <= 1;
                                        clk_cnt <= 0;
                                        state <= CLEANUP;
                                        tx_active <= 0;
                                    end
                            end 
                        CLEANUP:
                            begin
                                tx_done <= 1;
                                state <= IDLE;
                            end 
                        default : state <= IDLE; 
                    endcase
                end
        end

    assign active = tx_active;
    assign done = tx_done;
    
endmodule
