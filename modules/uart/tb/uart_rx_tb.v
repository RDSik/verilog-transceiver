`timescale 1ps / 1ps

module uart_rx_tb();

reg        clk;
reg        arst;
reg        data;

wire [7:0] clk_cnt;
wire [2:0] bit_cnt;
wire       rx_done;
wire       done;
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
    .arst (arst),
    .done (done),
    .data (data),
    .q    (q)
);

assign state = dut.state;
assign rx_byte = dut.rx_byte;
assign rx_done = dut.rx_done;
assign clk_cnt = dut.clk_cnt;
assign bit_cnt = dut.bit_cnt;

initial 
    begin        
        clk = 0; 
        #1; arst = 1;
        #1; arst = 0;
        for (i = 0; i <= 255; i = i + 1)
            begin
                #1; data = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, done=%b, q=%b", $time, clk, data, done, q);
	
initial 
	#300 $stop;

endmodule
