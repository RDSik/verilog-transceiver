`timescale 1ps / 1ps

module decoder #(
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire [DATA_WIDTH:0]   in,
    output reg  [DATA_WIDTH-1:0] out_byte,
    output reg                   err
);
    
    wire parity; 

    always @(posedge clk or posedge arst)
        begin
            if (arst) begin
                out_byte <= 8'd0;
            end
            else if (in[8] == parity) 
                begin
                    err <= 0;
                end
            else 
                begin
                    err <= 1;
                end
            out_byte <= in[7:0];
        end

    assign parity = in[0]^in[1]^in[2]^in[3]^in[4]^in[5]^in[6]^in[7];

endmodule
