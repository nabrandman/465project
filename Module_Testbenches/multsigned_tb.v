`timescale 1ns/1ps

module tb_mult;
reg signed[31:0]a;
reg signed [31:0]b;
reg clk;
reg [4:0]ctrl;
wire [31:0]outlow;
wire [31:0]outhigh;
wire signed [63:0]total;
wire [4:0]ctest;
wire [31:0]acctest;
wire [31:0]multest;
wire in;
wire out;
integer j;
integer i;

assign total[31:0] = outlow;
assign total[63:32] = outhigh;

always #5 clk = ~clk;

mult u0 (.a (a), .b (b), .clk (clk), .ctrl (ctrl), .lower (outlow), .higher (outhigh), .ctest(ctest), .acctest(acctest), .multest(multest), .in(in), .out(out));
initial begin
    #1 clk <= 0;
       a = 16;
       b = 3;
       ctrl = 0;
$monitor("a = %b, b = %b \ncount = 0b%b = %d, clk = %b\nacc = 0b%b, mult = 0b%b\nin_en = %b, out_en = %b\nout = 0b%b %b = %d", a, b, ctest, ctest, clk, acctest, multest, in, out, outhigh, outlow, total);
//$monitor("clk = %b, count = %d \nacc = 0b%b \nmult = 0b%b \ntotal = 0b%b = %d", clk, ctest, acctest, multest, total, total);
        //$monitor("a = 0b%b = 0d%d\nb = 0b%b = 0d%d\nout = 0b%b %b\nout = %d", a, a, b, b, outhigh, outlow, total);
    #360 $finish;
end
endmodule
