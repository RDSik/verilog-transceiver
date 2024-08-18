`timescale 1ps / 1ps

module crc12_tb();

localparam CLK_PERIOD = 2;
localparam SIM_TIME   = 100;

reg       clk;
reg       arstn;
reg       en;
reg [7:0] data;

wire [11:0] crc12;

crc12 dut(
    .clk    (clk  ),
    .arstn  (arstn),
    .en     (en   ),
    .data   (data ),
    .crc12  (crc12)
);

task rst();
    begin
        #CLK_PERIOD;
        arstn = 0;
        #CLK_PERIOD;
        arstn = 1;
        $display("\n-----------------------------");
        $display("Reset done");
        $display("-----------------------------\n");
    end
endtask

task data_gen();
    begin
        rst();
        repeat (5) begin
            en = 1;
            data = $urandom_range(0, 256);
            #(CLK_PERIOD*8);
            en = 0;
            #CLK_PERIOD;
        end
    end
endtask

always #(CLK_PERIOD/2) clk = ~clk;

initial begin
    clk = 0;
    data_gen();
end

initial begin
    $dumpfile("crc12_tb.vcd");
    $dumpvars(0, crc12_tb);
    $monitor("time=%g, crc=0x%h", $time, crc12);
end

initial #SIM_TIME $stop;

endmodule
