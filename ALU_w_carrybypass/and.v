module and1 (input a, input b, output y);
    //i know this might seem unnecessary and silly, but I want the alu itself to be consistent in referencing other modules for each different thing it can do
    and(y, a,b);

endmodule
