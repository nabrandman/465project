module tb_xor1;
    reg a;
    reg b;
    wire y;
    integer i;
    integer j;

    xor1 u0 (.a (a), .b (b), .y (y));
    initial begin
        for (i = 0; i <= 1; i = i + 1) begin
            for (j = 0; j <= 1; j = j + 1) begin
                #10 a = i;
                    b = j;
                    $monitor("a=0b%b, b=0b%b, output=0b%b", a, b, y);
            end
        end
    end
endmodule
