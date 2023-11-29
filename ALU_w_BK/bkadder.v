module bkadder(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] s,
    output cout
);

wire [31:0] p_gen;
wire [31:0] g_gen;
wire [32:0] p;
wire [32:0] g;
wire [32:0] pl1;
wire [32:0] gl1;
wire [32:0] pl2;
wire [32:0] gl2;
wire [32:0] pl3;
wire [32:0] gl3;
wire [32:0] pl4;
wire [32:0] gl4;
wire [32:0] pl5;
wire [32:0] gl5;
wire [32:0] pl6;
wire[32:0] gl6;
wire [32:0] pl7;
wire [32:0] gl7;
wire [32:0] pl8;
wire [32:0] gl8;
wire [32:0] pl9;
wire [32:0] gl9;

assign p_gen = a^b;
assign g_gen = a&b;
assign p = {p_gen, 1'b0};
assign g = {g_gen, cin};

genvar i;
//level 1
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%2 == 1) begin
            if(i == 1) begin
                graycell gl1(p[i], g[i], g[i-1], gl1[i]);
                assign pl1 = p[i];
            end
            else begin 
                blackcell bl1(p[i], g[i], p[i-1], g[i-1], pl1[i], gl1[i]);
            end
        end
        else begin 
            assign pl1 = p[i];
            assign gl1 = g[i];
        end
    end
endgenerate

//level 2
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%4 == 3) begin
            if(i == 3) begin
                graycell gl2(pl1[i], gl1[i], gl1[i-2], gl2[i]);
                assign pl2 = pl1[i];
            end
            else begin 
                blackcell bl2(pl1[i], gl1[i], pl1[i-2], gl1[i-2], pl2[i], gl2[i]);
            end
        end
        else begin 
            assign pl2 = pl1[i];
            assign gl2 = gl1[i];
        end
    end
endgenerate

//level 3
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%8 == 7) begin
            if(i == 7) begin
                graycell gl3(pl2[i], gl2[i], gl2[i-4], gl3[i]);
                assign pl3 = pl2[i];
            end
            else begin 
                blackcell bl3(pl2[i], gl2[i], pl2[i-4], gl2[i-4], pl3[i], gl3[i]);
            end
        end
        else begin 
            assign pl3 = pl2[i];
            assign gl3 = gl2[i];
        end
    end
endgenerate

//level 4
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%16 == 15) begin
            if(i == 15) begin
                graycell gl4(pl3[i], gl3[i], gl3[i-8], gl4[i]);
                assign pl4 = pl3[i];
            end
            else begin 
                blackcell bl4(pl3[i], gl3[i], pl3[i-8], gl3[i-8], pl4[i], gl4[i]);
            end
        end
        else begin 
            assign pl4 = pl3[i];
            assign gl4 = gl3[i];
        end
    end
endgenerate

//level 5
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i == 31) begin
            graycell gl5(pl4[i], gl4[i], gl4[i-16], gl5[i]);
            assign pl5 = pl4[i];
        end
        else begin 
            assign pl5 = pl4[i];
            assign gl5 = gl4[i];
        end
    end
endgenerate

//level 6
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i == 23) begin
            graycell gl6(pl5[i], gl5[i], gl5[i-8], gl6[i]);
            assign pl6 = pl5[i];
        end
        else begin 
            assign pl6 = pl5[i];
            assign gl6 = gl5[i];
        end
    end
endgenerate

//level 7
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%8 == 3 && i != 3) begin
            graycell gl7(pl6[i], gl6[i], gl6[i-4], gl7[i]);
            assign pl7 = pl6[i];
        end
        else begin 
            assign pl7 = pl6[i];
            assign gl7 = gl6[i];
        end
    end
endgenerate

//level 8
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%4 == 1 && i != 1) begin
            graycell gl8(pl7[i], gl7[i], gl7[i-2], gl8[i]);
            assign pl8 = pl7[i];
        end
        else begin 
            assign pl8 = pl7[i];
            assign gl8 = gl7[i];
        end
    end
endgenerate

//level 8
generate
    for(i=0; i <= 32; i=i+1) begin
        if(i%2 == 0 && i != 0) begin
            graycell gl9(pl8[i], gl8[i], gl8[i-1], gl9[i]);
            assign pl9 = pl8[i];
        end
        else begin 
            assign pl9 = pl8[i];
            assign gl9 = gl8[i];
        end
    end
endgenerate

assign s = gl9[31:0] ^ p[32:1];
assign cout = (gl9[31] & p[31]) | gl9[32];

endmodule