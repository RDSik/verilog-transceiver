// `include "timescale.v" // comment this for vivado simulation with hdlmake

module transceiver_tb();

localparam clk_per = 2;

reg         clk;
reg         rst_n;
reg         data;
reg         en;

wire        q;
wire        active;
wire        done;
wire        data_valid;
wire [11:0] modulator_out;
wire [11:0] demodulator_out;
wire [11:0] encoder_out;
wire [7:0]  decoder_out;
wire [7:0]  uart_rx_out;
wire [7:0]  cnt_out;
wire [11:0] neg_sin_out;
wire [11:0] sin_out;

integer i;

transceiver_top dut (
    .clk   (clk),
    .rst_n (rst_n),
    .en    (en),
    .data  (data),
    .q     (q)
);

assign uart_rx_out     = dut.uart_rx_out;
assign encoder_out     = dut.encoder_out;
assign decoder_out     = dut.decoder_out;
assign data_valid      = dut.data_valid;
assign done            = dut.done;
assign active          = dut.active;
assign modulator_out   = dut.modulator_out;
assign demodulator_out = dut.demodulator_out;
assign cnt_out         = dut.cnt_out;
assign neg_sin_out     = dut.neg_sin_out;
assign sin_out         = dut.sin_out;

initial  begin        
    clk = 0;
    #clk_per; rst_n = 0; en = 0;
    #clk_per; rst_n = 1; en = 1;
    for (i = 0; i <= 25000; i = i + 1) begin
        #(clk_per/2); data = $urandom_range(0,1); 
    end 
end

always #(clk_per/2) clk = ~clk;

initial begin
    $dumpfile("transceiver_tb.vcd");
    $dumpvars(0, transceiver_tb);
    $monitor("time=%g, clk=%b, data=%b, active=%b, done=%b, q=%b", $time, clk, data, active, done, q);
end

initial #25000 $stop;

endmodule
