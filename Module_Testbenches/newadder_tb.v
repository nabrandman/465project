`timescale 1ns/1ps

module tb_newadder;

reg [31:0]a;
reg [31:0]b;
reg [4:0]ctrl;
reg clk;
reg cin;
wire [31:0]sum;
wire cout;
wire out_en;
wire [5:0]showcount;
wire [31:0]showa_r;
wire [31:0]showb_r;

always #5 clk = ~clk;

newadder uut (.a (a), .b (b), .cin (cin), .ctrl (ctrl), .clk (clk), .sum (sum), .cout (cout), .out_en (out_en));
initial begin
    #1 clk <= 0;
       a = 16;
       b = 3;
       cin = 0;

       $monitor("out_en = %b\na = 0b%b = 0d%d\nb = 0b%b = 0d%d\ncin = 0b%b\nsum = 0b%b = 0d%d\ncout = 0b%b\ntime = %t\n", out_en, a, a, b, b, cin, sum, sum, cout, $time);
    #350 cin = 0;
         a = 6;
         b = -3;
    #700 $finish;

end

endmodule

