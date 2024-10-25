module PGGen(output g, p, input a, b);
 
  and #(1) (g, a, b);
  xor #(2) (p, a, b);
 
endmodule

module tt_um_CLA8(
  input  wire [7:0] ui_in,    // Dedicated inputs
  output wire [7:0] uo_out,   // Dedicated outputs
  input  wire [7:0] uio_in,   // IOs: Input path
  output wire [7:0] uio_out,  // IOs: Output path
  output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
  input  wire       ena,      // always 1 when the design is powered, so you can ignore it
  input  wire       clk,      // clock
  input  wire       rst_n     // reset_n - low to reset
);

wire [7:0] a, b;
wire [7:0] sum;
wire cout;

assign a = ui_in[7:0];
assign b = uio_in[7:0];

wire [7:0] g, p, c; 
wire [135:0] e;
wire cin;
buf #(1) (cin, 0);
//c[0]
and #(1) (e[0], cin, p[0]);
or #(1) (c[0], e[0], g[0]);

//c[1]
and #(1) (e[1], cin, p[0], p[1]);
and #(1) (e[2], g[0], p[1]);
or #(1) (c[1], e[1], e[2], g[1]);

//c[2]
and #(1) (e[3], cin, p[0], p[1], p[2]);
and #(1) (e[4], g[0], p[1], p[2]);
and #(1) (e[5], g[1], p[2]);
or #(1) (c[2], e[3], e[4], e[5], g[2]);

//c[3]
and #(1) (e[6], cin, p[0], p[1], p[2], p[3]);
and #(1) (e[7], g[0], p[1], p[2], p[3]);
and #(1) (e[8], g[1], p[2], p[3]);
and #(1) (e[9], g[2], p[3]);
or #(1) (c[3], e[6], e[7], e[8], e[9], g[3]);

//c[4]
and #(1) (e[10], cin, p[0], p[1], p[2], p[3], p[4]);
and #(1) (e[11], g[0], p[1], p[2], p[3], p[4]);
and #(1) (e[12], g[1], p[2], p[3], p[4]);
and #(1) (e[13], g[2], p[3], p[4]);
and #(1) (e[14], g[3], p[4]);
or #(1) (c[4], e[10], e[11], e[12], e[13], e[14], g[4]);

//c[5]
and #(1) (e[15], cin, p[0], p[1], p[2], p[3], p[4], p[5]);
and #(1) (e[16], g[0], p[1], p[2], p[3], p[4], p[5]);
and #(1) (e[17], g[1], p[2], p[3], p[4], p[5]);
and #(1) (e[18], g[2], p[3], p[4], p[5]);
and #(1) (e[19], g[3], p[4], p[5]);
and #(1) (e[20], g[4], p[5]);
or #(1) (c[5], e[15], e[16], e[17], e[18], e[19], e[20], g[5]);

//c[6]
and #(1) (e[21], cin, p[0], p[1], p[2], p[3], p[4], p[5], p[6]);
and #(1) (e[22], g[0], p[1], p[2], p[3], p[4], p[5], p[6]);
and #(1) (e[23], g[1], p[2], p[3], p[4], p[5], p[6]);
and #(1) (e[24], g[2], p[3], p[4], p[5], p[6]);
and #(1) (e[25], g[3], p[4], p[5], p[6]);
and #(1) (e[26], g[4], p[5], p[6]);
and #(1) (e[27], g[5], p[6]);
or #(1) (c[6], e[21], e[22], e[23], e[24], e[25], e[26], e[27], g[6]);

//c[7]
and #(1) (e[28], cin, p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
and #(1) (e[29], g[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
and #(1) (e[30], g[1], p[2], p[3], p[4], p[5], p[6], p[7]);
and #(1) (e[31], g[2], p[3], p[4], p[5], p[6], p[7]);
and #(1) (e[32], g[3], p[4], p[5], p[6], p[7]);
and #(1) (e[33], g[4], p[5], p[6], p[7]);
and #(1) (e[34], g[5], p[6], p[7]);
and #(1) (e[35], g[6], p[7]);
or #(1) (c[7], e[28], e[29], e[30], e[31], e[32], e[33], e[34], e[35], g[7]);

xor #(2) (sum[0],p[0],cin);
xor #(2) x[7:1](sum[7:1],p[7:1],c[6:0]);
buf #(1) (cout, c[7]);
PGGen pggen[7:0](g[7:0],p[7:0],a[7:0],b[7:0]);

assign uo_out[7:0] = sum[7:0];
assign uio_out[7:0] = 8'b00000000;
assign uio_oe = 8'b00000000;
endmodule
