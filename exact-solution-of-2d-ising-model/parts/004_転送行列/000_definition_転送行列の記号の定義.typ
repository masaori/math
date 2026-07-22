#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition("記号の定義")[
- $I_("Mat"(2, CC))$: $"Mat"(2, CC)$上の単位行列
- $sigma_k^x := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^x,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
- $sigma_k^y := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^y,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
- $sigma_k^z := I_("Mat"(2, CC)) times.o dots.c times.o overbrace(sigma^z,k"th") times.o dots.c times.o I_("Mat"(2, CC)) in "Mat"(2, CC)^(times.o M)$
- $I_(("Mat"(2, CC))^(times.o M))$ := $I_("Mat"(2, CC)) times.o dots.c times.o I_("Mat"(2, CC))$
- $V_1 := exp (sqrt(-1) K_1 dot.op (sigma_1^z sigma_2^z + sigma_2^z sigma_3^z + dots.c + sigma_M^z sigma_1^z)) in "Mat"(2, CC)^(times.o M)$
- $V_2 := (2 sinh 2K_2)^(M/2) exp (K_2^* dot.op (sigma_1^x + sigma_2^x + dots.c + sigma_M^x)) in "Mat"(2, CC)^(times.o M)$

- $Z_m := sigma_1^x dots.c sigma_(m-1)^x sigma_m^z in "Mat"(2, CC)^(times.o M) quad "ただし、" Z_1 := sigma_1^z quad ("ホロノミック量子場では" p_m)$

正し、$Z_(M+1) := Z_1$

- $Y_m := sigma_1^x dots.c sigma_(m-1)^x sigma_m^y in "Mat"(2, CC)^(times.o M) quad "ただし、" Y_1 := sigma_1^y quad ("ホロノミック量子場では" q_m)$

正し、$Y_(M+1) := Y_1$

- $epsilon := sigma_1^x dots.c sigma_M^x = (sqrt(-1))^M Z_1 Y_1 + dots.c + Z_M Y_M in "Mat"(2, CC)^(times.o M)$

- $K_1^* := -1/2 log(tanh K_1) arrow.l.r sinh(2 K_1) sinh(2 K_1^*) = 1$
- $K_2^* := -1/2 log(tanh K_2) arrow.l.r sinh(2 K_2) sinh(2 K_2^*) = 1$
- $c_i := cosh 2K_i, quad s_i := sinh 2K_i,$
- $c_i^* := cosh 2K_i^*, quad s_i^* := sinh 2K_i^*$

$K_i, K_i^* > 0$ より、 $c_i, s_i, c_i^*, s_i^* > 0$
]<def_transfer_matrix_symbols>
