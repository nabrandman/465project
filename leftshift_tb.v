module tb_leftshift;

reg clk;
reg [31:0]a;
reg [4:0]b;
reg [4:0]ctrl;
wire out_en;
wire [31:0]out;
/*wire [31:0]a_r;
wire [4:0]b_r;
wire [31:0]mask;
wire [31:0]mask_r;
wire enable;*/

always #5 clk = ~clk;

leftshift u0 (.clk (clk), .a (a), .b (b), .ctrl (ctrl), .out_en (out_en), .out (out)/*, .showenable (enable), .showmask (mask), .showmask_r (mask_r), .showa_r (a_r), .showb_r (b_r)*/);

initial begin
    #1 clk <= 0;
        a = 59;
        b = 3;
        ctrl = 0;
        $monitor("a = 0b%b, b = %d, clk = %b, out_en = %b, out = %b\n", a, b, clk, out_en, out);
        #100 $finish;
end
endmodule
