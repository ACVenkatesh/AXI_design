module rdata_mux_m4(
input  reset_n,

 // master
output    [3:0]  m00_axi_rid,
output   [31:0]  m00_axi_rdata,
output           m00_axi_rlast,
output    [1:0]  m00_axi_rresp,
output           m00_axi_rvalid,
input            m00_axi_rready,

 //slave 1
input     [3:0]  rid_DMA,
input    [31:0]  rdata_DMA,
input            rlast_DMA,
input     [1:0]  rresp_DMA,
input            rvalid_DMA,
output           rready_DMA,

 //slave 2
input     [3:0]  rid_SPI,
input    [31:0]  rdata_SPI,
input            rlast_SPI,
input     [1:0]  rresp_SPI,	
input            rvalid_SPI,
output           rready_SPI,

// slave 3
input     [3:0]  rid_I2C,
input    [31:0]  rdata_I2C,
input            rlast_I2C,
input     [1:0]  rresp_I2C,
input            rvalid_I2C,
output           rready_I2C,

 //slave 4
input     [3:0]  rid_FLASH_NAND,
input    [31:0]  rdata_FLASH_NAND,
input            rlast_FLASH_NAND,
input     [1:0]  rresp_FLASH_NAND,
input            rvalid_FLASH_NAND,
output           rready_FLASH_NAND,

 //slave 5
input     [3:0]  rid_FLASH_NOR,
input    [31:0]  rdata_FLASH_NOR,
input            rlast_FLASH_NOR,
input     [1:0]  rresp_FLASH_NOR,
input            rvalid_FLASH_NOR,
output           rready_FLASH_NOR,

 //slave 6
input     [3:0]  rid_PCIe,
input    [31:0]  rdata_PCIe,
input            rlast_PCIe,
input     [1:0]  rresp_PCIe,	
input            rvalid_PCIe,
output           rready_PCIe,

// slave 7
input     [3:0]  rid_ETHERNET,
input    [31:0]  rdata_ETHERNET,
input            rlast_ETHERNET,
input     [1:0]  rresp_ETHERNET,
input            rvalid_ETHERNET,
output           rready_ETHERNET,

 //slave 8
input     [3:0]  rid_DDR3,
input    [31:0]  rdata_DDR3,
input            rlast_DDR3,
input     [1:0]  rresp_DDR3,
input            rvalid_DDR3,
output           rready_DDR3,

 //select
input     [3:0]  sel
);


// rdata mux
assign m00_axi_rid  = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? rid_DMA[3:0] : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? rid_SPI[3:0] : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? rid_I2C[3:0] : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? rid_FLASH_NAND[3:0] : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? rid_FLASH_NOR[3:0] : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? rid_PCIe[3:0] : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? rid_ETHERNET[3:0]: rid_DDR3[3:0];
assign m00_axi_rdata  = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? rdata_DMA : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? rdata_SPI : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? rdata_I2C : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? rdata_FLASH_NAND : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? rdata_FLASH_NOR : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? rdata_PCIe : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? rdata_ETHERNET  : rdata_DDR3;
assign m00_axi_rresp  = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? rresp_DMA : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? rresp_SPI : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? rresp_I2C:((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? rresp_FLASH_NAND : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? rresp_FLASH_NOR : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? rresp_PCIe :((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? rresp_ETHERNET : rresp_DDR3;
assign m00_axi_rlast  = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? rlast_DMA : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? rlast_SPI : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? rlast_I2C : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? rlast_FLASH_NAND: ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? rlast_FLASH_NOR : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? rlast_PCIe : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? rlast_ETHERNET : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? rlast_DDR3 : 1'b0;
assign m00_axi_rvalid  = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? rvalid_DMA : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? rvalid_SPI : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? rvalid_I2C : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? rvalid_FLASH_NAND : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? rvalid_FLASH_NOR : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? rvalid_PCIe : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? rvalid_ETHERNET : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? rvalid_DDR3 : 1'b0;

// aasign ready singal
assign rready_DMA = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? m00_axi_rready : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0 : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? 1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;
assign rready_SPI = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? m00_axi_rready : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0 : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? 1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;
assign rready_I2C = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? m00_axi_rready : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0 : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? 1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;

assign rready_FLASH_NAND = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? m00_axi_rready : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? 1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;
assign rready_FLASH_NOR = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0  : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? m00_axi_rready: ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? 1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;

assign rready_PCIe = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0  : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ? m00_axi_rready: ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;
assign rready_ETHERNET = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0  : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ?  1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? m00_axi_rready : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? 1'b0 : 1'b0;


assign rready_DDR3 = ((rid_DMA[3:2]==sel)&rvalid_DMA) ? 1'b0 : ((rid_SPI[3:2]==sel)&rvalid_SPI) ? 1'b0 : ((rid_I2C[3:2]==sel)&rvalid_I2C) ? 1'b0 : ((rid_FLASH_NAND[3:2]==sel)&rvalid_FLASH_NAND) ? 1'b0  : ((rid_FLASH_NOR[3:2]==sel)&rvalid_FLASH_NOR) ? 1'b0 : ((rid_PCIe[3:2]==sel)&rvalid_PCIe) ?  1'b0 : ((rid_ETHERNET[3:2]==sel)&rvalid_ETHERNET) ? 1'b0 : ((rid_DDR3[3:2]==sel)&rvalid_DDR3) ? m00_axi_rready : 1'b0;


endmodule