module tb_cbadder32;
    reg signed[31:0]a;
    reg signed[31:0]b;
    reg cin;
    wire signed[31:0]sum;
    wire cout;
    integer i;
    integer j;
    integer k;

cbadder32 uut (.a (a), .b (b), .cin (cin), .sum (sum), .cout (cout));

initial begin
    for (i = -4; i < 5; i = i + 1) begin
        for (j = -4; j < 5; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin
                #10 a = i;
                    b = j;
                    cin = k;

                $monitor("a = %d\nb = %d\ncin = %b\nsum = %d\ncout = %b\n", a, b, cin, sum, cout);
            end
        end
    end
end
endmodule

