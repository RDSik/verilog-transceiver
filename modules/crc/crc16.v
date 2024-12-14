// Description : x^16 + x^12 + x^5 + 1
// Algorithm   : CRC-16-CCIT
// Polynomial  : 0x1021
// Init value  : 0xFFFF

module crc16 #(
    parameter DATA_WIDHT = 8,
    parameter CRC_WIDTH  = 16
) (
    input  wire                  clk,
    input  wire                  arstn,
    input  wire                  en,
    input  wire [DATA_WIDHT-1:0] data,
    output reg  [CRC_WIDTH-1:0 ] crc16
);
  
    always @(posedge clk or negedge arstn) begin
        if (~arstn) begin
            crc16 <= 16'hffff;
        end else begin
            crc16 <= en ? crc16_byte(crc16, data) : crc16;
        end
    end

    function [CRC_WIDTH-1:0] crc16_bit;
        input [CRC_WIDTH-1:0] crc;
        input                 data;
        begin
            crc16_bit     = crc << 1;
            crc16_bit[0]  = crc[15] ^ data;
            crc16_bit[5]  = crc[15] ^ data ^ crc[4];
            crc16_bit[12] = crc[15] ^ data ^ crc[11];
        end
    endfunction

    function [CRC_WIDTH-1:0] crc16_byte;
        input [CRC_WIDTH-1:0 ] crc;
        input [DATA_WIDHT-1:0] data;
        integer                i;
        begin
            crc16_byte = crc;
            for (i = DATA_WIDHT - 1; i >= 0; i = i - 1) begin
                crc16_byte = crc16_bit(crc16_byte, data[i]);
            end
        end
    endfunction

endmodule
