module submaster_rd_arb(
input clk,
input start_0,
output grant_0,
input xfer_done0,
output processing_submaster_DMA,
input start_1,
output grant_1,
input xfer_done1,
output processing_submaster_SPI,
input start_2,
output grant_2,
input xfer_done2,
output processing_submaster_I2C,
input start_3,
output grant_3,
input xfer_done3,
output processing_submaster_FLASH_NAND,
input start_4,
output grant_4,
input xfer_done4,
output processing_submaster_FLASH_NOR,
input start_5,
output grant_5,
input xfer_done5,
output processing_submaster_PCIe,
input start_6,
output grant_6,
input xfer_done6,
output processing_submaster_ETHERNET,
input start_7,
output grant_7,
input xfer_done7,
output processing_submaster_DDR3,
input resetn
);
reg[16:0] pstate ,nstate;
parameter[16:0] 
       PROCESS_START_DMA = 0,
       PROCESS_START_SPI = 1,
       PROCESS_START_I2C = 2,
       PROCESS_START_FLASH_NAND = 3,
       PROCESS_START_FLASH_NOR = 4,
       PROCESS_START_PCIe = 5,
       PROCESS_START_ETHERNET = 6,
       PROCESS_START_DDR3 = 7,
       WAIT_DMA_ST=8,
       WAIT_SPI_ST=9,
       WAIT_I2C_ST=10,
       WAIT_FLASH_NAND_ST=11,
       WAIT_FLASH_NOR_ST=12,
       WAIT_PCIe_ST=13,
       WAIT_ETHERNET_ST=14,
       WAIT_DDR3_ST=15,
       IDLE_ST=16;
always@(posedge clk or negedge resetn)
 if(!resetn)
  pstate <= IDLE_ST;
 else
  pstate <= nstate;

assign processing_submaster_DMA = pstate == PROCESS_START_DMA | pstate == WAIT_DMA_ST;
assign processing_submaster_SPI = pstate == PROCESS_START_SPI | pstate == WAIT_SPI_ST;
assign processing_submaster_I2C = pstate == PROCESS_START_I2C | pstate == WAIT_I2C_ST;
assign processing_submaster_FLASH_NAND = pstate == PROCESS_START_FLASH_NAND | pstate == WAIT_FLASH_NAND_ST;
assign processing_submaster_FLASH_NOR = pstate == PROCESS_START_FLASH_NOR | pstate == WAIT_FLASH_NOR_ST;
assign processing_submaster_PCIe = pstate == PROCESS_START_PCIe | pstate == WAIT_PCIe_ST;
assign processing_submaster_ETHERNET = pstate == PROCESS_START_ETHERNET | pstate == WAIT_ETHERNET_ST;
assign processing_submaster_DDR3 = pstate == PROCESS_START_DDR3 | pstate == WAIT_DDR3_ST;
always@(*)
begin
nstate = IDLE_ST;
case(pstate)
  IDLE_ST:
          if(start_0)
            nstate = PROCESS_START_DMA;
          else if(start_1)
            nstate = PROCESS_START_SPI;
          else if(start_2)
            nstate = PROCESS_START_I2C;
          else if(start_3)
            nstate = PROCESS_START_FLASH_NAND;
          else if(start_4)
            nstate = PROCESS_START_FLASH_NOR;
          else if(start_5)
            nstate = PROCESS_START_PCIe;
          else if(start_6)
            nstate = PROCESS_START_ETHERNET;
          else if(start_7)
            nstate = PROCESS_START_DDR3;
          else
            nstate = IDLE_ST;

  PROCESS_START_DMA:
          nstate = WAIT_DMA_ST;
  PROCESS_START_SPI:
          nstate = WAIT_SPI_ST;
  PROCESS_START_I2C:
          nstate = WAIT_I2C_ST;
  PROCESS_START_FLASH_NAND:
          nstate = WAIT_FLASH_NAND_ST;
  PROCESS_START_FLASH_NOR:
          nstate = WAIT_FLASH_NOR_ST;
  PROCESS_START_PCIe:
          nstate = WAIT_PCIe_ST;
  PROCESS_START_ETHERNET:
          nstate = WAIT_ETHERNET_ST;
PROCESS_START_DDR3:
          nstate = WAIT_DDR3_ST;
  WAIT_DMA_ST:
          if(xfer_done0)
            nstate = IDLE_ST;
          else
            nstate = WAIT_DMA_ST;
  WAIT_SPI_ST:
          if(xfer_done1)
            nstate = IDLE_ST;
          else
            nstate = WAIT_SPI_ST;
  WAIT_I2C_ST:
          if(xfer_done2)
            nstate = IDLE_ST;
          else
            nstate = WAIT_I2C_ST;
  WAIT_FLASH_NAND_ST:
          if(xfer_done3)
            nstate = IDLE_ST;
          else
            nstate = WAIT_FLASH_NAND_ST;
  WAIT_FLASH_NOR_ST:
          if(xfer_done4)
            nstate = IDLE_ST;
          else
            nstate = WAIT_FLASH_NOR_ST;
WAIT_PCIe_ST:
          if(xfer_done5)
            nstate = IDLE_ST;
          else
            nstate = WAIT_PCIe_ST;
WAIT_ETHERNET_ST:
          if(xfer_done6)
            nstate = IDLE_ST;
          else
            nstate = WAIT_ETHERNET_ST;
WAIT_DDR3_ST:
          if(xfer_done7)
            nstate = IDLE_ST;
          else
            nstate = WAIT_DDR3_ST;
endcase
end
assign grant_0 = pstate == PROCESS_START_DMA;
assign grant_1 = pstate == PROCESS_START_SPI;
assign grant_2 = pstate == PROCESS_START_I2C;
assign grant_3 = pstate == PROCESS_START_FLASH_NAND;
assign grant_4 = pstate == PROCESS_START_FLASH_NOR;
assign grant_5 = pstate == PROCESS_START_PCIe;
assign grant_6 = pstate == PROCESS_START_ETHERNET;
assign grant_7 = pstate == PROCESS_START_DDR3;
endmodule