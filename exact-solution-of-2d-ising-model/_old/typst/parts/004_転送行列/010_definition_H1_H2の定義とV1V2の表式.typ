#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition(none)[
  $
  H_1^((plus.minus)) :&= Y_1 Z_2 + Y_2 Z_3 + dots.c + Y_(M-1) Z_M minus.plus Y_M Z_1 \
  H_2 :&= Z_1 Y_1 + Z_2 Y_2 + dots.c + Z_M Y_M
  $
]

よって、
$
V_1^((plus.minus)) &= exp(sqrt(-1) K_1 dot.op H_1^((plus.minus)))
\
V_2 &= (2s_2)^(M/2)exp(sqrt(-1) K_2^* dot.op H_2)
$
