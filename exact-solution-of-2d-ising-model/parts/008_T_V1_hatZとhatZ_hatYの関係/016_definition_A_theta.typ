#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition($A(theta)$)[
  
  $theta in CC$ について $A(theta) in "Mat"(2, CC)$ を、

  $
    A(theta)
    :&=
    mat(
      c_1 c_2^*
      -
      s_1 s_2^* cos theta,
      sqrt(-1) e^(sqrt(-1) theta) s_2^* (c_1 cos theta - i sin theta - s_1 c_2);
      - sqrt(-1) e^(-sqrt(-1) theta) s_2^* (c_1 cos theta + i sin theta - s_1 c_2),
      c_1 c_2^*
      -
      s_1 s_2^* cos theta;
    )
    \
    &=
    mat(
      cosh(2 K_1) cosh(2 K_2^(*))
      -
      sinh(2 K_1) sinh(2 K_2^(*)) cos(((2 pi mu) / M)),
      sqrt(-1) exp(sqrt(-1) ((2 pi mu) / M))
      sinh(2 K_2^(*)) (cosh(2 K_1) cos(((2 pi mu) / M)) - sqrt(-1) sin(((2 pi mu) / M)) - sinh(2 K_1) cosh(2 K_2));
      - sqrt(-1) exp(- sqrt(-1)((2 pi mu) / M))
      sinh(2 K_2^(*)) (cosh(2 K_1) cos(((2 pi mu) / M)) + sqrt(-1) sin(((2 pi mu) / M)) - sinh(2 K_1) cosh(2 K_2)),
      cosh(2 K_1) cosh(2 K_2^(*))
      -
      sinh(2 K_1) sinh(2 K_2^(*)) cos(((2 pi mu) / M));
    )
  $

  と定める。
]<def_A_theta>
