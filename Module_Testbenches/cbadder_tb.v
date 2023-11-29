module tb_cbadder;
    reg [3:0]a;
    reg [3:0]b;
    reg cin;
    wire [3:0]sum;
    wire [3:0]sumog;
    wire cout;
    wire coutog;
    wire [3:0]sumpm;
    wire coutpm;
    integer i;
    integer j;
    integer k;

cbadder uut (.a (a), .b (b), .cin (cin), .sum (sum), .sumog (sumog), .cout (cout), .coutog (coutog), .sumpm (sumpm), .coutpm (coutpm));

initial begin
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin
                #10 a = i;
                    b = j;
                    cin = k;

                //$monitor("a = 0b%b = 0d%d, b = 0b%b = 0d%d\ncin = %b\nog sum = 0b%b = 0d%d\ncb sum = 0b%b = 0d%d\nog cout = %b, cb cout = %b\n", a, a, b, b, cin, sumog, sumog, sum, sum, coutog, cout);
                $monitor("a = %d, b = %d, cin = %b\nproduct machine: sum = %b, cout = %b\n", a, b, cin, sumpm, coutpm);
                //$monitor("coutog = %b\ncoutcb = %b\n",coutog, cout);
            end
        end
    end
end
endmodule

