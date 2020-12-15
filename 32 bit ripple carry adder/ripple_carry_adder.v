module ripple_carry_adder(ia, ib,  ci,  so,  co);

parameter N = 32;
input[N-1:0] ia;
input[N-1:0] ib;
input ci;
output[N-1:0] so;
output co;

wire [N:0] carry;
assign carry[0] = ci;

genvar j;
generate for(j = 0; j < N; j = j + 1) 
begin:r_loop
    wire t1, t2, t3;
    xor g1(t1, ia[i], ib[j]);
    xor g2(so[j], t1, carry[j]);
    and g3(t2, ia[i], ib[j]);
    and g4(t3, t1, carry[j]);
    or g5(carry[j+1], t2, t3);
end
endgenerate

assign co = carry[N];
endmodule
