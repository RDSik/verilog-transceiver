`timescale 1ps / 1ps

module uart_rx #(
    parameter CLOCK_RATE = 1_000_000, // 1 MHz
    parameter BAUD_RATE  = 115_200,
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  data,
    output wire                  done,
    output wire [DATA_WIDTH-1:0] q
);
    
    localparam CLK_PER_BIT = CLOCK_RATE/BAUD_RATE;
    localparam [2:0] IDLE    = 3'b000, 
                     START   = 3'b001, 
                     RX_DATA = 3'b010, 
                     STOP    = 3'b011, 
                     CLEANUP = 3'b100;

    reg                           rx_data_r = 1'b1;
    reg                           rx_data   = 1'b1;
    reg                           rx_done;
    reg [DATA_WIDTH-1:0]          rx_byte;
    reg [2:0]                     state;
    reg [$clog2(DATA_WIDTH)-1:0]  bit_cnt; // bit counter in rx_byte register
    reg [$clog2(CLK_PER_BIT)-1:0] clk_cnt; // clock counter

    // Purpose: Double-register the incoming data.
    // This allows it to be used in the UART RX Clock Domain (it removes problems caused by metastability)
    always @(posedge clk)
        begin
            rx_data_r <= data;
            rx_data <= rx_data_r;
        end

    always @(posedge clk or posedge arst)
        begin
            if (arst)
                begin 
                    bit_cnt <= 0;
                    clk_cnt <= 0;
                end
            else
                case (state)
                    IDLE: 
                        begin
                            if (~data)
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
                                            state <= RX_DATA;
                                        end
                                    else
                                        begin
                                            state <= IDLE;        
                                        end
                                end
                            else
                                begin
                                    clk_cnt <= clk_cnt + 1;
                                    state <= START;
                                end
                        end
                    RX_DATA:
                        begin
                            if (clk_cnt < CLK_PER_BIT-1)
                                begin
                                    clk_cnt <= clk_cnt + 1;
                                    state <= RX_DATA;
                                end
                            else
                                begin 
                                    clk_cnt <= 0;
                                    rx_byte[bit_cnt] <= data;
                                    if (bit_cnt < 7)
                                        begin
                                            bit_cnt <= bit_cnt + 1;
                                            state <= RX_DATA;
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
                            if (clk_cnt < CLK_PER_BIT-1)
                                begin
                                    clk_cnt <= clk_cnt + 1;
                                    state <= STOP;
                                end
                            else
                                begin 
                                    rx_done <= 1;
                                    clk_cnt <= 0;
                                    state <= CLEANUP;
                                end
                        end
                    CLEANUP:
                        begin
                            rx_done <= 0;
                            state <= IDLE;
                        end
                    default: state <= IDLE;
                endcase
        end

    assign done = rx_done;
    assign q = rx_byte;

endmodule
