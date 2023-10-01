`timescale 1ns / 1ns

module neg_sin_gen #(
    parameter DATA_WIDTH = 12,
              ADDR_WIDTH = 8
) (
    input  wire                 clk,
    input  wire                 arst, // asynchronous reset
    output reg [DATA_WIDTH-1:0] neg_sin_out
);

reg [DATA_WIDTH-1:0] rom [2**ADDR_WIDTH-1:0];
reg [ADDR_WIDTH-1:0] cnt;

initial 
    begin
        $readmemb("neg_sine_value.dat", rom);
    end

always @(posedge clk or posedge arst)
    begin
        if (arst)
            begin 
                cnt <= 0; 
            end 
        else if (cnt == 8'b1111_1111)
            begin
                cnt <= 0;
            end
        else 
            begin 
                cnt <= cnt + 1;
            end
        neg_sin_out <= rom[cnt];
    end

endmodule 
