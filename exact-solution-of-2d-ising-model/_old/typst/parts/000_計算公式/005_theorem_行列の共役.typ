#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("行列の共役")[
  $A, B in "Mat"(n, CC)$, $B$は正則とする。

  $T_(B): "Mat"(n, CC) -> "Mat"(n, CC)$を、

  $
    T_(B)(A) := B A B^(-1)
  $

  と定めるとき、$T_(B)$は線型写像である。

  #proof[
    $A, C in "Mat"(n, CC)$に対して、
    $
      T_(B)(A + C)
      &=
      B (A + C) B^(-1)
      \
      &=
      (B A + B C) B^(-1)
      \
      &=
      B A B^(-1) + B C B^(-1)
      \
      &=
      T_(B)(A) + T_(B)(C)
    $

    $alpha in CC$に対して、
    $
      T_(B)(alpha A)
      &=
      B (alpha A) B^(-1)
      \
      &=
      alpha (B A B^(-1))
      \
      &=
      alpha T_(B)(A)
    $
  ]
]<mat_conj>
