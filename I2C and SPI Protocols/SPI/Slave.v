module Slave1(clk,miso,mosi,ss);
input clk;
input [0:0]mosi;
input ss;
output reg[0:0]miso;
reg [7:0] address,data;reg x1;
reg [7:0] arr [0:309];
reg k;
reg [6:0] i=0;
initial begin
arr[233]=185;
end
always @(mosi or ss)begin
if(i==0 && ss==0)begin
x1 <= mosi;
end
end
always @(posedge clk or mosi)begin
if(ss==0)begin

//******ADDRESS READ***//
if(i>0 && i<9)begin
address <= {address,mosi};
end

//******DATA READING****//
if(i>8 && i<17 && x1==1)begin
data <= {data,mosi};
end

//*********DATA SENDING TO MASTER MISO***//
else if(i>8 && i<17 && x1==0)begin
miso <= arr[address][7];
arr[address]<=arr[address]<<1;
end
if(i==17)
miso<=1'bz;

//******DATA RECEIVED WRITTEN IN TO THE ADDRESS***//
i<=i+1;
if(i>16 && x1==1)
arr[address]<=data;
end

end
endmodule
