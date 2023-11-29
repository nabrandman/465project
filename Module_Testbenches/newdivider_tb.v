`timescale 1ns/1ps

module tb_divider;

reg clk;
reg in_en;
reg [31:0]a;
reg [31:0]b;
wire out_en;
wire error;
wire [31:0]q;
wire [31:0]r;
wire [31:0]divid;
wire [31:0]divis;
wire [31:0]count;
wire act;
wire add_en;
wire [31:0]inter;

always #5 clk = ~clk;

divider u0 (.clk (clk), .in_en (in_en), .a (a), .b (b), .out_en (out_en), .error (error), .q (q), .r (r), .showdividend (divid), .showdivisor (divis), .showcount (count), .showactive (act), .showadd_en (add_en), .showinter (inter));



initial begin
    #1 clk <= 1;
        a = -6;
        b = 3;
        in_en = 1;
        $monitor("a = %b, b = %b, in_en = %b, out_en = %b, error = %b, q = %b, r = %b\ntime = %t\ndivid = %b\ndivis = %b\ncount=%b\nis_active = %b\nadd_en = %b\nintermediate = %b\n", a, b, in_en, out_en, error, q, r, $time, divid, divis, count, act, add_en, inter);
    #10000 $finish;
end
endmodule
