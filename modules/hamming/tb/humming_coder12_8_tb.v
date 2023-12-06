`timescale 1ps / 1ps

module humming_coder12_8_tb();

reg        clk;
reg        rst_n;
reg [7:0]  data;
reg [11:0] hc_in;

wire [11:0] hc_out;
wire [7:0]  q;

reg [7:0] temp1; 
reg [7:0] temp2;

humming_coder12_8 DUT(
    .clk    (clk),
    .rst_n  (rst_n),
    .data   (data),
    .q      (q),
    .hc_out (hc_out),
    .hc_in  (hc_in)
);

integer pn, i;

initial begin
    pn = 0;
    hc_in = 0;
    
    forever begin
        @ (posedge clk)
        pn = {$random} %12;
        #1
        for (i = 0; i < 12; i = i + 1) begin
            if (i != pn)
                hc_in[i] = hc_out[i];
            else
                hc_in[i] = ~hc_out[i];
        end
    end
end

always @ (posedge clk) begin
    temp1 <= data;
    temp2 <= temp1;
end

always @ (*) begin
    if (wren) begin
        #1
        if (temp2 == q)
            $display("OK:time=%0t data=%0d q=%0d", $time, temp2, q);
        else
            $error("ERROR:time=%0t data=%0d q=%0d", $time, temp2, q);
    end
end
    
initial begin
    clk = 1;
    rst_n = 0;
    data = 0;
    rden = 0;
    wren = 0;
    
    #200
    @ (posedge clk)
    rst_n = 1;
    
    #200
    forever begin
        @ (posedge clk)
        wren = 1;
        data = {$random} % 9'b10000_0000;
        @ (posedge clk)
        wren = 1;
        data = {$random} % 9'b10000_0000;
        rden = 1;
    end
end

always #10 clk = ~clk;

initial #5000 $stop;

endmodule
