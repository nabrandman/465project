`timescale 1ns/1ps

module tb_alu;
    reg [31:0]a;
    reg [31:0]b;
    reg clk;
    reg [4:0]ctrl;
    wire [31:0]out;
    wire cout;

integer i;

    always #5 clk = ~clk;
    always #3000 ctrl = ctrl + 1;

    alu u0 (.a (a), .b (b), .clk (clk), .ctrl (ctrl), .y (out), .cout (cout));
    
    initial begin
        //for (i = 0; i < 32; i = i + 1) begin
            #1 clk <= 0;
                a = 16;
                b = 3;
                ctrl = 0;
        //end
                //chooses inputs a & b to be specific numbers, then tests alu output with each ctrl input
              $monitor("ctrl=(0b%b), out=(0d%d / 0b%b), cout=%b", ctrl, out, out, cout);
            #100000 $finish;
        //end
    end
endmodule

