#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#theorem([$cosh, sinh$の掛け算])[
  $forall a, b in RR$

  $
    cosh(a) sinh(b) = 1/2 (sinh(a+b) - sinh(a-b)) \
    cosh(a) cosh(b) = 1/2 (cosh(a+b) + cosh(a-b)) \
  $

  #proof[
    $
      cosh(a) sinh(b)
      &=
      (exp(a) + exp(-a))/2
      (exp(b) - exp(-b))/2
      \
      &=
      1/4
      (
        (exp(a) exp(b) - exp(-a) exp(-b))
        -
        (exp(a) exp(-b) - exp(-a) exp(b))
      )
      \
      &=
      1/2
      (
        (exp(a+b) - exp(-(a+b)))/2
        -
        (exp(a-b) - exp(-(a-b)))/2
      )
      \
      &=
      1/2
      (
        sinh(a+b)
        -
        sinh(a-b)
      )
      \
      cosh(a) cosh(b)
      &=
      (exp(a) + exp(-a))/2
      (exp(b) + exp(-b))/2
      \
      &=
      1/4
      (
        (exp(a) exp(b) + exp(-a) exp(-b))
        +
        (exp(a) exp(-b) + exp(-a) exp(b))
      )
      \
      &=
      1/2
      (
        (exp(a+b) + exp(-(a+b)))/2
        +
        (exp(a-b) + exp(-(a-b)))/2
      )
      \
      &=
      1/2
      (
        cosh(a+b)
        +
        cosh(a-b)
      )
    $
  ]
]
