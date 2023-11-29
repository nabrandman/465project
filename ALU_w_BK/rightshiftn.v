module rightshiftn (input [31:0]a, input aorl, output [31:0]out);

parameter n = 1;
genvar i;
genvar j;

    for (i = 0; i + n < 32; i = i + 1) begin
        assign out[i] = a[i+n];
        for (j = 0; j < n; j = j + 1) begin
            and(out[31-j], a[31], aorl);
        end
    end
endmodule
