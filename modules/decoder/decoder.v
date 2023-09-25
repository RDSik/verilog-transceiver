`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2023 11:05:16
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder (
    input  wire       clk,
    input  wire       arst, // asynchronous reset
    input  wire [8:0] data,
    output reg        err,
    output reg [7:0]  out_byte
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
