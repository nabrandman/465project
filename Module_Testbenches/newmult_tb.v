`timescale 1ns/1ps

//just added all the "show" outputs as wires, now need to add them to mult u0 & monitor, then run to find what's going wrong

module tb_mult;
reg signed[31:0]a;
reg signed [31:0]b;
reg clk;
reg [4:0]ctrl;
wire [31:0]outlow;
wire [31:0]outhigh;
wire signed [63:0]total;
wire showin;
wire showout;
wire showadd;
wire [31:0]showmult;
wire [31:0]showacc;
wire [4:0]count;
wire [31:0]mshift;
wire [31:0]ashift;
wire [31:0]showtemp;
wire [31:0]showpart;
integer j;
integer i;

assign total[31:0] = outlow;
assign total[63:32] = outhigh;

always #5 clk = ~clk;

mult u0 (.a (a), .b (b), .clk (clk), .ctrl (ctrl), .lower (outlow), .higher (outhigh), .showin (showin), .showout (showout), .showadd (showadd), .showmult (showmult), .showacc (showacc), .showcount (count), .mshift (mshift), .ashift (ashift), .showtemp (showtemp), .showpart (showpart));
initial begin
    #1 clk <= 0;
       a = 16;
       b = 3;
       ctrl = 8;
//$monitor("a = %b, b = %b \nc = %0b, count = 0b%b = %d, clk = %b\nacc = 0b%b, mult = 0b%b", a, b, temp1, ctest, ctest, clk, acctest, multest, "\nout = 0b%b %b = %d", outhigh, outlow, total);
//$monitor("clk = %b, count = %d \nacc = 0b%b \nmult = 0b%b \ntotal = 0b%b = %d", clk, ctest, acctest, multest, total, total);
        $monitor("time = %t\na = 0b%b = 0d%d\nb = 0b%b = 0d%d\nout = 0b%b %b\nout = %d\nin_en = %b, out_en = %b, add_en = %b\nmultiplier = %b\nacc = %b\ncount = %b = %d\nmult_shift = %b\nacc_shift = %b\nacc_temp = %b\npartial_product = %b\n", $time, a, a, b, b, outhigh, outlow, total, showin, showout, showadd, showmult, showacc, count, count, mshift, ashift, showtemp, showpart);
    #5000 $finish;
end
endmodule
