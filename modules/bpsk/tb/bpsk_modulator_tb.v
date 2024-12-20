`timescale 1ps / 1ps

module bpsk_modulator_tb();

reg        clk;
reg        arstn;
reg        en;
reg [11:0] data;
reg [11:0] sin_in;
reg [11:0] neg_sin_in;
reg [7:0]  cnt_in;

wire [11:0] signal_out;
wire [3:0]  sel_cnt;
wire [11:0] sel;

reg [0:11] sin_rom [0:255];
reg [0:11] neg_sin_rom [0:255];

integer i;

initial 
    begin
        $readmemb("sin_value.dat", sin_rom);
        $readmemb("neg_sine_valu.dat", neg_sin_rom);
    end

bpsk_modulator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk        (clk),
    .arstn      (arstn),
    .en         (en),
    .data       (data),
    .sin_in     (sin_in),
    .neg_sin_in (neg_sin_in),
    .cnt_in     (cnt_in), 
    .signal_out (signal_out)
);

assign sel_cnt = dut.sel_cnt;
assign sel = dut.sel;

initial begin        
    clk = 1; data = $urandom_range(0,4095);
    #1; arstn = 0; en = 0;
    #1; arstn = 1; en = 1;
    for (i = 0; i <= 2500; i = i + 1) begin
        #2; cnt_in = i; 
        sin_in = sin_rom[cnt_in]; 
        neg_sin_in = neg_sin_rom[cnt_in]; 
    end 
end

always #1 clk = ~clk;
	
initial  begin
    $dumpfile("out.vcd");
    $dumpvars(0, bpsk_modulator_tb);
    $monitor("time=%g, clk=%b, signal_out=%b", $time, clk, signal_out);
end

initial #5000 $stop;

endmodule
