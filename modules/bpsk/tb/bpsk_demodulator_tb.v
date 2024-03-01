`timescale 1ps / 1ps

module bpsk_demodulator_tb();

reg        clk;
reg        rst_n;
reg        en;
reg [11:0] signal_in;
reg [11:0] sine_in;
reg [11:0] neg_sine_in;
reg [7:0]  cnt_in;

wire [11:0] q;
wire [3:0]  sel_cnt;
wire [11:0] sel;
wire        flag;

reg [11:0] sine_rom [255:0];
reg [11:0] neg_sine_rom [255:0];

integer i;

initial begin
    $readmemb("sine_value.dat", sine_rom);
    $readmemb("neg_sine_value.dat", neg_sine_rom);
end

bpsk_demodulator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .en        (en),
    .signal_in (signal_in),
    .q         (q)
);

assign sel_cnt = dut.sel_cnt;
assign flag = dut.flag;
assign sel = dut.sel;

initial begin
    clk = 1;
    #1; rst_n = 0; en = 0;
    #1; rst_n = 1; en = 1; signal_in = 12'b011111001110;
    for (i = 0; i <= 5000; i = i + 1) begin
        #2; cnt_in = i; 
        sine_in = sine_rom[cnt_in]; 
        neg_sine_in = neg_sine_rom[cnt_in]; 
    end
end

always #1 clk = ~clk;
	
initial  begin
    $dumpfile("out.vcd");
    $dumpvars(0, bpsk_demodulator_tb);    
    $monitor("time=%g, clk=%b, signal_in=%b, q=%b", $time, clk, signal_in, q);
end

initial #10000 $stop;

endmodule
