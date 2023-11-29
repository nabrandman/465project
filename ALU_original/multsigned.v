module mult (input [31:0]a, input [31:0]b, input clk, input [4:0]ctrl, output [31:0]lower, output [31:0]higher);

reg in_en;
reg out_en;
wire [1:0]sign;
wire [31:0]achange;
wire [31:0]bchange;
reg [31:0]multiplicand;
wire [31:0]cin;
reg [31:0]acc;
reg [31:0]multiplier;
reg [4:0]count;
reg [31:0]outlow;
reg [31:0]outhigh;
wire [31:0]multiplicand_init;
wire [31:0]multiplier_init;
wire [31:0]mult_shift;
wire [31:0]acc_shift;
wire [31:0]acc_temp;
wire [31:0]partial_product;
wire cout;
wire final;

genvar i;
genvar j;

always @ (a or b or ctrl) begin
    in_en <= 1;
    out_en <= 0;
end

assign sign = ctrl[1:0];

for (i = 0; i < 32; i = i + 1) begin
    assign achange[i] = a[31] & ~(sign[1] & sign[0]);
    assign bchange[i] = b[31] & (~sign[1]);

    assign cin[i] = achange[i] ^ bchange[i];
end
    assign multiplier_init = (b ^ bchange) + bchange[0];
    assign multiplicand_init = (a ^ achange) + achange[0];

for (i = 0; i < 32; i = i + 1) begin
    and(partial_product[i], multiplicand[i],multiplier[0]); //creates partial product by multiplicand * lsb of multiplier
end
fulladder32 add0 (.a (partial_product), .b (acc), .cin(1'b0), .s (acc_temp), .cout (cout));    //adds partial product to current accumulator value to

and(final, count[4],count[3],count[2],count[1],count[0]);
for (j = 0; j < 31; j = j + 1) begin
    assign mult_shift[j] = multiplier[j+1];
    assign mult_shift[31] = acc_temp[0];
    assign acc_shift[j] = acc_temp[j+1];
    assign acc_shift[31] = cout;
end

always @ (posedge clk) begin
    if (in_en == 1) begin
        in_en = 0;
        multiplicand <= multiplicand_init;
        multiplier <= multiplier_init;
        acc <= 0;
        count <= 0;
    end else if (in_en == 0 && out_en == 0) begin
        multiplier <= mult_shift;
        acc <= acc_shift;
        count <= count + 1;
        out_en <= final;
    end
    if (out_en == 1) begin
        outhigh <= (acc ^ cin);
        outlow <= (multiplier ^ cin) + cin[0];
    end
end 

assign lower = outlow;
assign higher = outhigh;

endmodule
