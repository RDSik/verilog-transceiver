`timescale 1ps / 1ps

module decoder #(
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire [DATA_WIDTH-1:0] in_byte,
    output reg  [DATA_WIDTH-1:0] out_byte,
    output reg                   err
);
    
    reg parity; 

    always @(posedge clk or posedge arst)
        begin
            out_byte <= in_byte;
            parity <= in_byte[0]^in_byte[1]^in_byte[2]^in_byte[3]^in_byte[4]^in_byte[5]^in_byte[6]^in_byte[7];
            if (arst) 
                begin
                    out_byte <= 0;
                end
            else if (parity != 1) 
                begin
                    err <= 1;
                end
            else 
                begin
                    err <= 0;
                end
        end

endmodule

