module tb_mux;
    reg [31:0]a;
    reg [31:0]b;
    reg ctrl;
    wire [31:0]out;
    integer i;

    mux u0 (.a (a), .b (b), .ctrl (ctrl), .out (out));

    initial begin
        for (i = 0; i < 2; i = i + 1) begin
            #10 a = 0;
                b = 1;
                ctrl = i;
                //what the 2 inputs actually are doesn't really matter here, so this just uses 2 easily distinguishable inputs and checks which comes out for the different control inputs
                $monitor("a = 0, b = 1, ctrl = 0b%b, output = 0d%b", ctrl, out);
        end
    end
endmodule
