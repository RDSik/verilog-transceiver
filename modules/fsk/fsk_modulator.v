`timescale 1ps / 1ps

module fsk_modulator(
    input  wire clk,
    input  wire data1,
    input  wire data2,
    input  wire s,
    input  wire f1,
    input  wire f2, 
    output reg  q
);

    always @(posedge clk) 
        begin 
            if(~s) 
                begin 
                    if (data1) 
                        q <= f1; 
                    else 
                        q <= f2; 
                end 
            else 
                begin 
                    if (data2) 
                        q <= f1; 
                    else 
                        q <= f2; 
                end  
        end 

endmodule
