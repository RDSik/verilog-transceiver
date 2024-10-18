`timescale 1ps/1ps // comment this for vivado simulation with hdlmake

module transceiver_tb ();

localparam CLK_PERIOD   = 2;
localparam CLKS_PER_BIT = 8;
localparam DATA_WIDTH   = 8; 
localparam SIM_TIME     = 22000;

reg clk;
reg arstn;
reg data;
reg en;

wire q;
wire active;
wire done;
wire data_valid;
    
wire [11:0] modulator_out;
wire [11:0] demodulator_out;
wire [11:0] encoder_out;
wire [7:0 ] decoder_out;
wire [7:0 ] uart_rx_out;
wire [7:0 ] cnt_out;
wire [11:0] neg_sin_out;
wire [11:0] sin_out;

integer i;

transceiver_top #(
    .CLKS_PER_BIT (CLKS_PER_BIT)
) dut (
    .clk   (clk  ),
    .arstn (arstn),
    .en    (en   ),
    .data  (data ),
    .q     (q    )
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

task rst();
    begin
        arstn = 0;
        #CLK_PERIOD;
        arstn = 1;
        $display("\n-----------------------------------------");
        $display("Reset done");
        $display("-----------------------------------------\n");
    end
endtask

task data_gen();
    begin
        $display("\n-----------------------------------------");
        $display("Data generation cycle start in %g ps", $time);
        $display("-----------------------------------------\n");
        en = 1;
        #CLK_PERIOD;
        data = 0;
        $display("Start bit detected in %g ps", $time);
        #((CLKS_PER_BIT/2)*CLK_PERIOD);
        $display("Data transmission start in %g ps", $time);
        i = 0;
        repeat (DATA_WIDTH) begin
            #(CLKS_PER_BIT*CLK_PERIOD);
            data = $urandom_range(0,1);
            $display("%d bit detected in %g ps", i, $time);
            i = i + 1;
        end
        #CLK_PERIOD;
        data = 1;
        $display("Stop bit detected in %g ps", $time);
        #(CLKS_PER_BIT*CLK_PERIOD);
    end
endtask

initial begin
    clk = 0;
    forever begin
        #(CLK_PERIOD/2) clk = ~clk;
    end
end
    
initial begin
    en = 0;
    rst();
    repeat (10) begin
        data_gen();
        #(CLK_PERIOD*1000);
    end
end
    
initial begin
    $dumpfile("transceiver_tb.vcd");
    $dumpvars(0, transceiver_tb);
    // $monitor("time=%g, uart_out=0x%h, encoder_out=0x%h, decoder_out=0x%h, democulator_out=0x%h, done=%b, active=%b, data_valid=%b", $time, uart_rx_out, encoder_out, decoder_out, demodulator_out, done, active, data_valid);
end

initial begin
    #SIM_TIME $finish;
end
    
endmodule
