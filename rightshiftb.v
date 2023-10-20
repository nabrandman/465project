module rightshiftb (input [31:0]a, input [4:0]b, input aorl, output [31:0]out);
//b is only 5 bits b/c documentation states that in RV32I all shift operations only shift by value held in lower 5 bits of reg or imm

wire [31:0]out1;
wire [31:0]out2;
wire [31:0]out4;
wire [31:0]out8;
wire [31:0]out16;
wire [31:0]out1m;
wire [31:0]out2m;
wire [31:0]out4m;
wire [31:0]out8m;


rightshiftn u1 ( .a (a), .aorl (aorl), .out (out1));
mux m1 (.b (a), .a (out1), .ctrl (b[0]), .out(out1m));

rightshiftn #(2) u2 ( .a (out1m), .aorl (aorl), .out (out2));
mux m2 (.b (out1m), .a (out2), .ctrl (b[1]), .out(out2m));

rightshiftn #(4) u4 ( .a (out2m), .aorl (aorl), .out (out4));
mux m4 (.b (out2m), .a (out4), .ctrl (b[2]), .out(out4m));

rightshiftn #(8) u8 ( .a (out4m), .aorl (aorl), .out (out8));
mux m8 (.b (out4m), .a (out8), .ctrl (b[3]), .out(out8m));

rightshiftn #(16) u16 ( .a (out8m), .aorl (aorl), .out (out16));
mux m16 (.b (out8m), .a (out16), .ctrl (b[4]), .out(out));


endmodule
