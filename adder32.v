module fulladder32 (input [31:0]a, input [31:0]b, input cin, output [31:0]s, output cout);

wire [30:0]carry;
//a & b are numbers to be added, s is sum, cin/out are carry in/out, carry is what takes each 1-bit adders carry out to the next 1-bit adders carry in
    genvar i;
    adder u0 (.a (a[0]), .b (b[0]), .cin (cin), .s (s[0]), .cout (carry[0])); // 1st adder w/ lsb of a & b, carry-in, gives out lsb of sum & carry out into 1st carry wire

    generate
        for (i = 1; i < 31; i = i + 1) begin: generate_adder    //loops over a variable to create all the middle adders
            adder u1 (.a (a[i]), .b (b[i]), .cin (carry[i-1]), .s (s[i]), .cout (carry[i]));
            //adders 2-31, in is relevant bits of a & b, carry-in is carry-out from previous adder, puts out relevant bit of sum & carry-out for final adder
        end
    endgenerate

    adder u2 (.a (a[31]), .b (b[31]), .cin (carry[30]), .s (s[31]), .cout (cout));
    //final adder, in is msb's of a & b, carry-in is carryout of previous adder, outputs msb of sum and carryout
endmodule
