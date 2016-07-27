// Example 24e: sqrt_top
module sqrt_top (
input wire mclk ,
input wire [3:0] btn ,
input wire [7:0] sw ,
output wire [7:0] ld ,
output wire dp ,
output wire [6:0] a_to_g ,
output wire [3:0] an
);
wire clk25, clk190, clr, done;
wire [15:0] x;
wire [9:0] p;
wire [3:0] root;
wire [7:0] b, r;
assign clr = btn[3];
assign r = {4'b0000,root};
assign x = {6'b000000,p};
assign ld = sw;
clkdiv U1 (.mclk(mclk),
.clr(clr),
.clk190(clk190),
.clk25(clk25)
);
sqrt U2 (.clk(clk25),
.clr(clr),
.go(btn[0]),
.sw(sw),
.done(done),
.root(root)
);

mux2g #(
.N(8))
U3 (.a(sw),
.b(r),
.s(done),
.y(b)
);
binbcd8 U4 (.b(b),
.p(p)
);
x7segb U5 (.x(x),
.cclk(clk190),
.clr(clr),
.a_to_g(a_to_g),
.an(an),
.dp(dp)
);
endmodule