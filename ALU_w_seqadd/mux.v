module mux (input [31:0]a, input [31:0]b, input ctrl, output [31:0]out);

    assign out = ctrl ? a : b;  //simple multiplexer to choose 1 (32-bit) input to put out based on 1 control bit

endmodule
