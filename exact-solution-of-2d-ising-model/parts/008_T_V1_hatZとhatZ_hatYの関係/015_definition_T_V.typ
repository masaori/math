#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition($T_((V))$)[
  $forall X in "Mat"(2, CC)^(times.o M)$について
  $
    T_((V))(X)
    :=
    T_((V_1^((plus.minus)))^(1/2))(
      T_((V_2))(
        T_((V_1^((plus.minus)))^(1/2))(
          X
        )
      )
    )
  $
]<def_T_V>
