#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$c dot.op I$ は全行列と可換])[
  体 $K$、$n in ZZ_(>= 1)$、$c in K$、$A in "Mat"(n, K)$ について、

  $
    [c dot.op I, A] = 0
  $

  #proof[
    $
      [c dot.op I, A]
      &=
      (c dot.op I) A - A (c dot.op I)
      \
      &=
      c A - c A
      \
      &=
      0
    $
  ]
]<scalar_identity_commutes>
