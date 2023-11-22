module cbadder32 (input [31:0]a, input [31:0]b, input cin, output [31:0]sum, output cout);

wire [6:0]carryblock;

genvar i;

cbadder block1 (.a (a[3:0]), .b (b[3:0]), .cin (cin), .sum (sum[3:0]), .cout (carryblock[0]));

generate
    for (i = 1; i < 7; i = i + 1) begin
        cbadder blockn (.a (a[i*4 + 3:i*4]), .b (b[i*4 + 3:i*4]), .cin (carryblock[i-1]), .sum (sum[i*4 + 3:i*4]), .cout (carryblock[i]));
    end
endgenerate

cbadder block8 (.a (a[31:28]), .b (b[31:28]), .cin (carryblock[6]), .sum (sum[31:28]), .cout (cout));

endmodule
