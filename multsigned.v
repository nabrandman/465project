module mult (input [31:0]a, input [31:0]b, input clk, output [31:0]lower, output [31:0]higher);

wire [31:0]partial_product;
wire [31:0]acc_temp;
wire cin;
reg [31:0]acc;
reg [31:0]multiplier;
reg c;
wire cout;
reg [5:0]count = 0;
reg [31:0]outlow;
reg [31:0]outhigh;
reg [31:0]outhighneg;

genvar i;
genvar j;
assign cin = a[31] | b[31];

always @ (!count) begin
    multiplier <= b;
    acc <= 0;
    c <= 0;
end

for (i = 0; i < 32; i = i + 1) begin
    and(partial_product[i], a[i],multiplier[0]); //assigns temp as multiplicand * lsb of multiplier
end
fulladder32 add0 (.a (partial_product), .b (acc), .cin(c), .s (acc_temp), .cout (cout));

for (j = 0; j < 31; j = j + 1) begin
    always @ (posedge clk) begin
                multiplier[j] <= multiplier[j+1];
        multiplier[31] <= acc_temp[0];
        acc[j] <= acc_temp[j+1];
        acc[31] <= cout;

        count <= count + 1;    
    end 
end
for (i = 0; i < 32; i = i + 1) begin
    always @ (count == 32) begin
        c <= cin;
        acc[i] <= acc[i] ^ cin;
    end
    always @ (count == 33) begin
        outhigh <= acc;
        outhighneg[i] <= multiplier[31];
        outlow <= multiplier;
        count <= 0;
    end
end

assign lower = outlow;
mux high (.a (outhighneg), .b (outhigh), .ctrl (cin), .out (higher));

endmodule
