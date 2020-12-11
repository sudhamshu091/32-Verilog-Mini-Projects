`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:30:50 04/04/2016 
// Design Name: 
// Module Name:    D_FlipFlop 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module D_FlipFlop(O , D , clk , clear);

input D , clk , clear;
output reg O;

always@(posedge clk , negedge clear)
begin
	
	if(clear == 1'b0)
		O <= 1'b0;
	else
		O <= D;
	
end
endmodule
