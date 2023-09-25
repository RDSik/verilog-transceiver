`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.09.2023 11:19:16
// Design Name: 
// Module Name: transceiver_top
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


module transceiver_top (
    input  wire       clk,
    input  wire       arst, // asynchronous reset
    input  wire       in,
    output wire       err,
    output wire [7:0] out_byte
);                    
    
    wire [8:0] data;
    wire done;
    
receiver receiver_inst (
    .clk  (clk),
    .arst (arst),
    .in   (in),
    .done (done),
    .out  (data)
);

decoder decoder_inst (
    .clk      (clk),
    .arst     (arst),
    .data     (data),
    .err      (err),
    .out_byte (out_byte)
);
    
endmodule
