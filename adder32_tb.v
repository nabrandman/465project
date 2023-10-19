module tb_fulladder32;
    reg [31:0]a;
    reg [31:0]b;
    reg cin;
    wire [31:0]s;
    wire cout;
    integer i;
    integer j;
    integer k;

    fulladder32 u0 ( .a (a), .b (b), .cin (cin), .cout (cout), .s (s)); //initialize 32-bit adder module

    initial begin
        for (i = -5; i < 6; i = i+1) begin
            for (j = -5; j < 6; j = j+1) begin
                for (k = 0; k < 2; k = k+1) begin
                     #10 a = i;
                         b = j;
                         cin = k;
                    //loops over cin = 0 or 1 (all possibilites) while inputs range from -5 to 5 to ensure proper behaviour for + & - numbers
                    $monitor ("a=0x%0d b=0x%0d cin=0x%0d s=0x%0d cout=0x%0d", a, b, cin, s, cout);

                end
            end
        end
    end
endmodule
