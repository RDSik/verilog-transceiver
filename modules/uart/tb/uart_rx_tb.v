`timescale 1ps / 1ps

module uart_rx_tb();

reg        clk;
reg        data;

wire [3:0] clk_cnt;
wire [2:0] bit_cnt;
wire       rx_dv;
wire       rx_data_r;
wire       rx_data;
wire       dv;
wire [2:0] state;
wire [7:0] q;
wire [7:0] rx_byte;

integer i;

uart_rx #(
    .CLOCK_RATE (1_000_000),
    .BAUD_RATE  (115_200),
    .DATA_WIDTH (8)
) dut (
    .clk  (clk),
    .dv   (dv),
    .data (data),
    .q    (q)
);

assign state = dut.state;
assign rx_byte = dut.rx_byte;
assign rx_dv = dut.rx_dv;
assign rx_data_r = dut.rx_data_r;
assign rx_data = dut.rx_data;
assign clk_cnt = dut.clk_cnt;
assign bit_cnt = dut.bit_cnt;

initial 
    begin        
        clk = 0; 
        for (i = 0; i <= 1024; i = i + 1)
            begin
                #1; data = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, dv=%b, q=%b", $time, clk, data, dv, q);
	
initial 
	#1000 $stop;

endmodule
