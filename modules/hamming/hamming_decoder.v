`timescale 1ps / 1ps

module hamming_decoder (
    input  wire        clk, 
    input  wire        arst, // asynchronous reset
    input  wire [11:0] data,
    output reg  [7:0]  q
);
   
    wire g0_error, g1_error, g2_error,g3_error;
   
    assign g0_error = data[10] ^ data[8] ^ data[6] ^ data[4] ^ data[2] ^ data[0];
    assign g1_error = data[10] ^ data[9] ^ data[6] ^ data[5] ^ data[2] ^ data[1];
    assign g2_error = data[11] ^ data[6] ^ data[5] ^ data[4] ^ data[3];
    assign g3_error = data[11] ^ data[10] ^ data[9] ^ data[8] ^ data[7];
   
    always @ (posedge clk or posedge arst)
        begin
            if(arst)
                begin
                    q <= 0;
                end
            else
                begin
                    case ({g3_error, g2_error, g1_error, g0_error})
                        4'b0000 :   q <= {data[11:8], data[6:4], data[2]};
                        4'b0001 :   q <= {data[11:8], data[6:4], data[2]};
                        4'b0010 :   q <= {data[11:8], data[6:4], data[2]};
                        4'b0011 :   q <= {data[11:8], data[6:4], ~data[2]};
                        4'b0100 :   q <= {data[11:8], data[6:4], data[2]};
                        4'b0101 :   q <= {data[11:8], data[6:5], ~data[4], data[2]};
                        4'b0110 :   q <= {data[11:8], data[6], ~data[5], data[4], data[2]};
                        4'b0111 :   q <= {data[11:8], ~data[6], data[5], data[4], data[2]};
                        4'b1000 :   q <= {data[11:8], data[6], data[5], data[4], data[2]};
                        4'b1001 :   q <= {data[11:9], ~data[8], data[6:4], data[2]};
                        4'b1010 :   q <= {data[11:10], ~data[9], data[8], data[6:4], data[2]};
                        4'b1011 :   q <= {data[11], ~data[10], data[9], data[8], data[6:4], data[2]};
                        4'b1100 :   q <= {~data[11], data[10], data[9], data[8], data[6:4], data[2]};
                        default :   q <= 0;
                endcase
            end
        end

endmodule
