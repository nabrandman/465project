module rightshiftb (input [31:0]a, input [4:0]b, input aorl, output [31:0]out);
//only b[4:0] are actually used, documentation states that only lowest 5 bits of reg or imm value are used

wire [31:0]out1;
wire [31:0]out2;
wire [31:0]out4;
wire [31:0]out8;
wire [31:0]out16;
wire [31:0]out1m;
wire [31:0]out2m;
wire [31:0]out4m;
wire [31:0]out8m;
wire [31:0]shift;
genvar i;

for (i = 0; i < 6; i = i + 1) begin
    assign shift[i] = b[i] ^ aorl;
end

rightshiftn u1 ( .a (a), .aorl (aorl), .out (out1));
mux m1 (.b (a), .a (out1), .ctrl (shift[0]), .out(out1m));

rightshiftn #(2) u2 ( .a (out1m), .aorl (aorl), .out (out2));
mux m2 (.b (out1m), .a (out2), .ctrl (shift[1]), .out(out2m));

rightshiftn #(4) u4 ( .a (out2m), .aorl (aorl), .out (out4));
mux m4 (.b (out2m), .a (out4), .ctrl (shift[2]), .out(out4m));

rightshiftn #(8) u8 ( .a (out4m), .aorl (aorl), .out (out8));
mux m8 (.b (out4m), .a (out8), .ctrl (shift[3]), .out(out8m));

rightshiftn #(16) u16 ( .a (out8m), .aorl (aorl), .out (out16));
mux m16 (.b (out8m), .a (out16), .ctrl (shift[4]), .out(out));


endmodule
