`timescale 1ps / 1ps

module bpsk_modulator_tb();

reg        clk;
reg        rst;
reg        en;
reg [11:0] data;
reg [11:0] sine_in;
reg [11:0] neg_sine_in;

wire [11:0] signal_out;
wire [7:0]  cnt_in;
wire [3:0]  sel_cnt;
wire [11:0] sel;

reg [7:0] cnt;
reg [11:0] sine_rom [255:0];
reg [11:0] neg_sine_rom [255:0];

integer i;

initial 
    begin
        $readmemb("sine_value.dat", sine_rom);
        $readmemb("neg_sine_value.dat", neg_sine_rom);
    end

bpsk_modulator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk         (clk),
    .rst         (rst),
    .en          (en),
    .data        (data),
    .sine_in     (sine_in),
    .neg_sine_in (neg_sine_in),
    .cnt_in      (cnt_in), 
    .signal_out  (signal_out)
);

assign sel_cnt = dut.sel_cnt;
assign sel = dut.sel;
assign cnt_in = cnt;

initial 
    begin        
        clk = 1; data = $urandom_range(0,4095);
        #1; rst = 0; en = 0;
        #1; rst = 1; en = 1;
        for (i = 0; i <= 2500; i = i + 1)
            begin
                #2; cnt = i; sine_in = sine_rom[cnt_in]; neg_sine_in = neg_sine_rom[cnt_in]; 
            end 
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, signal_out=%b", $time, clk, signal_out);
	
initial 
    begin
        $dumpfile("out.vcd");
	    $dumpvars(0, bpsk_modulator_tb);
	    #5000 $stop;
    end

endmodule
