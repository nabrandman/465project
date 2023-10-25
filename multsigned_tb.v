`timescale 1ns/1ps

module tb_mult;
reg signed[31:0]a;
reg signed [31:0]b;
reg clk;
wire [31:0]outlow;
wire [31:0]outhigh;
wire signed [63:0]total;
integer j;
integer i;

assign total[31:0] = outlow;
assign total[63:32] = outhigh;

always #5 clk = ~clk;

mult u0 (.a (a), .b (b), .clk (clk), .lower (outlow), .higher (outhigh));
initial begin
    #1 clk <= 0;
       a = -2;
       b = 3;
//$monitor("a = %b, b = %b \nc = %0b, count = 0b%b = %d, clk = %b\nacc = 0b%b, mult = 0b%b", a, b, temp1, ctest, ctest, clk, acctest, multest, "\nout = 0b%b %b = %d", outhigh, outlow, total);
//$monitor("clk = %b, count = %d \nacc = 0b%b \nmult = 0b%b \ntotal = 0b%b = %d", clk, ctest, acctest, multest, total, total);
        $monitor("a = 0b%b = 0d%d\nb = 0b%b = 0d%d\nout = 0b%b %b\nout = %d", a, a, b, b, outhigh, outlow, total);
    #325 $finish;
end
endmodule
