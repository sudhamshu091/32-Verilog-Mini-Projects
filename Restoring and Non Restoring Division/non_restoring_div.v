module non_restoring_divider(dividend,divider,ready,quotient,remainder,sign,clk);
   input         clk;
   input         sign;
   input [31:0]  dividend, divider;
   output [31:0] quotient, remainder;
   output        ready;

   reg [31:0]    quotient, quotient_temp;
   reg [63:0]    dividend_copy, divider_copy, diff;
   reg           negative_output;
   
   wire [31:0]   remainder = (!negative_output) ?  dividend_copy[31:0] : ~dividend_copy[31:0] + 1'b1;

   reg [5:0]     bit; 
   wire          ready = !bit;

   initial bit = 0;
   initial negative_output = 0;

   always @( posedge clk ) 

     if( ready ) begin

        bit = 6'd32;
        quotient = 0;
        quotient_temp = 0;
        dividend_copy = (!sign || !dividend[31]) ? {32'd0,dividend} : {32'd0,~dividend + 1'b1};
        divider_copy = (!sign || !divider[31]) ? {1'b0,divider,31'd0} : {1'b0,~divider + 1'b1,31'd0};

        negative_output = sign && ((divider[31] && !dividend[31]) || (!divider[31] && dividend[31]));  
     end 
     else if ( bit > 0 ) begin

        diff = dividend_copy - divider_copy;

        quotient_temp = quotient_temp << 1;

        if( !diff[63] ) begin

           dividend_copy = diff;
           quotient_temp[0] = 1'd1;

        end

        quotient = (!negative_output) ? quotient_temp : ~quotient_temp + 1'b1;

        divider_copy = divider_copy >> 1;
        bit = bit - 1'b1;

     end
endmodule

module non_restoring_divider_tb;

	// Inputs
	reg [31:0] dividend;
	reg [31:0] divider;
	reg sign;
	reg clk;

	// Outputs
	wire ready;
	wire [31:0] quotient;
	wire [31:0] remainder;
	
	// Variables
	integer i ; 

	// Instantiate the Unit Under Test (UUT)
	non_restoring_divider uut (.ready(ready), .quotient(quotient), .remainder(remainder), .dividend(dividend), .divider(divider), .sign(sign), .clk(clk));

	initial begin
	//Check for unsigned division
	clk = 0;
	dividend = 32'd4;
	divider = 32'd2;
	sign = 0;
	for(i=0;i<66;i=i+1)
	begin
	clk = ~clk;
	#100;
	end
	
	//To check for signed division
	dividend = 32'd8;
	divider = 32'd2;
	sign = 1;
	for(i=0;i<66;i=i+1)
	begin
	clk = ~clk;
	#100;
	end
	
	//To check for remainder 
	dividend = 32'd16;
	divider = 32'd5;
	sign = 0;
	for(i=0;i<66;i=i+1)
	begin
	clk = ~clk;
	#100;
	end
	
	end
	    
endmodule
