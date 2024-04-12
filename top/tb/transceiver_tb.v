`include "timescale.vh" // comment this for vivado simulation with hdlmake

module transceiver_tb();

localparam clk_per  = 2;
localparam sim_time = 25000;

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

task rst_en(input zero, one);
    begin
        #clk_per;
        rst_n = zero;
        en    = zero;
        #clk_per;
        rst_n = one;
        en    = one;
        $display("\n-----------------------------");
        $display("Reset done and enable high");
        $display("-----------------------------\n");
    end
endtask

task data_gen();
    begin
        repeat (sim_time) begin
            #(clk_per/2); 
            data = $urandom_range(0,1);
        end
    end
endtask

always #(clk_per/2) clk = ~clk;
    
initial begin
    clk = 0;
    rst_en(0, 1);
    data_gen();
end

initial begin
    $dumpfile("transceiver_tb.vcd");
    $dumpvars(0, transceiver_tb);
    $monitor("time=%g, uart_out=0x%h, encoder_out=0x%h, decoder_out=0x%h, democulator_out=0x%h, done=%b, active=%b, data_valid=%b", $time, uart_rx_out, encoder_out, decoder_out, demodulator_out, done, active, data_valid);
end

initial #sim_time $stop;

endmodule
