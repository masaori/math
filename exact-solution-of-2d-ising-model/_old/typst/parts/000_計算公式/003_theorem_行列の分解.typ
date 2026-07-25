#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem("行列の分解")[
  $A in "Mat"(n, CC), a, b in CC^n$

  $
    mat(
      A a,
      A b,
    )
    =
    A
    mat(
      a,
      b,
    )
  $
]<mat_mult>
