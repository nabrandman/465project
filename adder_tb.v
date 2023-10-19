module tb_adder;
    reg a;
    reg b;
    reg cin;
    wire s;
    wire cout;
    integer i;
    integer j;
    integer k;

    adder u0 ( .a (a), .b (b), .cin (cin), .cout (cout), .s (s)); //initialize 1-bit adder module

    initial begin
        for (i = 0; i < 2; i = i+1) begin           //let all 3 inputs be 0 or 1
            for (j = 0; j < 2; j = j+1) begin       //basically just allowing to create a truth table
                for (k = 0; k < 2; k = k+1) begin
                     #10 a = i;
                         b = j;
                         cin = k;

                    $monitor ("a=0x%0d b=0x%0d cin=0x%0d s=0x%0d cout=0x%0d", a, b, cin, s, cout);

                end
            end
        end
    end
endmodule
