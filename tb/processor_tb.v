`timescale 1ns/1ps

module processor_tb;

    reg clk;
    reg rst;

    // DUT instantiation
    top_2 ab(
        .clk(clk),
        .reset(rst)
    );


    initial clk = 0;
    always #5 clk = ~clk;   // 50 MHz


    initial begin
        rst = 1'b1;
        #20;
        rst = 1'b0;
    end


    initial begin
        $dumpfile("processor_tb.vcd");
        $dumpvars(0, processor_tb);
    end


   

    
    initial begin
        #300;
        $display("=== SIMULATION FINISHED ===");
        
        $finish;
    end

endmodule
