module qmult #(
	//Parameterized values
	parameter Q = 15,
	parameter N = 32
	)
	(
	 input			[N-1:0]	i_multiplicand,
	 input			[N-1:0]	i_multiplier,
	 output			[N-1:0]	o_result,
	 output	reg				ovr
	 );
	 
	 //	The underlying assumption, here, is that both fixed-point values are of the same length (N,Q)
	 //		Because of this, the results will be of length N+N = 2N bits....
	 //		This also simplifies the hand-back of results, as the binimal point 
	 //		will always be in the same location...
	
	reg [2*N-1:0]	r_result;		//	Multiplication by 2 values of N bits requires a 
											//		register that is N+N = 2N deep...
	reg [N-1:0]		r_RetVal;
	
//--------------------------------------------------------------------------------
	assign o_result = r_RetVal;	//	Only handing back the same number of bits as we received...
											//		with fixed point in same location...
	
//---------------------------------------------------------------------------------
	always @(i_multiplicand, i_multiplier)	begin						//	Do the multiply any time the inputs change
		r_result <= i_multiplicand[N-2:0] * i_multiplier[N-2:0];	//	Removing the sign bits from the multiply - that 
																					//		would introduce *big* errors	
		ovr <= 1'b0;															//	reset overflow flag to zero
		end
	
		//	This always block will throw a warning, as it uses a & b, but only acts on changes in result...
	always @(r_result) begin													//	Any time the result changes, we need to recompute the sign bit,
		r_RetVal[N-1] <= i_multiplicand[N-1] ^ i_multiplier[N-1];	//		which is the XOR of the input sign bits...  (you do the truth table...)
		r_RetVal[N-2:0] <= r_result[N-2+Q:Q];								//	And we also need to push the proper N bits of result up to 
																						//		the calling entity...
		if (r_result[2*N-2:N-1+Q] > 0)										// And finally, we need to check for an overflow
			ovr <= 1'b1;
		end

endmodule
module Test_mult;

	// Inputs
	reg [31:0] i_multiplicand;
	reg [31:0] i_multiplier;

	// Outputs
	wire [31:0] o_result;
	wire			ovr;
	
	// Instantiate the Unit Under Test (UUT)
	qmult #(19,32) uut (
		.i_multiplicand(i_multiplicand), 
		.i_multiplier(i_multiplier), 
		.o_result(o_result),
		.ovr(ovr)
	);

	initial begin
		$monitor ("%b,%b,%b,%b", i_multiplicand, i_multiplier, o_result, ovr);		//	Monitor the stuff we care about
		
		// Initialize Inputs
 		i_multiplicand = 32'b00000000000110010010000111111011;	//pi = 3.141592
		i_multiplicand[31] = 0;												//	i_multiplicand sign
		i_multiplier[31] = 0;												//	i_multiplier sign
		i_multiplier[30:0] = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#100 i_multiplier[0] = 1;		//	1.91E-6
  	end

	// Add stimulus here
	always begin
		#10 i_multiplier[30:0] = (i_multiplier[30:0] << 1) + 1;		//	Why not??
	end
      
endmodule
