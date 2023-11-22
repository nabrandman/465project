`timescale 1ns/1ps

module alu (input [31:0]a, input [31:0]b, input clk, input [4:0]ctrl, output [31:0]y, output cout);
//inputs are a & b (either imm or reg), and ctrl which is used to select which operation to perform
//ouputs are carry-out and the actual output of the operation

//these wires just take info from one piece to the next
reg [31:0]a_r;
reg [31:0]b_r;
wire [31:0]midand;  //takes output of and operation to mux
wire [31:0]midadd;  //takes output of add/sub op to mux
wire [31:0]midor;   //takes output of or op to mux
wire [31:0]midxor;
wire [31:0]rshift;
wire [31:0]lshift;
wire [31:0]lowmult;
wire [31:0]highmult;
wire [31:0]quotient;
wire [31:0]remainder;
wire [31:0]muxb;    //takes output of b input mux to all ops

reg highlow;
wire [31:0]shiftout;
wire [31:0]andshift;
wire [31:0]x_or;
wire [31:0]addxor;
wire [31:0]rvi;
wire [31:0]product;
wire [31:0]divrem;
wire [31:0]rvm;
reg [4:0]ctrl_r;


always @ (posedge clk) begin
    ctrl_r <= ctrl;
    a_r <= a;
    b_r <= b;
    highlow <= ctrl[1] | ctrl[0];
end

/*CTRL Codes:
instrbit:[30][25] [14:12]
   add =  0    0     000 = 0
   sll =  0    0     001 = 1
   xor =  0    0     100 = 4
   srl =  0    0     101 = 5
    or =  0    0     110 = 6
   and =  0    0     111 = 7
   mul =  0    1     000 = 8
  mulh =  0    1     001 = 9
mulhsu =  0    1     010 = 10
 mulhu =  0    1     011 = 11
   div =  0    1     100 = 12
  divu =  0    1     101 = 13
   rem =  0    1     110 = 14
  remu =  0    1     111 = 15
   sub =  1    0     000 = -16
   sra =  1    0     101 = -11
*/


mux b_or_not_b (.a (~b_r), .b (b_r), .ctrl (ctrl_r[4]), .out (muxb));
fulladder32 add (.a (a_r), .b (muxb), .cin (ctrl_r[4]), .s (midadd), .cout (cout));
and32 and0 (.a (a_r), .b (muxb), .y (midand));
or32 or0 (.a (a_r), .b (muxb), .y (midor));
xor32 xor0 (.a (a_r), .b (muxb), .y (midxor));
rightshiftb shiftright0 (.a (a_r), .b (muxb[4:0]), .aorl (ctrl_r[4]), .out (rshift));
leftshift leftshift0 (.a (a_r), .b (b[4:0]), .clk (clk), .ctrl (ctrl_r), .out (lshift), .out_en ());

mult mult0 (.a (a_r), .b (b_r), .clk (clk), .ctrl (ctrl_r), .lower (lowmult), .higher (highmult));
divider div0 (.a (a_r), .b (b_r), .clk (clk), .ctrl (ctrl_r), .q (quotient), .r(remainder));



mux rightleft0 (.a (rshift), .b (lshift), .ctrl (ctrl_r[2]), .out (shiftout));
mux andshift0 (.a (midand), .b (shiftout), .ctrl (ctrl_r[1]), .out (andshift));
mux x_or0 (.a (midor), .b (midxor), .ctrl (ctrl_r[1]), .out (x_or));
mux addxor0 (.a (x_or), .b (midadd), .ctrl (ctrl_r[2]), .out (addxor));
mux RV32I (.a (andshift), .b (addxor), .ctrl (ctrl_r[0]), .out (rvi));

mux highlow0 (.a (highmult), .b (lowmult), .ctrl (highlow), .out (product));
mux divrem0 (.a (remainder), .b (quotient), .ctrl (ctrl_r[1]), .out (divrem));
mux RV32M (.a (divrem), .b (product), .ctrl (ctrl_r[2]), .out (rvm));
mux final (.a (rvm), .b (rvi), .ctrl (ctrl_r[3]), .out (y));

endmodule
