module rightshift1_tb;
reg [31:0]a;
wire [31:0]out1;
wire [31:0]out2;
wire [31:0]out4;
wire [31:0]out8;
wire [31:0]out16;
integer i;

rightshiftn u1 ( .a (a), .out (out1));

rightshiftn #(2) u2 ( .a (a), .out (out2));

rightshiftn #(4) u4 ( .a (a), .out (out4));

rightshiftn #(8) u8 ( .a (a), .out (out8));

rightshiftn #(16) u16 ( .a (a), .out (out16));

    initial begin
        for (i = -3; i < 4; i = i + 1) begin
            #10 a = i;
            $monitor("in = 0b%b, out1 = 0b%b, out2 = 0b%b, out4 = 0b%b, out8 = 0b%b, out16 = 0b%b", a, out1, out2, out4, out8, out16);
        end
    end
endmodule
