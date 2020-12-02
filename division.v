// 32 bit Floating Point Divider based on IEEE-754 in verilog
module divider(input [31:0] a_op,input [31:0] b_op, output exception, output [31:0] result);
wire sign;
wire [7:0] shift;
wire [7:0] exp_a;
wire [31:0] divisor;
wire [31:0] op_a;
wire [31:0] Intermediate_X0;
wire [31:0] Iteration_X0;
wire [31:0] Iteration_X1;
wire [31:0] Iteration_X2;
wire [31:0] Iteration_X3;
wire [31:0] solution;

wire [31:0] denominator;
wire [31:0] op_change_a;

assign exception = (&a_op[30:23]) | (&b_op[30:23]);

assign sign = a_op[31] ^ b_op[31];

assign shift = 8'd126 - b_op[30:23];

assign divisor = {1'b0,8'd126,b_op[22:0]};

assign denominator = divisor;

assign exp_a = a_op[30:23] + shift;

assign op_a = {a_op[31],exp_a,a_op[22:0]};

assign op_change_a = op_a;

//32'hC00B_4B4B = (-37)/17

Multiplication x0(32'hC00B_4B4B,divisor,,,,Intermediate_X0);

//32'h4034_B4B5 = 48/17
Addition_Subtraction X0(Intermediate_X0,32'h4034_B4B5,1'b0,,Iteration_X0);

Iteration X1(Iteration_X0,divisor,Iteration_X1);

Iteration X2(Iteration_X1,divisor,Iteration_X2);

Iteration X3(Iteration_X2,divisor,Iteration_X3);

Multiplication END(Iteration_X3,operand_a,,,,solution);

assign result = {sign,solution[30:0]};

endmodule
