#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition(none)[
  
  $T_((V_1^((plus.minus)))^(1/2)) times T_((V_1^((plus.minus)))^(1/2)) : "Mat"(2, CC)^(times.o M) times "Mat"(2, CC)^(times.o M) -> "Mat"(2, CC)^(times.o M) times "Mat"(2, CC)^(times.o M) $

  $T_((V_2)) times T_((V_2)) : "Mat"(2, CC)^(times.o M) times "Mat"(2, CC)^(times.o M) -> "Mat"(2, CC)^(times.o M) times "Mat"(2, CC)^(times.o M)$

  を、

  $forall X, Y in "Mat"(2, CC)^(times.o M)$
  $
    (
      T_((V_1^((plus.minus)))^(1/2)) times T_((V_1^((plus.minus)))^(1/2))
    )
    (X, Y)
    :=
    (
      T_((V_1^((plus.minus)))^(1/2))(X),
      T_((V_1^((plus.minus)))^(1/2))(Y)
    )
    \
    (
      T_((V_2)) times T_((V_2))
    )
    (X, Y)
    :=
    (
      T_((V_2))(X),
      T_((V_2))(Y)
    )
  $
  
  で定める
]
