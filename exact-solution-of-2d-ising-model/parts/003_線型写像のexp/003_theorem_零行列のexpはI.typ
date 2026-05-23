#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem([$exp(O) = I$])[
  $O$ を零行列、$I$ を単位行列とするとき、
  $
    exp(O) = I
  $

  #proof[
    $exp$ の定義より、$O^0 = I$、$n >= 1$ のとき $O^n = O$（零行列の冪）であるから、
    $
      exp(O)
      &=
      sum_(n=0)^infinity
      O^n / (n!)
      \
      &=
      I / (0!)
      +
      sum_(n=1)^infinity
      O / (n!)
      \
      &=
      I
      +
      O dot.op sum_(n=1)^infinity
      1 / (n!)
      \
      &=
      I
      +
      O
      \
      &=
      I
    $
  ]
]<theorem_exp_zero>
