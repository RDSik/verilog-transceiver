`timescale 1ps / 1ps

module bpsk_demodulator_tb();

reg         clk;
reg         rst;
reg         en;
reg [11:0]  signal_in;

wire [11:0] q;
wire [7:0]  signal_cnt;
wire [3:0]  sel_cnt;
wire [11:0] sel;
wire        flag;

integer i;

bpsk_demodulator #(
    .SAMPLE_NUMBER (256),
    .SAMPLE_WIDTH  (12),
    .DATA_WIDTH    (12)
) dut (
    .clk       (clk),
    .rst       (rst),
    .en        (en),
    .signal_in (signal_in),
    .q         (q)
);

assign sel_cnt = dut.sel_cnt;
assign signal_cnt = dut.signal_cnt;
assign flag = dut.flag;
assign sel = dut.sel;

initial 
    begin        
        clk = 0;
        #1; rst = 0; en = 0;
        #1; rst = 1; en = 1;
        for (i = 0; i <= 80000; i = i + 1)
            begin
                #515; signal_in = $urandom_range(0,4095); 
            end
        // #1000; en = 0;
        // #1000; en = 1;
    end

always #1 clk = ~clk;

initial 
    $monitor("time=%g, clk=%b, signal_in=%b, q=%b", $time, clk, signal_in, q);
	
initial 
    begin
        $dumpfile("out.vcd");
	    $dumpvars(0, bpsk_demodulator_tb);
	    #80000 $stop;
    end

endmodule
