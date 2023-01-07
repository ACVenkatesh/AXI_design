module ar_mux_m4(
input reset_n,

// master 1
input   [31:0]  m00_axi_araddr,
input    [3:0]  m00_axi_arid,
input    [1:0]  m00_axi_arburst,
input    [3:0]  m00_axi_arlen,
input    [2:0]  m00_axi_arsize,
input    [1:0]  m00_axi_arlock,
input    [3:0]  m00_axi_arcache,
input    [2:0]  m00_axi_arprot,
input           m00_axi_arvalid,
output          m00_axi_arready,


// slave
output  [31:0]  S_AXI_ARADDR,
output   [3:0]  S_AXI_ARID,
output   [1:0]  S_AXI_ARBURST,
output   [3:0]  S_AXI_ARLEN,
output   [2:0]  S_AXI_ARSIZE,
output   [1:0]  S_AXI_ARLOCK,
output   [3:0]  S_AXI_ARCACHE,
output   [2:0] S_AXI_ARPROT,
output          S_AXI_ARVALID,
input           S_AXI_ARREADY,

// select
input    [1:0]  sel
);


// AR MUX
assign S_AXI_ARADDR   = (( m00_axi_araddr[12:11]==sel)& m00_axi_arvalid) ? m00_axi_araddr : 1'b0;
assign S_AXI_ARID     = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? {2'b00,m00_axi_arid} : 1'b0;
assign S_AXI_ARLEN    = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ?  m00_axi_arlen : 1'b0;
assign S_AXI_ARSIZE   = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arsize : 1'b0;
assign S_AXI_ARBURST  = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arburst : 1'b0;
assign S_AXI_ARLOCK   = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arlock : 1'b0;
assign S_AXI_ARCACHE  = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arcache : 1'b0;
assign S_AXI_ARPROT   = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arprot : 1'b0;

assign S_AXI_ARVALID  = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? m00_axi_arvalid :  1'b0;
assign arready_m1 = ((m00_axi_araddr[12:11]==sel)&m00_axi_arvalid) ? S_AXI_ARREADY :  1'b0;

endmodule