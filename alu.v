module alu (input [31:0]a, input [31:0]b, input [2:0]ctrl, output [31:0]y, output cout);
//inputs are a & b (either imm or reg), and ctrl which is used to select which operation to perform
//ouputs are carry-out and the actual output of the operation

//these wires just take info from one piece to the next
wire [31:0]midand;  //takes output of and operation to mux
wire [31:0]midadd;  //takes output of add/sub op to mux
wire [31:0]midor;   //takes output of or op to mux
wire [31:0]muxb;    //takes output of b input mux to all ops
wire [31:0]muxand;  //takes output of and/or mux to 2nd stage mux

mux b_or_not_b (.a (~b), .b (b), .ctrl (ctrl[2]), .out (muxb));
fulladder32 add (.a (a), .b (muxb), .cin (ctrl[2]), .s (midadd), .cout (cout));
and32 and0 (.a (a), .b (muxb), .y (midand));
or32 or0 (.a (a), .b (muxb), .y (midor));
mux andor (.a (midand), .b (midor), .ctrl (ctrl[1]), .out (muxand));
mux addand (.a (midadd), .b (muxand), .ctrl (ctrl[0]), .out (y));

//current layout is a is input directly to all ops
//b is split, going directly into a mux input, and also going through a NOT operation b4 entering other input of mux
    //this mux (b_or_not_b) uses msb of ctrl to select whether to use b (ctrl[2]=0) or b's complement (ctrl[2]=1)
    //the msb of ctrl is also used as the carry-in for the 32-bit adder, this way for ctrl[2]=0, the adder has inputs a, b, & 0
    //so adder outputs a + b
    //when ctrl[2] = 1, adder has inputs a, (~b), & 1,
    //so adder outputs a + ~b + 1 = a + (-b) = a - b
    //aka our adder doubles as a subtractor w/ ctrl[2] selecting for add or sub
//a & b also go out to AND & OR ops
//the AND & OR operations go into a mux selected by ctrl[1]
//the output of the and/or mux then goes into another mux w/ other input being the "sum" output of the add/sub, this mux controlled by ctrl[0]

endmodule
