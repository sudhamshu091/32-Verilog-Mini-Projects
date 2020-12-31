module qadd #(
	//Parameterized values
	parameter Q = 15,
	parameter N = 32
	)
	(
    input [N-1:0] a,
    input [N-1:0] b,
    output [N-1:0] c
    );

reg [N-1:0] res;

assign c = res;

always @(a,b) begin
	// both negative or both positive
	if(a[N-1] == b[N-1]) begin						//	Since they have the same sign, absolute magnitude increases
		res[N-2:0] = a[N-2:0] + b[N-2:0];		//		So we just add the two numbers
		res[N-1] = a[N-1];							//		and set the sign appropriately...  Doesn't matter which one we use, 
															//		they both have the same sign
															//	Do the sign last, on the off-chance there was an overflow...  
		end												//		Not doing any error checking on this...
	//	one of them is negative...
	else if(a[N-1] == 0 && b[N-1] == 1) begin		//	subtract a-b
		if( a[N-2:0] > b[N-2:0] ) begin					//	if a is greater than b,
			res[N-2:0] = a[N-2:0] - b[N-2:0];			//		then just subtract b from a
			res[N-1] = 0;										//		and manually set the sign to positive
			end
		else begin												//	if a is less than b,
			res[N-2:0] = b[N-2:0] - a[N-2:0];			//		we'll actually subtract a from b to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
		end
	else begin												//	subtract b-a (a negative, b positive)
		if( a[N-2:0] > b[N-2:0] ) begin					//	if a is greater than b,
			res[N-2:0] = a[N-2:0] - b[N-2:0];			//		we'll actually subtract b from a to avoid a 2's complement answer
			if (res[N-2:0] == 0)
				res[N-1] = 0;										//		I don't like negative zero....
			else
				res[N-1] = 1;										//		and manually set the sign to negative
			end
		else begin												//	if a is less than b,
			res[N-2:0] = b[N-2:0] - a[N-2:0];			//		then just subtract a from b
			res[N-1] = 0;										//		and manually set the sign to positive
			end
		end
	end
endmodule
module Test_add;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;

	// Outputs
	wire [31:0] c;

	// Instantiate the Unit Under Test (UUT)
	qadd #(19,32) uut (
		.a(a), 
		.b(b), 
		.c(c)
	);

	//	These are to monitor the values...
	wire	[30:0]	c_out;
	wire	[30:0]	a_in;
	wire	[30:0]	b_in;
	wire				a_sign;
	wire				b_sign;
	wire				c_sign;
	
	
	assign	a_in = a[30:0];
	assign	b_in = b[30:0];
	assign	c_out = c[30:0];
	assign	a_sign = a[31];
	assign	b_sign = b[31];
	assign	c_sign = c[31];
	
	
	initial begin
		// Initialize Inputs
		a[30:0] = 0;
		a[31] = 0;
		b[31] = 1;
		b[30:0] = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		forever begin
			#1 a = a+5179347;			//	why not?
			a[31] = 0;					//	a is negative...
			b[31] = 1;
			
			
			if (a[30:0] > 2.1E9)			//	input will always be "positive"
				begin
					a = 0;
					b[31] = 1;				//	b is negative...
					b[30:0] = b[30:0] + 3779351;
				end
		end

	end
      
endmodule
