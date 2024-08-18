// Description: x^12 + x^11 + x^3 + x^2 + x + 1
// Algorithm   : CRC-12
// Polynomial  : 0x80F
// Init value  : 0xFFF

module crc12 #(
    parameter DATA_WIDHT = 8;
    parameter CRC_WIDTH  = 12;
) (
    input  wire                  clk,
    input  wire                  arstn,
    input  wire                  en,
    input  wire [DATA_WIDHT-1:0] data,
    output reg  [CRC_WIDTH-1:0 ] crc12
);
  
    always @(posedge clk or negedge arstn)
        begin
            if (~arstn) begin
                crc12 <= 12'hfff;
            end else begin
                crc12 <= en ? crc12_nbit(crc12, data) : crc12;
            end
        end

    function [CRC_WIDTH-1:0] crc12_nbit;
        input [CRC_WIDTH-1:0 ] crc;
        input [DATA_WIDHT-1:0] data;
        integer                i;
        begin
            crc12_nbit = crc;
            for (i = 0; i < DATA_WIDHT; i = i + 1) begin
                // feedback = crc[11] ^ data[i];
                crc12_nbit     = crc << 1;
                crc12_nbit[0]  = crc[11] ^ data[i];
                crc12_nbit[1]  = crc[11] ^ data[i] ^ crc[0];
                crc12_nbit[2]  = crc[11] ^ data[i] ^ crc[1];
                crc12_nbit[3]  = crc[11] ^ data[i] ^ crc[2];
                crc12_nbit[11] = crc[11] ^ data[i] ^ crc[10];
            end
        end
        
    endfunction

endmodule
