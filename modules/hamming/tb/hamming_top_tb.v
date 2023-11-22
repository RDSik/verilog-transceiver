`timescale 1ps / 1ps

module hamming_top_tb();

reg        clk;
reg        rst;
reg [7:0]  data;

wire [7:0]  q;
wire [11:0] encoder_out;

reg [7:0] temp1, temp2;

integer pn, i;

hamming_top dut (
    .clk        (clk),
    .rst        (rst),
    .data       (data),
    .q          (q)
);

assign encoder_out = dut.encoder_out;

initial 
    begin
        pn = 0;
        data = 0;
       
        forever begin
            @ (posedge clk)
            pn = {$random} %12;
            #1
            for (i=0; i<8; i=i+1) begin
                if (i!= pn)
                    data[i] = data[i];
                else
                    data[i] = data[i];
            end
        end
    end
   
    always @ (posedge clk)
        begin
            temp1 <= data;
            temp2 <= temp1;
        end

    always @ (*)
    begin
        #1
            if (temp1 == q)
                $display("OK:time=%0t data=%0d q=%0d", $time, temp2, q);
            else
                $error("ERROR:time=%0t data=%0d q=%0d", $time, temp2, q);
    end
       
    initial begin
        clk = 1;
        rst = 0;
        data = 0;
        
        #200
        @ (posedge clk)
        rst = 1;
        
        #200
        forever begin
            @ (posedge clk)
            data = {$random} % 8'b1000_0000;
            @ (posedge clk)
            data = {$random} % 8'b1000_0000;
        end
    end

    always #10 clk = ~clk;

    initial #5000 $stop;

endmodule
