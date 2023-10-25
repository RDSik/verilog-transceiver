`timescale 1ps / 1ps

module receiver #(
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire                  in_bit,
    output wire                  done,
    output wire [DATA_WIDTH-1:0] out_byte
);
    
    localparam [3:0] START = 4'd0, 
                     D0 = 4'd1, 
                     D1 = 4'd2, 
                     D2 = 4'd3, 
                     D3 = 4'd4, 
                     D4 = 4'd5, 
                     D5 = 4'd6, 
                     D6 = 4'd7, 
                     D7 = 4'd8,
                     D8 = 4'd9, 
                     STOP = 4'd10,
                     DONE = 4'd11;                    
    
    reg                  parity;
    reg [3:0]            next_state;
    reg [3:0]            state; 
    reg [DATA_WIDTH-1:0] data_byte;
    
    always @(*)
        begin
            case (state)
                START: 
                    begin
                        if (in_bit) // 1 - start bit
                            next_state = D0;
                        else
                            next_state = START; 
                    end
                D0: 
                    begin
                        next_state = D1;
                        data_byte[0] = in_bit;
                    end
                D1: 
                    begin
                        next_state = D2;
                        data_byte[1] = in_bit;
                    end
                D2: 
                    begin
                        next_state = D3;
                        data_byte[2] = in_bit;
                    end
                D3: 
                    begin
                        next_state = D4;
                        data_byte[3] = in_bit;
                    end
                D4: 
                    begin
                        next_state = D5;
                        data_byte[4] = in_bit;
                    end
                D5: 
                    begin
                        next_state = D6;
                        data_byte[5] = in_bit;
                    end
                D6: 
                    begin
                        next_state = D7;
                        data_byte[6] = in_bit;
                    end
                D7: 
                    begin
                        next_state = D8;
                        data_byte[7] = in_bit;
                    end
                D8: 
                    begin
                        next_state = STOP;
                        parity = data_byte[0]^data_byte[1]^data_byte[2]^data_byte[3]^data_byte[4]^data_byte[5]^data_byte[6]^data_byte[7]; // parity bit (0 - parity, 1 - not parity)
                    end
                STOP: 
                    begin
                        if (in_bit & parity)
                            next_state = DONE;                        
                        else 
                            next_state = START;
                    end
                DONE: 
                    begin                    
                        if (~in_bit)
                            next_state = START;
                        else
                            next_state = D0;
                    end                         
                default: next_state = START;
            endcase 
        end
        
    always @(posedge clk or posedge arst)
        begin
            if (arst)
                state <= START;
            else
                state <= next_state;
        end
        
    assign done = (state == DONE);
    assign out_byte = done ? data_byte : 8'd0;
    
endmodule
