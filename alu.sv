typedef enum { 
    AND,
    OR,
    XOR
} operator_t /*verilator public*/;

module alu (
    input logic clk,
    input logic [31:0] operand1_i,
    input logic [31:0] operand2_i,
    input operator_t operator_i,

    output logic [31:0] result_o
);

    logic [31:0] result;
    
    always_ff @( posedge clk ) begin
        result_o <= result;
    end

    always_comb begin
        case (operator_i)
            AND: result = operand1_i & operand2_i;
            OR: result = operand1_i | operand2_i;
            XOR: result = (operand1_i & ~operand2_i) | (~operand1_i & operand2_i);
            default: result = 0;
        endcase
    end
endmodule