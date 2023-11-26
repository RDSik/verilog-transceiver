`timescale 1ps / 1ps

module transceiver_tb();

reg         clk;
reg         rst;
reg         data;
reg         en;

wire        active;
wire        done;
wire        q;
wire        data_valid;
wire [11:0] modulator_out;
wire [11:0] encoder_out;
wire [7:0]  decoder_out;
wire [7:0]  uart_rx_out;

integer i;

transceiver_top dut (
    .clk           (clk),
    .rst           (rst),
    .en            (en),
    .data          (data),
    .done          (done),
    .active        (active),
    .q             (q),
    .modulator_out (modulator_out)
);

assign uart_rx_out = dut.uart_rx_out;
assign encoder_out = dut.encoder_out;
assign decoder_out = dut.decoder_out;
assign data_valid = dut.data_valid;

initial 
    begin        
        clk = 0;
        #1; rst = 0; en = 0;
        #1; rst = 1; en = 1;
        for (i = 0; i <= 500000; i = i + 1)
            begin
                #1; data = $urandom_range(0,1); 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, data=%b, active=%b, done=%b, modulator_out=%b, q=%b", $time, clk, data, active, done, modulator_out, q);
	
initial 
	#500000 $stop;

endmodule
