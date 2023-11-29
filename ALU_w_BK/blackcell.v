module blackcell(
    input p,
    input g,
    input p1,
    input g1,
    output p_out,
    output g_out
);

assign g_out = (p&g1) | g;
assign p_out = p & p1;

endmodule