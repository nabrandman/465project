module xor32 (input [31:0]a, input [31:0]b, output [31:0]y);

genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            xor1 u0 (.a (a[i]), .b (b[i]), .y (y[i]));
        end
    endgenerate
endmodule

