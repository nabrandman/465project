module rightshiftn_tb;
reg [31:0]a;
reg aorl;
wire [31:0]out1;
wire [31:0]out2;
wire [31:0]out4;
wire [31:0]out8;
wire [31:0]out16;
integer i;
integer j;

rightshiftn u1 ( .a (a), .aorl (aorl), .out (out1));

rightshiftn #(2) u2 ( .a (a), .aorl (aorl), .out (out2));

rightshiftn #(4) u4 ( .a (a), .aorl (aorl), .out (out4));

rightshiftn #(8) u8 ( .a (a), .aorl (aorl), .out (out8));

rightshiftn #(16) u16 ( .a (a), .aorl (aorl), .out (out16));

    initial begin
        for (i = -174765; i < 174766; i = i + 69906) begin
            for (j = 0; j < 2; j = j + 1) begin
                #10 a = i;
                    aorl = j;
                //$monitor("in = 0b%b, out1 = 0b%b, out2 = 0b%b, out4 = 0b%b, out8 = 0b%b, out16 = 0b%b", a[16:0], out1[16:0], out2, out4, out8, out16);
                $monitor("in    = 0b%b  %b, aorl = %b\nout1  = 0b%b  %b \nout2  = 0b%b  %b \nout4  = 0b%b  %b \nout8  = 0b%b  %b \nout16 = 0b%b  %b", a[31:17], a[16:0], aorl, out1[31:17], out1[16:0], out2[31:17], out2[16:0], out4[31:17], out4[16:0], out8[31:17], out8[16:0], out16[31:17], out16[16:0]);
            end
        end
    end
endmodule
