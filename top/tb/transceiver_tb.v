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
wire [11:0] demodulator_out;
wire [11:0] encoder_out;
wire [7:0]  decoder_out;
wire [7:0]  uart_rx_out;
wire [7:0]  signal_cnt_out;
wire [11:0] neg_sine_out;
wire [11:0] sine_out;

integer i;

transceiver_top dut (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .data   (data),
    .q      (q)
);

assign uart_rx_out = dut.uart_rx_out;
assign encoder_out = dut.encoder_out;
assign decoder_out = dut.decoder_out;
assign data_valid = dut.data_valid;
assign modulator_out = dut.modulator_out;
assign demodulator_out = dut.demodulator_out;
assign signal_cnt_out = dut.signal_cnt_out;
assign neg_sine_out = dut.neg_sine_out;
assign sine_out = dut.sine_out;
assign done = dut.done;
assign active = dut.active;

initial  begin        
    clk = 0;
    #1; rst = 0; en = 0;
    #1; rst = 1; en = 1;
    for (i = 0; i <= 25000; i = i + 1) begin
        #1; data = $urandom_range(0,1); 
    end 
end

always #1 clk = ~clk;

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, transceiver_tb);
    $monitor("time=%g, clk=%b, data=%b, active=%b, done=%b, q=%b", $time, clk, data, active, done, q);
end

initial #25000 $stop;

endmodule
