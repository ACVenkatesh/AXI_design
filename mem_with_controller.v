module mem_with_controller
#(
parameter DEPTH=8,
parameter ADDR_WIDTH=64,
parameter DATA_WIDTH=512
)
(
input clk,
input resetn,
input wr,
input rd,
input [DATA_WIDTH-1:0] datain,
output [DATA_WIDTH-1:0] dataout,
output  empty
);

integer i;
reg [ADDR_WIDTH-1:0] awaddr;
reg [ADDR_WIDTH-1:0] araddr;
reg [DATA_WIDTH-1:0] mem[DEPTH-1:0];
assign dataout = mem[araddr];
assign empty=(!resetn)?1:(araddr == awaddr);
/*
always@(posedge clk or negedge resetn)
  if(!resetn)
    empty <= 1'b1;
  else if(araddr != awaddr)
    empty <= 1'b0;
  else
    empty <= 1'b1;
*/
always@(posedge clk or negedge resetn)
  if(!resetn)
    araddr <= 0;
  else if(rd)
    araddr <= araddr +1;


always@(posedge clk or negedge resetn)
  if(!resetn)
    awaddr <= 0;
  else if(wr)
    awaddr <= awaddr +1;

always@(posedge clk or negedge resetn)
  if(!resetn)
    for(i=0;i<DEPTH;i=i+1)
        mem[i] <= 0;
  else if(wr)
        mem[awaddr] <= datain;
        
  
endmodule