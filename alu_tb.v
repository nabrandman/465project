module tb_alu;
    reg [31:0]a;
    reg [31:0]b;
    reg [2:0]ctrl;
    wire [31:0]out;
    wire cout;

integer i;

    alu u0 (.a (a), .b (b), .ctrl (ctrl), .y (out), .cout (cout));
    
    initial begin
        for (i = 0; i < 8; i = i + 1) begin
            #10 a = 16;
                b = 3;
                ctrl = i;
                //chooses inputs a & b to be specific numbers, then tests alu output with each ctrl input
            $monitor("ctrl=(0b%b), out=(0d%d / 0b%b), cout=%b", ctrl, out, out, cout);
        end
    end
endmodule

