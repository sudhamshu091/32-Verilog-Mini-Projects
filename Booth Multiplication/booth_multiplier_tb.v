`timescale 1ns / 1ps

module booth_algorithm_tb;

	reg [15:0] X;
	reg [15:0] Y;
	reg en;

	wire [31:0] Z;
	booth uut (
		.X(X), 
		.Y(Y), 
		.Z(Z), 
		.en(en)
	);

	initial begin
		X = 15;
		Y = 16;
		en = 1;

		#100 $finish;

	end
      
endmodule
