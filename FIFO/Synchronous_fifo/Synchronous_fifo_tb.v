module tb;
'timescale 1ns/ps
logic clock, rd_en, wr_en, full, empty, rst;
logic [15 : 0] dout, din;

sync_fifo fifo(
  .clock(clock),
  .rst(rst),
  .empty(empty),
  .full(full),
  .wr_en(wr_en),
  .rd_en(rd_en)
  .din(din),
  .dout(dout)
);

assign #5 clock = !clock; 
always@(posedge clock)
  #1 din = $random;
  end
  
initial 
begin
clock = 0;
reset = 1;
din = 16'h0;
wr_en = 0;
rd_en = 0;

#100 reset = 0;
#10 wr_en = 1;
#250 wr_en = 0;

#10 rd_en = 1;

#1000 $finish;

end 
endmodule
