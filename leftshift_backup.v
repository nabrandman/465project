module leftshift(
    input clk,
    input in_en,
    input [31:0] a,
    input [4:0] b,
    output reg out_en,
    output [31:0] out
);

reg [31:0] a_r;
reg [4:0] b_r;
reg [31:0] out_r;

reg [31:0] mask;
reg [31:0] mask_r;

assign out = out_r;

always @(posedge clk) begin
    if(in_en) begin
        a_r <= a;
        b_r <= b;
        mask <= 1;
    end
    else begin
        a_r <= a_r;
        b_r <= b_r;
        mask <= mask_r;
    end
end

fulladder32 shift_adder(.a(mask), .b(mask), .cin(), .s(mask_r), .cout());

always @(posedge clk) begin
    case (b_r & mask[4:0])
        5'b00001: a_r <= {a_r[30:0], 1'b0};
        5'b00010: a_r <= {a_r[29:0], {2{1'b0}}};
        5'b00100: a_r <= {a_r[27:0], {4{1'b0}}};
        5'b01000: a_r <= {a_r[23:0], {8{1'b0}}};
        5'b10000: a_r <= {a_r[15:0], {16{1'b0}}};
        default:;
    endcase
    if(mask[4:0] == 5'b10000) begin 
        out_r <= a_r;
        out_en <= 1;
    end
    else 
    begin
        out_r <= out_r;
        out_en <= 0;
    end
end

endmodule
