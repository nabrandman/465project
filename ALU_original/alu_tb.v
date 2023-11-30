`timescale 1ns/1ps

module tb_alu;
    reg [31:0]a;
    reg [31:0]b;
    reg clk;
    reg [4:0]ctrl;
    wire [31:0]out;
    wire cout;

    // setting up clock
    initial begin
        clk <= 0;
        forever begin
            #5;
            clk <= ~clk;
        end
    end
    
    initial begin
        // use same values for all operations
        a <= 10000;
        b <= 8; // small b to show all operations
    // add =  0    0     000
        ctrl <= 5'b00000; 
//        getting rid of wait statements b/c take too long for mul/div 
//        wait(out == (a+b));
        #100;
    // sll =  0    0     001
        ctrl <=5'b00001; 
        #100
//        wait(out == (a<<8));
    // xor =  0    0     100
        ctrl <= 5'b00100; 
//        wait(out == (a^b))
        #100;
    // srl =  0    0     101
        ctrl <= 5'b00101;
        #100;
    // or =  0    0     110
        ctrl <= 5'b00110;
        #100;
    // and =  0    0     111
        ctrl <= 5'b00111;
        #100;
    // mul =  0    1     000
        ctrl <= 5'b01000;
//        wait(out == 80000);
        #100;
    // mulh =  0    1     001
        ctrl <= 5'b01001;
        #100;
    // mulhsu =  0    1     010
        ctrl <= 5'b01010;
        #100;
    // mulhu =  0    1     011
        ctrl <= 5'b01011;
        #100;
    // div =  0    1     100
        ctrl <= 5'b01100;
        a <= 0;
        b <= 0;
        #10;
        a <= 10000;
        b <= 8; 
//        wait(out == 1250);
        #100;
    // divu =  0    1     101
        ctrl <= 5'b01101;
        a <= 0;
        b <= 0;
        #10;
        a <= 10000;
        b <= 8; 
//        wait(out == 1250);
        #100;
    // rem =  0    1     110
        ctrl <= 5'b01110;
        a <= 0;
        b <= 0;
        #10;
        a <= 10000;
        b <= 8; 
//        wait(out == 0);
        #100;
    // remu =  0    1     111
        ctrl <= 5'b01111;
        a <= 0;
        b <= 0;
        #10;
        a <= 10000;
        b <= 8; 
        #100;
    // sub =  1    0     000
        ctrl <= 5'b10000;
        #100;
    // sra =  1    0     101
        ctrl <= 5'b10101;
        #100;
    end
    alu u0 (.a (a), .b (b), .clk (clk), .ctrl (ctrl), .y (out), .cout (cout));

endmodule

