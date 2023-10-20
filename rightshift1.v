module rightshift1 (input [31:0]a, output [31:0]out);

parameter n = 1;
genvar i;

    for (i = 0; i + n < 32; i = i + 1) begin
        assign out[i] = a[i+n];
        assign out[31:32-n] = a[31:32-n];
    end
endmodule
