`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:49:51 04/04/2016 
// Design Name: 
// Module Name:    Mux_8_to_1 
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
module Mux_8_to_1(Mux_Out , S , in0 , in1 , in2 , in3 , in4 , in5 , in6 , in7);

output reg Mux_Out;
input [2:0] S;
input in0 , in1 , in2 , in3 , in4 , in5 , in6 , in7;

always@(*)
begin
	case(S)
		
		3'b000 : Mux_Out = in0;
		3'b001 : Mux_Out = in1;
		3'b010 : Mux_Out = in2;
		3'b011 : Mux_Out = in3;
		3'b100 : Mux_Out = in4;
		3'b101 : Mux_Out = in5;
		3'b110 : Mux_Out = in6;
		3'b111 : Mux_Out = in7;
	endcase
end

endmodule
