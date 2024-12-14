`timescale 1ps / 1ps

module crc16_tb();

localparam CLK_PERIOD = 2;
localparam SIM_TIME   = 100;

reg       clk;
reg       arstn;
reg       en;
reg [7:0] data;

wire [15:0] crc16;

crc16 dut(
    .clk    (clk  ),
    .arstn  (arstn),
    .en     (en   ),
    .data   (data ),
    .crc16  (crc16)
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
        repeat (5) begin
            en = 1;
            data = $urandom_range(0, 256);
            #(CLK_PERIOD*8);
            en = 0;
            #CLK_PERIOD;
        end
    end
endtask

initial begin
    clk = 0;
    forever begin
        #(CLK_PERIOD/2) clk = ~clk;
    end
end

initial begin
    rst();
    data_gen();
end

initial begin
    $dumpfile("crc16_tb.vcd");
    $dumpvars(0, crc16_tb);
    $monitor("time=%g, crc=0x%h", $time, crc16);
end

initial begin
    #SIM_TIME $stop;
end
    
endmodule
