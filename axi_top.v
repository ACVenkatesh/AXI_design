
//for bytecount field
//since PCIE max transfer size = 1024Dwords=4096bytes and we use 512bit axi data hence axlen=64 and  asize=64..fix bytecount field to be 12bit


module axi_top
#( parameter C_S_AXI_DATA_WIDTH	= 32,
                
				 C_S_AXI_ADDR_WIDTH	= 5,
                parameter C_NUM_OF_INTR	= 1,
		      
		        parameter C_IRQ_SENSITIVITY	= 1,
		        parameter C_IRQ_ACTIVE_STATE	= 1
               )
(
input clk,
input resetn,

//wr address channel
output [5:0] awid,
output [63:0] awaddr,
output [7:0] awlen,
output [2:0] awsize,
output [1:0] awburst,
output [0:0] awlock,
output [3:0] awcache,
output [2:0] awprot,
output [3:0] awqos,
output awregion,
output awuser,
output awvalid,
input awready,

//wr data channel
output [5:0]wid,
output [511:0] wdata,
output [63:0]wstrb,
output wlast,
output wuser,
output wvalid,
input wready,

//wr response channel
input [5:0]bid,
input [1:0]bresp,
input buser,
input bvalid,
output bready,


//rd address channel 
output [5:0] arid,
output [63:0] araddr,
output [7:0] arlen,
output [2:0] arsize,
output [1:0] arburst,
output [0:0] arlock,
output [3:0] arcache,
output [2:0] arprot,
output [3:0] arqos,
output arregion,
output aruser,
output arvalid,
input arready,

//rd data channel and resp
input [5:0]rid,
input [511:0] rdata,
input rlast,
output ruser,
input rvalid,
output rready,
input [1:0]rresp,
output csysreq,
output csysack,
input ip_wr_start0,
output ip_wr_grant0,
output wr_xfer_done0,
output wrfifo_rd0,

input [11:0]wrbytecount_0,
input [63:0]wraddr_0,
input [511:0]wrfifo_rddata0,
output axi_wr_err0,
input ip_wr_start1,
output ip_wr_grant1,
output wr_xfer_done1,
output wrfifo_rd1,

input [11:0]wrbytecount_1,
input [63:0]wraddr_1,
input [511:0]wrfifo_rddata1,
output axi_wr_err1,
input ip_wr_start2,
output ip_wr_grant2,
output wr_xfer_done2,
output wrfifo_rd2,

input [11:0]wrbytecount_2,
input [63:0]wraddr_2,
input [511:0]wrfifo_rddata2,
output axi_wr_err2,
input ip_wr_start3,
output ip_wr_grant3,
output wr_xfer_done3,
output wrfifo_rd3,

input [11:0]wrbytecount_3,
input [63:0]wraddr_3,
input [511:0]wrfifo_rddata3,
output axi_wr_err3,
input ip_wr_start4,
output ip_wr_grant4,
output wr_xfer_done4,
output wrfifo_rd4,

input [11:0]wrbytecount_4,
input [63:0]wraddr_4,
input [511:0]wrfifo_rddata4,
output axi_wr_err4,
input ip_wr_start5,
output ip_wr_grant5,
output wr_xfer_done5,
output wrfifo_rd5,

input [11:0]wrbytecount_5,
input [63:0]wraddr_5,
input [511:0]wrfifo_rddata5,
output axi_wr_err5,
input ip_wr_start6,
output ip_wr_grant6,
output wr_xfer_done6,
output wrfifo_rd6,

input [11:0]wrbytecount_6,
input [63:0]wraddr_6,
input [511:0]wrfifo_rddata6,
output axi_wr_err6,
input ip_wr_start7,
output ip_wr_grant7,
output wr_xfer_done7,
output wrfifo_rd7,

input [11:0]wrbytecount_7,
input [63:0]wraddr_7,
input [511:0]wrfifo_rddata7,
output axi_wr_err7,
//ports connected to read and write ip requestor block
//read ip requestor block
input ip_rd_start0,
output ip_rd_grant0,
output rd_xfer_done0,
output rdfifo_wr0,
input [11:0]rdbytecount_0,
input [63:0]rdaddr_0,
output axi_rd_err_0,
output [511:0]rdfifo_wrdata,
input ip_rd_start1,
output ip_rd_grant1,
output rd_xfer_done1,
output rdfifo_wr1,
input [11:0]rdbytecount_1,
input [63:0]rdaddr_1,
output axi_rd_err_1,
input ip_rd_start2,
output ip_rd_grant2,
output rd_xfer_done2,
output rdfifo_wr2,
input [11:0]rdbytecount_2,
input [63:0]rdaddr_2,
output axi_rd_err_2,

input ip_rd_start3,
output ip_rd_grant3,
output rd_xfer_done3,
output rdfifo_wr3,
input [11:0]rdbytecount_3,
input [63:0]rdaddr_3,
output axi_rd_err_3,

input ip_rd_start4,
output ip_rd_grant4,
output rd_xfer_done4,
output rdfifo_wr4,
input [11:0]rdbytecount_4,
input [63:0]rdaddr_4,
output axi_rd_err_4,

input ip_rd_start5,
output ip_rd_grant5,
output rd_xfer_done5,
output rdfifo_wr5,
input [11:0]rdbytecount_5,
input [63:0]rdaddr_5,
output axi_rd_err_5,

input ip_rd_start6,
output ip_rd_grant6,
output rd_xfer_done6,
output rdfifo_wr6,
input [11:0]rdbytecount_6,
input [63:0]rdaddr_6,
output axi_rd_err_6,

input ip_rd_start7,
output ip_rd_grant7,
output rd_xfer_done7,
output rdfifo_wr7,
input [11:0]rdbytecount_7,
input [63:0]rdaddr_7,
output axi_rd_err_7,

output cactive
);


wire processing_submaster_DDR3;
wire processing_submaster_FLASH_NAND;
wire processing_submaster_FLASH_NOR;
wire processing_submaster_DMA;
wire processing_submaster_PCIe;
wire processing_submaster_ETHERNET;
wire processing_submaster_I2C;
wire processing_submaster_SPI;

//multibit
wire [96:0]addrtrans_mem_rddata_rd;
wire [96:0]io_transfifo_wrdata_rd;
wire [96:0]addrtrans_mem_rddata_wr;
wire [96:0]io_transfifo_wrdata_wr;
wire [63:0]decoded_wraddress_in;
wire [63:0]decoded_rdaddress_in;
wire [11:0]decoded_wrbytecount_in;
wire [11:0]decoded_rdbytecount_in;
wire [82:0]ram4k_wrdata_waddr_mem;
wire [82:0]ram4k_wrdata_raddr_mem;
wire [82:0]ram_wrdata_rd_converter;
wire [96:0] dataout_raddr_mem;
wire [96:0]dataout_waddr_mem;
wire [96:0]ram_wrdata_wr_converter;
wire [96:0]axi_conv_fifo_rddata_0;
wire [96:0]axi_conv_fifo_wrdata_0;
wire [96:0]axi_conv_fifo_rddata_1;
wire [96:0]axi_conv_fifo_wrdata_1;
wire [96:0]axi_conv_fifo_rddata_2;
wire [96:0]axi_conv_fifo_wrdata_2;
wire [96:0]axi_conv_fifo_rddata_3;
wire [96:0]axi_conv_fifo_wrdata_3;
wire [96:0]axi_conv_fifo_rddata_4;
wire [96:0]axi_conv_fifo_wrdata_4;
wire [96:0]axi_conv_fifo_rddata_5;
wire [96:0]axi_conv_fifo_wrdata_5;
wire [96:0]axi_conv_fifo_rddata_6;
wire [96:0]axi_conv_fifo_wrdata_6;
wire [96:0]axi_conv_fifo_rddata_7;
wire [96:0]axi_conv_fifo_wrdata_7;
wire [7:0] current_wid_in_process;
wire [7:0] current_rid_in_process;
 wire [511:0]ip_data;

axi_rd axi_rd(
.clk(clk),
.resetn(resetn),
.addrtrans_mem_rddata(addrtrans_mem_rddata_rd),
.addrtrans_fifo_empty(addrtrans_fifo_empty_rd),
.axi_axready(arready),
.addrtrans_mem_rd(addrtrans_mem_rd_rd),
.axi_aid(arid),
.axi_addr(araddr),
.axi_alen(arlen),
.axi_asize(arsize),
.axi_axvalid(arvalid), //  
.rd_transfifo_wr(),
.io_transfifo_wrdata()
);



assign decoded_ip_wr_grant = ip_wr_grant0
            |ip_wr_grant1
            |ip_wr_grant2
            |ip_wr_grant3 
            |ip_wr_grant4
            |ip_wr_grant5
            |ip_wr_grant6
            |ip_wr_grant7;

assign decoded_ip_rd_grant = ip_rd_grant0

            |ip_rd_grant1
            |ip_rd_grant2
            |ip_rd_grant3
            |ip_rd_grant4
            |ip_rd_grant5
            |ip_rd_grant6
            |ip_rd_grant7;

assign decoded_rdaddress_in = 

                              (ip_rd_grant0)?rdaddr_0 :
                              (ip_rd_grant1)?rdaddr_1 :
                              (ip_rd_grant2)?rdaddr_2 :
                              (ip_rd_grant3)?rdaddr_3 :
                              (ip_rd_grant4)?rdaddr_4 :
                              (ip_rd_grant5)?rdaddr_5:
                              (ip_rd_grant6)?rdaddr_6:
                              (ip_rd_grant7)?rdaddr_7:64'd0;
assign decoded_wraddress_in = 
                              (ip_wr_grant0)?wraddr_0 :
                              (ip_wr_grant1)?wraddr_1 :
                              (ip_wr_grant2)?wraddr_2 :
                              (ip_wr_grant3)?wraddr_3 :
                              (ip_wr_grant4)?wraddr_4 :
                              (ip_wr_grant5)?wraddr_5:
                              (ip_wr_grant6)?wraddr_6:
                              (ip_wr_grant7)?wraddr_7:64'd0;
                      
assign decoded_rdbytecount_in =

(ip_rd_grant0)? rdbytecount_0 :
(ip_rd_grant1)? rdbytecount_1:
(ip_rd_grant2)? rdbytecount_2 :
(ip_rd_grant3)? rdbytecount_3 :
(ip_rd_grant4)? rdbytecount_4 :
(ip_rd_grant5)? rdbytecount_5:
(ip_rd_grant6)? rdbytecount_6 :
(ip_rd_grant7)? rdbytecount_7 :12'd0;

assign decoded_wrbytecount_in = 
(ip_wr_grant0)? wrbytecount_0 :
(ip_wr_grant1)? wrbytecount_1:
(ip_wr_grant2)? wrbytecount_2:
(ip_wr_grant3)? wrbytecount_3 :
(ip_wr_grant4)? wrbytecount_4 :
(ip_wr_grant5)? wrbytecount_5:
(ip_wr_grant6)? wrbytecount_6 :
(ip_wr_grant7)? wrbytecount_7 :12'd0;



//below decoded signals indicate the address and bytecount processing of the submaster for which grant is given
addr_4k_align_max_mtu addr_4k_align_max_mtu_wr(
.clk(clk),
.resetn(resetn),
.submaster_rd_grant_0(ip_rd_grant_DDR3),
.submaster_wr_grant_0(ip_wr_grant_DDR3),
.submaster_rd_grant_1(ip_rd_grant_FLASH_NAND),
.submaster_wr_grant_1(ip_wr_grant_FLASH_NAND),
.submaster_rd_grant_2(ip_rd_grant_FLASH_NOR),
.submaster_wr_grant_2(ip_wr_grant_FLASH_NOR),
.submaster_rd_grant_3(ip_rd_grant_DMA),
.submaster_wr_grant_3(ip_wr_grant_DMA),
.submaster_rd_grant_4(ip_rd_grant_PCIe),
.submaster_wr_grant_4(ip_wr_grant_PCIe),
.submaster_rd_grant_5(ip_rd_grant_ETHERNET),
.submaster_wr_grant_5(ip_wr_grant_ETHERNET),
.submaster_rd_grant_6(ip_rd_grant_I2C),
.submaster_wr_grant_6(ip_wr_grant_I2C),
.submaster_rd_grant_7(ip_rd_grant_SPI),
.submaster_wr_grant_7(ip_wr_grant_SPI),


.process_address_decoding(decoded_ip_wr_grant),//this signal ..next decoding should start after acknowledgement...when no conversion is required(), state should move immediately
.address_decoding_done(),//assert this signal immediately if no conversion is required
.addrin(decoded_wraddress_in),
.total_bytes(decoded_wrbytecount_in),
.ram4k_wr(ram4k_wr_waddr_mem),
.ram4k_wrdata(ram4k_wrdata_waddr_mem)//[31:0]addr(),remaining will be bytes
);
//below decoded signals indicate the address and bytecount processing of the submaster for which grant is given
addr_4k_align_max_mtu addr_4k_align_max_mtu_rd(
.clk(clk),
.resetn(resetn),
.submaster_rd_grant_0(ip_rd_grant_DDR3),
.submaster_wr_grant_0(ip_wr_grant_DDR3),
.submaster_rd_grant_1(ip_rd_grant_FLASH_NAND),
.submaster_wr_grant_1(ip_wr_grant_FLASH_NAND),
.submaster_rd_grant_2(ip_rd_grant_FLASH_NOR),
.submaster_wr_grant_2(ip_wr_grant_FLASH_NOR),
.submaster_rd_grant_3(ip_rd_grant_DMA),
.submaster_wr_grant_3(ip_wr_grant_DMA),
.submaster_rd_grant_4(ip_rd_grant_PCIe),
.submaster_wr_grant_4(ip_wr_grant_PCIe),
.submaster_rd_grant_5(ip_rd_grant_ETHERNET),
.submaster_wr_grant_5(ip_wr_grant_ETHERNET),
.submaster_rd_grant_6(ip_rd_grant_I2C),
.submaster_wr_grant_6(ip_wr_grant_I2C),
.submaster_rd_grant_7(ip_rd_grant_SPI),
.submaster_wr_grant_7(ip_wr_grant_SPI),



.process_address_decoding(decoded_ip_rd_grant),//this signal ..next decoding should start after acknowledgement...when no conversion is required(), state should move immediately
.address_decoding_done(),//assert this signal immediately if no conversion is required
.addrin(decoded_rdaddress_in),
.total_bytes(decoded_rdbytecount_in),
.ram4k_wr(ram4k_wr_raddr_mem),
.ram4k_wrdata(ram4k_wrdata_raddr_mem)//[63:0]addr(),remaining will be bytes
);
/*
axi_converter rd_axi_converter(
.clk(clk),
.resetn(resetn),
.fifo_empty(empty_raddr_mem),//this is 4K address fifo empty signal which has 4K aligned address and bytecounts
.ram4k_rddata(dataout_raddr_mem),

.ram_4k_rd(rd_raddr_mem),
.ram_axi_conv_wr(ram_axi_conv_wr_rd_converter),
.ram_wrdata(ram_wrdata_rd_converter)//axi_asize(),axi_alen(),axi_id(),axi_addr_out
);
*/

wr_axi_converter rd_axi_converter(
.clk(clk),
.resetn(resetn),
.rd_converter(1),
.xfer_done(),
.fifo_empty(empty_raddr_mem),//this is 4K address fifo empty signal which has 4K aligned address and bytecounts
.ram4k_rdata(dataout_raddr_mem),

.ram_4k_rd(rd_raddr_mem),
.awid(arid),
.awaddr(araddr),
.awlen(arlen),
.awsize(arsize),
.awburst(arburst),
.awlock(arlock),
.awcache(arcache),
.awprot(arprot),
.awqos(arqos),
.awregion(arregion),
.awuser(aruser),
.awvalid(arvalid), // let try by replacing ax with aw 
.awready(arready), 



//wr data channel
.wid(),
.wdata(),
.wstrb(),
.wlast(),
.wuser(),
.wvalid(),
.wready(0),

//wr response channel
.bid('d0),
.bresp('d0),
.buser('d0),
.bvalid('d0),
.bready(),


//Submaster wrdata
.rd_submaster_wrfifo(),
.ip_data(),

//for axi read
.rd_transfifo_wr(rd_transfifo_wr_rd),
.io_transfifo_wdata(io_transfifo_wrdata_rd)
);



wr_axi_converter wr_axi_converter(
.clk(clk),
.resetn(resetn),

.rd_converter(0),
.xfer_done(xfer_done),
.fifo_empty(empty_waddr_mem),//this is 4K address fifo empty signal which has 4K aligned address and bytecounts
.ram4k_rdata(dataout_waddr_mem),

.ram_4k_rd(wr_raddr_mem),
.awid(awid),
.awaddr(awaddr),
.awlen(awlen),
.awsize(awsize),
.awburst(awburst),
.awlock(awlock),
.awcache(awcache),
.awprot(awprot),
.awqos(awqos),
.awregion(awregion),
.awuser(awuser),
.awvalid(awvalid),
.awready(awready),



//wr data channel
.wid(wid),
.wdata(wdata),
.wstrb(wstrb),
.wlast(wlast),
.wuser(wuser),
.wvalid(wvalid),
.wready(wready),

//wr response channel
.bid(bid),
.bresp(bresp),
.buser(buser),
//.bvalid(bvalid),
.bvalid(bvalid),
.bready(bready),

 
//Submaster wrdata
.rd_submaster_wrfifo(rd_submaster_wrfifo),
.ip_data(ip_data)
);

rd_channel rd_channel(
.clk(clk),
.resetn(resetn),

.rvalid(rvalid),
.rid(rid),
.rdata(rdata),
.resp(rresp),
.rlast(rlast), 
.ready(rready),
.ip_fifo_wrdata(rdfifo_wrdata),
.ip_fifo_wr_0(rdfifo_wr0),
.axi_rd_err_0(axi_rd_err_0),
.xfer_done_0(rd_xfer_done_0),

.ip_fifo_wr_1(rdfifo_wr1),
.axi_rd_err_1(axi_rd_err_1),
.xfer_done_1(rd_xfer_done_1),

.ip_fifo_wr_2(rdfifo_wr2),
.axi_rd_err_2(axi_rd_err_2),
.xfer_done_2(rd_xfer_done_2),

.ip_fifo_wr_3(rdfifo_wr3),
.axi_rd_err_3(axi_rd_err_3),
.xfer_done_3(rd_xfer_done_3),

.ip_fifo_wr_4(rdfifo_wr4),
.axi_rd_err_4(axi_rd_err_4),
.xfer_done_4(rd_xfer_done_4),

.ip_fifo_wr_5(rdfifo_wr5),
.axi_rd_err_5(axi_rd_err_5),
.xfer_done_5(rd_xfer_done_5),

.ip_fifo_wr_6(rdfifo_wr6),
.axi_rd_err_6(axi_rd_err_6),
.xfer_done_6(rd_xfer_done_6),

.ip_fifo_wr_7(rdfifo_wr7),
.axi_rd_err_7(axi_rd_err_7),
.xfer_done_7(rd_xfer_done_7),

.fifo_rd_0(addrtrans_mem_rd_rd_0),//to read axi converted fifo
.fifo_empty_0(addrtrans_fifo_empty_rd0),//axi converter fifo status
.axi_conv_fifo_rddata_0(axi_conv_fifo_rddata_0),
.fifo_rd_1(addrtrans_mem_rd_rd_1),//to read axi converted fifo
.fifo_empty_1(addrtrans_fifo_empty_rd1),//axi converter fifo status
.axi_conv_fifo_rddata_1(axi_conv_fifo_rddata_1),
.fifo_rd_2(addrtrans_mem_rd_rd_2),//to read axi converted fifo
.fifo_empty_2(addrtrans_fifo_empty_rd2),//axi converter fifo status
.axi_conv_fifo_rddata_2(axi_conv_fifo_rddata_2),
.fifo_rd_3(addrtrans_mem_rd_rd_3),//to read axi converted fifo
.fifo_empty_3(addrtrans_fifo_empty_rd3),//axi converter fifo status
.axi_conv_fifo_rddata_3(axi_conv_fifo_rddata_3),
.fifo_rd_4(addrtrans_mem_rd_rd_4),//to read axi converted fifo
.fifo_empty_4(addrtrans_fifo_empty_rd4),//axi converter fifo status
.axi_conv_fifo_rddata_4(axi_conv_fifo_rddata_4),
.fifo_rd_5(addrtrans_mem_rd_rd_5),//to read axi converted fifo
.fifo_empty_5(addrtrans_fifo_empty_rd5),//axi converter fifo status
.axi_conv_fifo_rddata_5(axi_conv_fifo_rddata_5),
.fifo_rd_6(addrtrans_mem_rd_rd_6),//to read axi converted fifo
.fifo_empty_6(addrtrans_fifo_empty_rd6),//axi converter fifo status
.axi_conv_fifo_rddata_6(axi_conv_fifo_rddata_6),
.fifo_rd_7(addrtrans_mem_rd_rd_7),//to read axi converted fifo
.fifo_empty_7(addrtrans_fifo_empty_rd7),//axi converter fifo status
.axi_conv_fifo_rddata_7(axi_conv_fifo_rddata_7),
.id_mismatch_err(),
.bytecount_mismatch()//tbd
);



assign wr_xfer_done0 = xfer_done & processing_submaster_DMA;
assign axi_wr_err0= bresp != 'd0;
assign wrfifo_rd0= rd_submaster_wrfifo & processing_submaster_DMA;
assign wr_xfer_done1 = xfer_done & processing_submaster_SPI;
assign axi_wr_err1= bresp != 'd0;
assign wrfifo_rd1= rd_submaster_wrfifo & processing_submaster_SPI;
assign wr_xfer_done2 = xfer_done & processing_submaster_I2C;
assign axi_wr_err2= bresp != 'd0;
assign wrfifo_rd2= rd_submaster_wrfifo & processing_submaster_I2C;
assign wr_xfer_done3 = xfer_done & processing_submaster_FLASH_NAND;
assign axi_wr_err3 = bresp != 'd0;
assign wrfifo_rd3 = rd_submaster_wrfifo & processing_submaster_FLASH_NAND;
assign wr_xfer_done4 = xfer_done & processing_submaster_FLASH_NOR;
assign axi_wr_err4= bresp != 'd0;
assign wrfifo_rd4= rd_submaster_wrfifo & processing_submaster_FLASH_NOR;
assign wr_xfer_done5 = xfer_done & processing_submaster_PCIe;
assign axi_wr_err5 = bresp != 'd0;
assign wrfifo_rd5 = rd_submaster_wrfifo & processing_submaster_PCIe;
assign wr_xfer_done6 = xfer_done & processing_submaster_ETHERNET;
assign axi_wr_err6= bresp != 'd0;
assign wrfifo_rd6= rd_submaster_wrfifo & processing_submaster_ETHERNET;
assign wr_xfer_done7 = xfer_done & processing_submaster_DDR3;
assign axi_wr_err7 = bresp != 'd0;
assign wrfifo_rd7 = rd_submaster_wrfifo & processing_submaster_DDR3;
assign ip_data = 

                 (processing_submaster_DDR3)?wrfifo_rddata0:
                 (processing_submaster_FLASH_NAND)?wrfifo_rddata1:
                 (processing_submaster_FLASH_NOR)?wrfifo_rddata2:
                 (processing_submaster_DMA)?wrfifo_rddata3:
                 (processing_submaster_PCIe)?wrfifo_rddata4:
                 (processing_submaster_ETHERNET)?wrfifo_rddata5:
                 (processing_submaster_I2C)?wrfifo_rddata6:                 
                 (processing_submaster_SPI)?wrfifo_rddata7:0;

submaster_wr_arb submaster_wr_arb(
.clk(clk),
.start_0(ip_wr_start0),
.grant_0(ip_wr_grant0),
.xfer_done0(wr_xfer_done0),
.processing_submaster_DDR3(processing_submaster_DDR3),
.start_1(ip_wr_start1),
.grant_1(ip_wr_grant1),
.xfer_done1(wr_xfer_done1),
.processing_submaster_FLASH_NAND(processing_submaster_FLASH_NAND),
.start_2(ip_wr_start2),
.grant_2(ip_wr_grant2),
.xfer_done2(wr_xfer_done2),
.processing_submaster_FLASH_NOR(processing_submaster_FLASH_NOR),
.start_3(ip_wr_start3),
.grant_3(ip_wr_grant3),
.xfer_done3(wr_xfer_done3),
.processing_submaster_DMA(processing_submaster_DMA),
.start_4(ip_wr_start4),
.grant_4(ip_wr_grant4),
.xfer_done4(wr_xfer_done4),
.processing_submaster_PCIe(processing_submaster_PCIe),
.start_5(ip_wr_start5),
.grant_5(ip_wr_grant5),
.xfer_done5(wr_xfer_done5),
.processing_submaster_ETHERNET(processing_submaster_ETHERNET),
.start_6(ip_wr_start6),
.grant_6(ip_wr_grant6),
.xfer_done6(wr_xfer_done6),
.processing_submaster_I2C(processing_submaster_I2C),
.start_7(ip_wr_start7),
.grant_7(ip_wr_grant7),
.xfer_done7(wr_xfer_done7),
.processing_submaster_SPI(processing_submaster_SPI),
.resetn(resetn)
);
submaster_rd_arb submaster_rd_arb(
.clk(clk),

.start_0(ip_rd_start0),
.grant_0(ip_rd_grant0),
.xfer_done0(rd_xfer_done0),
.processing_submaster_DDR3(),
.start_1(ip_rd_start1),
.grant_1(ip_rd_grant1),
.xfer_done1(rd_xfer_done1),
.processing_submaster_FLASH_NAND(),
.start_2(ip_rd_start2),
.grant_2(ip_rd_grant2),
.xfer_done2(rd_xfer_done2),
.processing_submaster_FLASH_NOR(),
.start_3(ip_rd_start3),
.grant_3(ip_rd_grant3),
.xfer_done3(rd_xfer_done3),
.processing_submaster_DMA(),
.start_4(ip_rd_start4 ),
.grant_4(ip_rd_grant4),
.xfer_done4(rd_xfer_done4),
.processing_submaster_PCIe(),
.start_5(ip_rd_start5),
.grant_5(ip_rd_grant5),
.xfer_done5(rd_xfer_done5),
.processing_submaster_ETHERNET(),
.start_6(ip_rd_start6),
.grant_6(ip_rd_grant6),
.xfer_done6(rd_xfer_done6),
.processing_submaster_I2C(),
.start_7(ip_rd_start7 ),
.grant_7(ip_rd_grant7),
.xfer_done7(rd_xfer_done7),
.processing_submaster_SPI(),
.resetn(resetn)
);

//include all RAM here itself
//below 2rams take input from 4k_aligned block and provides to convertor block to be converted to asize,alen,etc
mem_with_controller #(7,3,97) axi_waddr_mem

(
.clk(clk),
.resetn(resetn),
.wr(ram4k_wr_waddr_mem),
.rd(wr_raddr_mem),
.empty(empty_waddr_mem),
.datain(ram4k_wrdata_waddr_mem),
.dataout(dataout_waddr_mem)
);

mem_with_controller #(7,3,97) axi_raddr_mem(
.clk(clk),
.resetn(resetn),
.wr(ram4k_wr_raddr_mem),
.rd(rd_raddr_mem),
.empty(empty_raddr_mem),
.datain(ram4k_wrdata_raddr_mem),
.dataout(dataout_raddr_mem)
);


//below 2 rams take input from convertor module and provides to axi_rd_wr module to drive the address phase of signals to AXI slave 
mem_with_controller #(7,3,97) axi_conv_rd_mem(
.clk(clk),
.resetn(resetn),
.wr(ram_axi_conv_wr_rd_converter),
.rd(addrtrans_mem_rd_rd),
.empty(addrtrans_fifo_empty_rd),
.datain(ram_wrdata_rd_converter),
.dataout(addrtrans_mem_rddata_rd)
);


//below 2 ram s take address phase issued by DUT from axi_rd_wr and provide to rd_channel and wr_channel to perform read and write transactions..this will be based on id

assign acc_rd_ram0= arvalid & arready & arid == 0;
assign addrtrans_fifo_empty_rd0=addrtrans_fifo_empty_rd & current_rid_in_process == 0;

mem_with_controller #(7,3,97)axi_rchanel_mem_0(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram0),
.rd(addrtrans_mem_rd_rd_0),
.empty(addrtrans_fifo_empty_rd_0),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_0),
.dataout(axi_conv_fifo_rddata_0)
);
assign acc_rd_ram1= arvalid & arready & arid == 1;
assign addrtrans_fifo_empty_rd1=addrtrans_fifo_empty_rd & current_rid_in_process == 1;

mem_with_controller #(7,3,97)axi_rchanel_mem_1(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram1),
.rd(addrtrans_mem_rd_rd_1),
.empty(addrtrans_fifo_empty_rd_1),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_1),
.dataout(axi_conv_fifo_rddata_1)
);
assign acc_rd_ram2= arvalid & arready & arid == 2;
assign addrtrans_fifo_empty_rd2=addrtrans_fifo_empty_rd & current_rid_in_process == 2;

mem_with_controller #(7,3,97)axi_rchanel_mem_2(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram2),
.rd(addrtrans_mem_rd_rd_2),
.empty(addrtrans_fifo_empty_rd_2),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_2),
.dataout(axi_conv_fifo_rddata_2)
);
assign acc_rd_ram3= arvalid & arready & arid == 3;
assign addrtrans_fifo_empty_rd3=addrtrans_fifo_empty_rd & current_rid_in_process == 3;

mem_with_controller #(7,3,97)axi_rchanel_mem_3(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram3),
.rd(addrtrans_mem_rd_rd_3),
.empty(addrtrans_fifo_empty_rd_3),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_3),
.dataout(axi_conv_fifo_rddata_3)
);
assign acc_rd_ram4= arvalid & arready & arid == 4;
assign addrtrans_fifo_empty_rd4=addrtrans_fifo_empty_rd & current_rid_in_process == 4;

mem_with_controller #(7,3,97)axi_rchanel_mem_4(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram4),
.rd(addrtrans_mem_rd_rd_4),
.empty(addrtrans_fifo_empty_rd_4),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_4),
.dataout(axi_conv_fifo_rddata_4)
);
assign acc_rd_ram5= arvalid & arready & arid == 5;
assign addrtrans_fifo_empty_rd5=addrtrans_fifo_empty_rd & current_rid_in_process == 5;

mem_with_controller #(7,3,97)axi_rchanel_mem_5(
.clk(clk),
.resetn(resetn), 
.wr(rd_transfifo_wr_rd & acc_rd_ram5),
.rd(addrtrans_mem_rd_rd_5),
.empty(addrtrans_fifo_empty_rd_5),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_5),
.dataout(axi_conv_fifo_rddata_5)
);
assign acc_rd_ram6= arvalid & arready & arid == 6;
assign addrtrans_fifo_empty_rd6=addrtrans_fifo_empty_rd & current_rid_in_process == 6;

mem_with_controller #(7,3,97)axi_rchanel_mem_6(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram6),
.rd(addrtrans_mem_rd_rd_6),
.empty(addrtrans_fifo_empty_rd_6),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_6),
.dataout(axi_conv_fifo_rddata_6)
);
assign acc_rd_ram7= arvalid & arready & arid == 7;
assign addrtrans_fifo_empty_rd7=addrtrans_fifo_empty_rd & current_rid_in_process == 7;

mem_with_controller #(7,3,97)axi_rchanel_mem_7(
.clk(clk),
.resetn(resetn),
.wr(rd_transfifo_wr_rd & acc_rd_ram7),
.rd(addrtrans_mem_rd_rd_7),
.empty(addrtrans_fifo_empty_rd_7),
.datain(io_transfifo_wrdata_rd),// & acc_rd_ram_7),
.dataout(axi_conv_fifo_rddata_7)
);
//to do ..use different IDs for Read and write ID width
endmodule
