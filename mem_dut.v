module mem_dut(
input clk,
input resetn,
input rd,
input wr,
output empty,
input [511:0] wdata,
output [511:0] rdata
);
integer i;
reg [63:0] waddr;
reg [63:0] raddr;
reg [511:0] mem[2**32 - 1:0];
assign rdata= mem[raddr];
assign empty = waddr==raddr;
always@(posedge clk or negedge resetn)
  if(!resetn)
   begin
     for(i=0;i<512;i=i+1)
        mem[i]=0;
   end
  else if(wr)
    mem[waddr]=wdata;

always@(posedge clk or negedge resetn)
 if(!resetn)
   raddr <= 1'b0;
 else if(rd)
   raddr <= raddr + 1;

always@(posedge clk or negedge resetn)
 if(!resetn)
   waddr <= 1'b0;
 else if(wr)
   waddr <= waddr + 1;

endmodule