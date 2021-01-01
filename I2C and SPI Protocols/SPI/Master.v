module Master(qw,scl,mosi,miso,ss1,ss2,sel);
input qw;
output reg scl;
input miso;
output reg [0:0]mosi;
output reg ss1;
output reg ss2;
output reg [1:0] sel;
reg [16:0]xx;
initial begin
scl = 0;
ss1 = 1;
ss2 = 1;
#10 ss1 = 0;
sel = 0;
xx = 17'b011101001_00011001;
#100 ss2 = 0;
xx = 17'b010101011_00011001;
ss1 = 1;
sel = 1;
end
always @(negedge ss1 or negedge ss2)
slock ;
always @(posedge scl)begin
mosi = xx[16];
xx = xx<<1;
end
task slock;
repeat (38)
#2 scl = !scl;
endtask: slock;
endmodule
