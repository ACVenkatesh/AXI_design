module addr_wdata_mux_m4(
input clk,
input reset_n,

// master 1
input   [31:0]  m00_axi_awaddr,
input    [3:0]  m00_axi_awid,
input    [1:0]  m00_axi_awburst,
input    [3:0]  m00_axi_awlen,
input    [2:0]  m00_axi_awsize,
input    [1:0]  m00_axi_awlock,
input    [3:0]  m00_axi_awcache,
input    [2:0]  m00_axi_awprot,
input           m00_axi_awvalid,
output       m00_axi_awready,
input    [3:0]  m00_axi_wid,
input   [31:0]  m00_axi_wdata,
input    [3:0]  m00_axi_wstrb,
input           m00_axi_wlast,
input           m00_axi_wvalid,
output   m00_axi_wready,


// slave
output   [31:0]  S_AXI_AWADDR,
output   [3:0]  S_AXI_AWID,
output   [1:0]  S_AXI_AWBURST,
output   [3:0]  S_AXI_AWLEN,
output   [2:0]  S_AXI_AWSIZE,
output   [1:0]  S_AXI_AWLOCK,
output   [3:0]  S_AXI_AWCACHE,
output    [2:0]  S_AXI_AWPROT,
output          S_AXI_AWVALID,
input       S_AXI_AWREADY,
output   [6:0]  S_AXI_WID,
output  [31:0]  S_AXI_WDATA,
output   [3:0]  S_AXI_WSTRB,
output          S_AXI_WLAST,
output          S_AXI_WVALID,
input           S_AXI_WREADY,

// select
input      [2:0]sel
);

reg      [2:0]  aw_port;   // select which slave we write to
reg      [2:0]  aw_state;  // write state

wire            adrs_end = S_AXI_AWVALID & S_AXI_AWREADY;
wire            data_end = S_AXI_WVALID & S_AXI_WREADY & S_AXI_WLAST;
wire            pass_adrs = (aw_state==3'b000) | (aw_state==3'b001);
wire            pass_data = (aw_state==3'b000) | (aw_state==3'b110);


// Address, data channel arbiter
always @ (posedge clk or negedge reset_n) begin 
   if (!reset_n) begin // reset
      aw_port  <= 3'b000;
      aw_state <= 3'b000;
   end else begin

      case (aw_state)
         3'b000 : begin    // no address or data passed
            case ({adrs_end,data_end})
              
               3'b001 : aw_state <= 3'b001; // data end
               3'b110 : begin // address end
                          // master 1
                          if (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) begin
                             aw_port  <= 3'b000;
                             aw_state <= 3'b110;
                          end
                         else; 
                        end
	         3'b111 : aw_state <= 3'b000; // both end
					   
                     default;
            endcase
        end
	

         3'b001 : begin  // data passed
                    if (adrs_end) aw_state <= 3'b000;
                    else;
                 end

         3'b110 : begin // address passed
                    if (data_end) aw_state <= 3'b000;
                    else;
                 end
         
	default;	
      endcase
   end 
end
// AW Mux
assign S_AXI_AWADDR  = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awaddr : 1'b0;
assign S_AXI_AWLEN   = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awlen : 1'b0;
assign S_AXI_AWSIZE  = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awsize : 1'b0;
assign S_AXI_AWID    = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? {2'b00,m00_axi_awid} : 1'b0;
assign S_AXI_AWBURST = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awburst : 1'b0;
assign S_AXI_AWCACHE = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awcache : 1'b0;
assign S_AXI_AWLOCK  = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awlock : 1'b0;
assign S_AXI_AWPROT  = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? m00_axi_awprot : 1'b0;
assign S_AXI_AWVALID  = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? (m00_axi_awvalid & pass_adrs) : 1'b0;
assign m00_axi_awready = (m00_axi_awvalid&(m00_axi_awaddr[12:10]==sel)) ? (S_AXI_AWREADY & pass_adrs) :  1'b0;

// Wdata mux
assign S_AXI_WDATA   = (aw_port==3'b000) ? m00_axi_wdata : 1'b0;
assign S_AXI_WSTRB   = (aw_port==3'b000) ? m00_axi_wstrb : 1'b0;
assign S_AXI_WLAST   = (aw_port==3'b000) ? m00_axi_wlast : 1'b0;
assign S_AXI_WID     = (aw_port==3'b000) ? m00_axi_wid : 1'b0;
assign S_AXI_WVALID  = (aw_state==3'b110) ? ((aw_port==3'b000) ? (m00_axi_wvalid & pass_data): 1'b0) : 1'b0;
assign m00_axi_wready = (aw_port==3'b000) ? (S_AXI_WREADY & pass_data) : 1'b0;

endmodule