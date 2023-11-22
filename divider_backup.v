module divider (
    input clk,
    input in_en,
    input [31:0] a,
    input [31:0] b,
    output reg out_en,
    output error,
    output [31:0] q,
    output [31:0] r
); 
// a/b = q with remainder r

reg [31:0] dividend;
reg [31:0] divisor;
reg [31:0] intermediate;
reg [31:0] count;
reg [31:0] quotient;
reg [31:0] remainder;

reg neg_out;
reg is_active;

assign q = quotient;
assign r = remainder;

always @(posedge clk) begin
    if(in_en == 1) begin
        if(a[31] == 1) dividend <= ~a + 1;
        else dividend <= a;
        if(b[31] == 1) divisor <= b;
        else divisor <= ~b + 1;

        neg_out <= a[31] ^ b[31];
        count <= 0;
        is_active <= 1;
    end
end

fulladder32 div_adder(.a(dividend), .b(divisor), .cin(), .s(intermediate), .cout());

always @(posedge clk) begin
    if(is_active) begin
        if(intermediate[31] == 1) begin
            is_active <= 0;
            out_en <= 1;
            quotient <= count;
            remainder <= dividend;
        end
        else begin
            dividend <= intermediate;
            count <= count + 1;
            out_en <= 0; 
        end
    end
end
endmodule
