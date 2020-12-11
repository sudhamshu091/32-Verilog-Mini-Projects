module booth_algorithm_tb;
reg clk, start;
reg [7:0] a, b;
wire [15:0] ab;
wire busy;
booth_algorithm mult(ab, busy, a, b, clk, start);
initial begin
clk = 0;
$display("first example: a = 3 b = 17");
a = 3; b = 17; start = 1; #50 start = 0;
#80 $display("first example done");
$display("second example: a = 7 b = 7");
a = 7; b = 7; start = 1; #50 start = 0;
#80 $display("second example done");
$finish;
end
always #5 clk = !clk;
always @(posedge clk) $strobe("ab: %d busy: %d at time=%t", ab, busy,
$stime);
endmodule
