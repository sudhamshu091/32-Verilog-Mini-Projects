`include "ripple_carry_adder.v"
`timescale 1ns/1ps
module ripple_carry_adder_tb;

parameter N = 32;

reg clk;
reg[N-1:0] a, b;
wire[N-1:0] sum;
reg cin;
wire cout;

ripple_carry_adder rca(.ia(a), .ib(b), .ci(cin), .so(sum), .co(cout));
initial begin
    #10;
    a = 0;
    b = 0;
    cin = 0;
    clk = 0;
    #10;
end

always @(posedge clk)
begin
    #50;
    #1 a <= $random() % 1000000;
    #1 b <= $random() % 1000000;
end

always @(a or b)
    #5 $display("%d + %d = %d", a, b, sum);

always #5 clk = ~clk;

endmodule
