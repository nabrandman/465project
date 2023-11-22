`timescale 1ns/1ps

module tb_divider;

reg clk;
reg [31:0]a;
reg [31:0]b;
wire [31:0]q;
wire [31:0]r;
reg [4:0]ctrl;

always #5 clk = ~clk;

divider u0 (.clk (clk), .a (a), .b (b), .ctrl (ctrl), .q (q), .r (r));



initial begin
    #0 clk <= 0;
        a = 11;
        b = 2;
        ctrl = 0;
        $monitor("a = 0b%b = 0d%d\nb = 0b%b = 0d%d\nq = 0b%b = 0d%d\nr = 0b%b = 0d%d\ntime = %t", a, a, b, b, q, q, r, r, $time);
    #30000 $finish;
end
endmodule
