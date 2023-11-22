module newadder (input [31:0]a, input[31:0]b, input cin, input [4:0]ctrl, input clk, output [31:0]sum, output cout, output out_en);

reg [31:0]a_r;
reg [31:0]b_r;
reg [31:0]part_sum;
reg carry;
reg [5:0]count = 0;
reg in_en;
reg out;
reg finish;

wire [31:0]ashift;
wire [31:0]bshift;
wire a_add;
wire b_add;
wire [30:0]sumshift;
wire newcarry;
wire new_cin;
wire sumout;
reg [31:0]finalsum;
reg finalcarry;

genvar i;

always @ (a or b or ctrl) begin
    in_en <= 1;
    out <= 0;
    finish <= 0;
end

assign out_en = out;

//or(zero, count[4], count[3], count[2], count[1], count[0]);
//and(out_en, count[5], count[0]);
//and(reset, count[4], count[3], count[2], count[1], count[0]);
and(final, count[4], count[3], count[2], count[1], count[0]);

for (i = 0; i < 31; i = i + 1) begin
    assign ashift[i] = a_r[i+1];
    assign bshift[i] = b_r[i+1];
    assign sumshift[i] = part_sum[i+1];
end
assign ashift[31] = 0;
assign bshift[31] = 0;

assign a_add = a_r[0];
assign b_add = b_r[0];
assign new_cin = carry;

adder add (.a (a_add), .b (b_add), .cin (new_cin), .s (sumout), .cout (newcarry));

//mux muxa (.a (ashift), .b (a), .ctrl (zero), .out (amux));
//mux muxb (.a (bshift), .b (b), .ctrl (zero), .out (bmux));
//mux muxc (.a (cin), .b (newcarry), .ctrl (zero), .out (carrymux));
//assign carrymux = zero ? newcarry : cin;


always @ (posedge clk) begin
    if (in_en == 1) begin
        in_en <= 0;
        a_r <= a;
        b_r <= b;
        carry <= cin;
        count <= 0;
    end else if (in_en == 0 && finish == 0) begin
        a_r <= ashift;
        b_r <= bshift;
        carry <= newcarry;
        part_sum[30:0] <= sumshift[30:0];
        part_sum[31] <= sumout;
        count <= count + 1;
        finish <= final;
    end
    if (finish == 1) begin
        finalsum <= part_sum;
        finalcarry <= carry;
        out <= finish;
    end
end

/*always @ (reset) begin
    count <= 0;
end*/

//assign finish = out_en;
assign sum = finalsum;
assign cout = finalcarry;

endmodule
