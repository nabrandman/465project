module cbadder (input [3:0]a, input [3:0]b, input cin, output [3:0]sum, output cout);

wire [3:0]p;
wire [3:0]carry;
wire ctrl;

genvar i;

for (i = 0; i < 4; i = i + 1) begin
    xor(p[i], a[i],b[i]);
end

adder add0 (.a (a[0]), .b (b[0]), .cin (cin), .s (sum[0]), .cout (carry[0]));
adder add1 (.a (a[1]), .b (b[1]), .cin (carry[0]), .s (sum[1]), .cout (carry[1]));
adder add2 (.a (a[2]), .b (b[2]), .cin (carry[1]), .s (sum[2]), .cout (carry[2]));
adder add3 (.a (a[3]), .b (b[3]), .cin (carry[2]), .s (sum[3]), .cout (carry[3]));

and(ctrl, p[0],p[1],p[2],p[3]);

assign cout = ctrl ? cin : carry[3];

endmodule
