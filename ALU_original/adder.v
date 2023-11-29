module adder ( input    a,      //names module, declare's 2
               input    b,      //1-bit inputs to sum as well
               input    cin,    //as carry-in
               output   s,      //declares sum and carry-out
               output   cout);  //as outputs

    xor(x, a,b);    //lays out circuit of 1-bit full adder
    and(y, x,cin);  
    and(z, a,b);
    xor(s, x,cin);
    or(cout, y,z);
endmodule
