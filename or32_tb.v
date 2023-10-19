module tb_or32;
    reg [31:0]a;
    reg [31:0]b;
    wire [31:0]y;
    integer i;
    integer j;

    or32 u0 (.a (a), .b (b), .y (y));

    initial begin
        for (i = -4; i < 5; i = i + 1) begin
            for (j = -4; j < 5; j = j + 1) begin
                #10 a = i;
                    b = j;
                $monitor("a = 0b%b, b = 0b%b, output = 0b%b", a, b, y);
            end
        end
    end
endmodule
