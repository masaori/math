#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim(none)[
  $forall a, b in CC$ について、

  $
    T_((V_1^((plus.minus)))^(1/2))(a dot.op hat(Z)_mu^((minus)) + b dot.op hat(Y)_mu)
    &=
    a dot.op T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus))) + b dot.op T_((V_1^((plus.minus)))^(1/2))(hat(Y)_mu)
    \
    &=
    mat(
      T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus))),
      T_((V_1^((plus.minus)))^(1/2))(hat(Y)_mu)
    )
    mat(
      a;
      b;
    )
    \
    T_((V_2))(a dot.op hat(Z)_mu^((minus)) + b dot.op hat(Y)_mu)
    &=
    a dot.op T_((V_2))(hat(Z)_mu^((minus))) + b dot.op T_((V_2))(hat(Y)_mu)
    \
    &=
    mat(
      T_((V_2))(hat(Z)_mu^((minus))),
      T_((V_2))(hat(Y)_mu)
    )
    mat(
      a;
      b;
    )
  $

  #proof[
    表式より、それぞれただの1次関数なので
  ]
]<linearity_of_T>
