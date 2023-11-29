module tb_and1;
    reg a;
    reg b;
    wire z;
    integer i;
    integer j;

    and1 u0 (.a (a), .b (b), .y (z)); //initialize and gate module
    initial begin
        for (i = 0; i <= 1; i = i + 1) begin
            for (j = 0; j <= 1; j = j + 1) begin
                #10 a = i;
                    b = j;
                    //puts out full truth table to check
                    $monitor("a=0b%b, b=0b%b, output=0b%b", a, b, z);
            end
        end
    end
endmodule
