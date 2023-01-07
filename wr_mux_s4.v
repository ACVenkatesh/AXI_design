module wr_mux_s4(
input      reset_n,

// master
output  [3:0]  m00_axi_bid,
output  [1:0]  m00_axi_bresp,
output         m00_axi_bvalid,
input          m00_axi_bready,

// slave 1
input   [3:0]  bid_DMA,
input   [1:0]  bresp_DMA,
input          bvalid_DMA,
output         bready_DMA,

// slave 2
input   [3:0]  bid_SPI,
input   [1:0]  bresp_SPI,
input          bvalid_SPI,
output         bready_SPI,

// slave 3
input   [3:0]  bid_I2C,
input   [1:0]  bresp_I2C,
input          bvalid_I2C,
output         bready_I2C,

// slave 4
input   [3:0]  bid_FLASH_NAND,
input   [1:0]  bresp_FLASH_NAND,
input          bvalid_FLASH_NAND,
output         bready_FLASH_NAND,

// slave 5
input   [3:0]  bid_FLASH_NOR,
input   [1:0]  bresp_FLASH_NOR,
input          bvalid_FLASH_NOR,
output         bready_FLASH_NOR,

// slave 6
input   [3:0]  bid_PCIe,
input   [1:0]  bresp_PCIe,
input          bvalid_PCIe,
output         bready_PCIe,

// slave 7
input   [3:0]  bid_ETHERNET,
input   [1:0]  bresp_ETHERNET,
input          bvalid_ETHERNET,
output         bready_ETHERNET,

// slave 8
input   [3:0]  bid_DDR3,
input   [1:0]  bresp_DDR3,
input          bvalid_DDR3,
output         bready_DDR3,

// select
input   [2:0]  sel
);

// wresponse mux
assign m00_axi_bid = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? bid_DMA[3:0] : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? bid_SPI[3:0] : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? bid_I2C[3:0]: ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? bid_FLASH_NAND[3:0] : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? bid_FLASH_NOR[3:0] : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? bid_PCIe[3:0] : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? bid_ETHERNET[3:0]: bid_DDR3[3:0];
assign m00_axi_bvalid = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? bvalid_DMA : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? bvalid_SPI : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? bvalid_I2C : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? bvalid_FLASH_NAND : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? bvalid_FLASH_NOR : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? bvalid_PCIe : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? bvalid_ETHERNET : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? bvalid_DDR3 : 1'b0;
assign m00_axi_bresp = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? bresp_DMA : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? bresp_SPI : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? bresp_I2C : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? bresp_FLASH_NAND : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? bresp_FLASH_NOR : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? bresp_PCIe : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? bresp_ETHERNET  : bresp_DDR3 ;

assign bready_DMA = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? m00_axi_bready : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0 : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0 : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? 1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;
assign bready_SPI = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? m00_axi_bready : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0 : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0 : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? 1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;
assign bready_I2C = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? m00_axi_bready : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0 : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0 : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? 1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;

assign bready_FLASH_NAND = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? m00_axi_bready : ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0 : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? 1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;
assign bready_FLASH_NOR = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0: ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? m00_axi_bready  : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ? 1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;

assign bready_PCIe =  ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0: ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0  : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ?  m00_axi_bready : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;
assign bready_ETHERNET = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0: ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0  : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ?  1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? m00_axi_bready  : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ? 1'b0: 1'b0;
assign bready_DDR3 = ((bid_DMA[3:2]==sel)&bvalid_DMA) ? 1'b0 : ((bid_SPI[3:2]==sel)&bvalid_SPI) ? 1'b0 : ((bid_I2C[3:2]==sel)&bvalid_I2C) ? 1'b0 : ((bid_FLASH_NAND[3:2]==sel)&bvalid_FLASH_NAND) ? 1'b0: ((bid_FLASH_NOR[3:2]==sel)&bvalid_FLASH_NOR) ? 1'b0  : ((bid_PCIe[3:2]==sel)&bvalid_PCIe) ?  1'b0 : ((bid_ETHERNET[3:2]==sel)&bvalid_ETHERNET) ? 1'b0 : ((bid_DDR3[3:2]==sel)&bvalid_DDR3) ?  m00_axi_bready: 1'b0;

endmodule