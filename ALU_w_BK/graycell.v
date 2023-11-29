module graycell(
    input p,
    input g,
    input g1,
    output g_out
);

assign g_out = (p&g1) | g;

endmodule