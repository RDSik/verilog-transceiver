`timescale 1ns / 1ns

module decoder #(
    parameter DATA_WIDTH = 8
) (
    input  wire                  clk,
    input  wire                  arst, // asynchronous reset
    input  wire [DATA_WIDTH:0]   data,
    output reg  [DATA_WIDTH-1:0] out_byte,
    output reg                   err
);
    
    wire parity; 

    always @(posedge clk or posedge arst)
        begin
            if (arst) begin
                out_byte <= 8'd0;
            end
            else if (!parity) begin
                err <= 0;
                out_byte <= data[7:0];
            end
            else begin
                err <= 1;
            end
        end

    assign parity = (data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6]^data[7])^data[8];

endmodule
