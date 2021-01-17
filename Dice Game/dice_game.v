
module DiceGame (Rb,Reset, CLK, Sum, Roll, Win, Lose);
 input Rb; 
 input Reset; 
 input CLK;
input[3:0] Sum; 
 output Roll; 
 output Win; 
 output Lose; 
 reg Roll;
 reg Win;
 reg Lose;
 
 reg[2:0] State; 
 reg[2:0] Nextstate; 
 reg[3:0] Point; 
 reg Sp; 
 initial
 begin
 State = 0;
 Nextstate = 0;
 Point = 2;
 end
 always @(Rb or Reset or Sum or State)
 begin
 Sp = 1'b0; 
 Roll = 1'b0; 
 Win = 1'b0; 
 Lose = 1'b0; 
 Nextstate = 0;
 case (State)
 0 :
 begin
 if (Rb == 1'b1) begin
 Nextstate = 1; 
 end
 end
 1 :
 begin
 if (Rb == 1'b1) begin
 Roll = 1'b1; 
 end
else if (Sum == 7 | Sum == 11) begin
 Nextstate = 2; 
 end
else if (Sum == 2 | Sum == 3 | Sum == 12) begin
 Nextstate = 3; 
 end
else begin
 Sp = 1'b1; 
 Nextstate = 4; 
 end
 end
2 :
 begin
 Win = 1'b1; 
 if (Reset == 1'b1) begin
 Nextstate = 0; 
 end
 end
 3 :
 begin
 Lose = 1'b1; 
 if (Reset == 1'b1) begin
 Nextstate = 0; 
 end
 end
 4 :
 begin
 if (Rb == 1'b1) begin
 Nextstate = 5; 
 end
 end
 5 :
 begin
 if (Rb == 1'b1) begin
 Roll = 1'b1; 
 end
else if (Sum == Point) begin
 Nextstate = 2; 
 end
else if (Sum == 7) begin
 Nextstate = 3; 
 end
 else begin
 Nextstate = 4; 
 end
 end
default :
 begin
 Nextstate = 0; 
 
 end
 endcase
 end
 always @(posedge CLK)
 begin
 State <= Nextstate; 
 if (Sp == 1'b1) begin
 Point <= Sum; 
 end 
 end
endmodule

module GameTest (Rb, Reset, Sum, CLK, Roll, Win, Lose);
 output Rb; 
 output Reset; 
 output[3:0] Sum; 
 input CLK; 
 input Roll; 
 input Win; 
 input Lose; 
 reg[3:0] Sum;
 reg Reset;
 reg Rb;
 reg[1:0] Tstate; 
 reg[1:0] Tnext; 
 reg Trig1; 
 integer Sumarray[0:11]; 
 integer i; 
 initial
 begin
 Sumarray[0] = 7;
 Sumarray[1] = 11;
Sumarray[2] = 2;
 Sumarray[3] = 4;
 Sumarray[4] = 7;
 Sumarray[5] = 5;
 Sumarray[6] = 6;
 Sumarray[7] = 7;
 Sumarray[8] = 6;
 Sumarray[9] = 8;
 Sumarray[10] = 9;
 Sumarray[11] = 6;
 i = 0;
 Tstate = 0;
 Tnext = 0;
 Trig1 = 0;
 end
 always @(Roll or Win or Lose or Tstate)
 begin
 case (Tstate)
 0 :
 begin
 Rb = 1'b1; 
 Reset = 1'b0; 
 if (i >= 12) begin
 Tnext = 3; 
 end
else if (Roll == 1'b1) begin
 Sum = Sumarray[i]; 
 i = i + 1; 
 Tnext = 1; 
 end
 end
 1 :
 begin
 Rb = 1'b0; 
 Tnext = 2; 
 end
 2 :
 begin
 Tnext = 0; 
 Trig1 = ~Trig1; 
 if ((Win || Lose) == 1'b1) begin
 Reset = 1'b1; 
 end
 end
 3 :
 begin
end
 endcase
 end
 always @(posedge CLK)
begin
 Tstate <= Tnext; 
 end
endmodule

