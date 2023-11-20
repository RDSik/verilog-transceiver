`timescale 1ps / 1ps

module fsk_demodulator (
    input  wire clk,
    input  wire data,
    input  wire s,
    output reg  q1,
    output reg  q2 
);

    always @(posedge clk) 
        begin 
            if(~s) 
                begin 
                    q1 <= data; 
                    q2 <= 0; 
                end 
            else 
                begin 
                    q1 <= 0; 
                    q2 <= data; 
                end 
        end 

endmodule 
