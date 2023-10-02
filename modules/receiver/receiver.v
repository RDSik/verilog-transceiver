`timescale 1ps / 1ps

module receiver #(
    parameter DATA_WIDTH = 8
) (
    input  wire                clk,
    input  wire                arst, // asynchronous reset
    input  wire                in,
    output wire                done,
    output wire [DATA_WIDTH:0] out
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
    
    reg [3:0]          next_state;
    reg [3:0]          state; 
    reg [DATA_WIDTH:0] data;
    
    always @(*)
        begin
            case (state)
                START: begin
                    if (in) // 1- start bit
                        next_state = D0;
                    else
                        next_state = START; 
                end
                D0: begin
                    next_state = D1;
                    data[0] = in;
                end
                D1: begin
                    next_state = D2;
                    data[1] = in;
                end
                D2: begin
                    next_state = D3;
                    data[2] = in;
                end
                D3: begin
                    next_state = D4;
                    data[3] = in;
                end
                D4: begin
                    next_state = D5;
                    data[4] = in;
                end
                D5: begin
                    next_state = D6;
                    data[5] = in;
                end
                D6: begin
                    next_state = D7;
                    data[6] = in;
                end
                D7: begin
                    next_state = D8;
                    data[7] = in;
                end
                D8: begin
                    next_state = STOP;                    
                    data[8] = (data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7])^in; // parity bit
                end
                STOP: begin
                    if (in && data[8]) // 1 - stop bit
                        next_state = DONE;                        
                    else 
                        next_state = START;
                end
                DONE: begin                    
                    if (!in)
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
    assign out = done ? data : 9'd0;
    
endmodule
