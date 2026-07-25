#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("行列の組みへの作用")[
  $A, B, C in "Mat"(n, CC)$
  $
    mat(
      A B, A C
    )
    =
    A mat(
      B, C
    )
  $
]
