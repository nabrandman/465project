module rightshiftb_tb;
reg [31:0]a;
reg [4:0]b;
reg aorl;
wire [31:0]out;
integer i;
integer j;
integer k;

rightshiftb u0 ( .a (a), .b (b), .aorl (aorl), .out (out));

    initial begin
        //for (i = -174765; i < 174766; i = i + 349530) begin
            //for (j = 0; j < 32; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    #10 a = 16;
                        b = 3;
                        aorl = k;
                    $monitor("in = 0b%b, aorl = %b, sh = 0d%d, out = 0b%b", a, aorl, b,  out);
                //end
            //end
        end
    end
endmodule
