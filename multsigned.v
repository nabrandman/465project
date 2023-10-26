module mult (input [31:0]a, input [31:0]b, input clk, input [1:0]sign, output [31:0]lower, output [31:0]higher);

wire [31:0]partial_product;
wire [31:0]acc_temp;
wire [31:0]achange;
wire [31:0]bchange;
reg [31:0]multiplicand;
wire [31:0]cin;
reg [31:0]acc;
reg [31:0]multiplier;
reg c;
wire cout;
reg [5:0]count = 0;
reg [31:0]outlow;
reg [31:0]outhigh;

genvar i;
genvar j;

for (i = 0; i < 32; i = i + 1) begin
assign achange[i] = a[31] & ~(sign[1] & sign[0]);
assign bchange[i] = b[31] & (~sign[1]);

assign cin[i] = achange[i] ^ bchange[i];
    always @ (!count) begin
        multiplier <= (b ^ bchange) + bchange[0];
        multiplicand <= (a ^ achange) + achange[0];
        acc <= 0;
        c <= 0;
    end
end

for (i = 0; i < 32; i = i + 1) begin
    and(partial_product[i], multiplicand[i],multiplier[0]); //creates partial product by multiplicand * lsb of multiplier
end
fulladder32 add0 (.a (partial_product), .b (acc), .cin(c), .s (acc_temp), .cout (cout));    //adds partial product to current accumulator value to

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
    always @ (count == 33) begin
        outhigh <= (acc ^ cin);
        outlow <= (multiplier ^ cin) + cin[0];
        count <= 0;
    end
end

assign lower = outlow;
assign higher = outhigh;

endmodule
