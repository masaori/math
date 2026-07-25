#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim("")[

  $(h_1.z)$
  $
    sum_(
      n = 0
    )^infinity
      (1/n!)
      overbrace(
      [
        (1/2) sqrt(-1) dot.op K_1 dot.op H_1^((plus.minus)),
        dots,
        [
          (1/2) sqrt(-1) dot.op K_1 dot.op H_1^((plus.minus)),
          hat(Z)_mu^((plus.minus))
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    =
    cosh(K_1)
    dot.op
    hat(Z)_mu^((plus.minus))
    +
    sqrt(-1)
    dot.op
    exp(-sqrt(-1) (2 pi mu)/(M))
    dot.op
    sinh(K_1)
    dot.op
    hat(Y)_mu
  $

  $(h_1.y)$
  $
    sum_(
      n = 0
    )^infinity
      (1/n!)
      overbrace(
      [
        (1/2) sqrt(-1) dot.op K_1 dot.op H_1^((plus.minus)),
        dots,
        [
          (1/2) sqrt(-1) dot.op K_1 dot.op H_1^((plus.minus)),
          hat(Y)_mu
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    =
    -
    sqrt(-1)
    exp(
      sqrt(-1)
      (2 pi mu) / M
    )
    sinh(K_1)
    dot.op
    hat(Z)_mu^((plus.minus))
    +
    cosh(K_1)
    dot
    hat(Y)_mu
  $

  $(h_2.z^+)$
  $
    sum_(
      n = 0
    )^infinity
      (1/n!)
      overbrace(
      [
        sqrt(-1) dot.op K_2^* dot.op H_(2),
        dots,
        [
          sqrt(-1) dot.op K_2^* dot.op H_(2),
          hat(Z)_mu^((plus))
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    =
    ("メモ(0322) これは使われない")
  $

  $(h_2.z^-)$
  $
    &
    sum_(
      n = 0
    )^infinity
      (1/n!)
      overbrace(
      [
        sqrt(-1) dot.op K_2^* dot.op H_2,
        dots,
        [
          sqrt(-1) dot.op K_2^* dot.op H_2,
          hat(Z)_mu^((minus))
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    &quad =
    cosh(2 K_2^*)
    dot
    hat(Z)_mu^((minus))
    -
    sqrt(-1)
    sinh(2 K_2^*)
    dot
    hat(Y)_mu
  $

  $(h_2.y)$
  $
    sum_(
      n = 0
    )^infinity
      (1/n!)
      overbrace(
      [
        sqrt(-1) dot.op K_2^* dot.op H_2,
        dots,
        [
          sqrt(-1) dot.op K_2^* dot.op H_2,
          hat(Y)_mu
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    =
    sqrt(-1)
    sinh(2 K_2^*)
    dot
    hat(Z)_mu^((-))
    +
    cosh(2 K_2^*)
    dot
    hat(Y)_mu
  $

 #note[
  $
  sinh x = x + (1/3!) x^3 + (1/5!) x^5 + (1/7!) x^7 + ... \
  cosh x = 1 + (1/2!) x^2 + (1/4!) x^4 + (1/6!) x^6 + ...
  $
 ]

 #proof[

  $(h_1.z)$について、
  $
    ("左辺")
    &=
    (1/0!)
    hat(Z)_mu^((plus.minus))
    +
    sum_(
      n = 1
    )^infinity
      (1/n!)
      (
        cases(
          sqrt(-1)
          dot.op
          K_1^(n)
          dot.op
          exp(-sqrt(-1) (2 pi mu)/(M))
          dot.op
          hat(Y)_mu
          & (n "is odd"),
          K_1^(n)
          dot.op
          hat(Z)_mu^((plus.minus))
          & (n "is even"),
        )
      )
    \
    &=
    sum_(
      n >= 0 \
      n "is even"
    )
    (
      (1/n!)
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
    )
    +
    sum_(
      n >= 1 \
      n "is odd"
    )
    (
      (1/n!)
      sqrt(-1)
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
    )
    \
    &=
    (
      sum_(
        n >= 0 \
        n "is even"
      )
      (
        (1/n!)
        K_1^(n)
      )
    )
    dot.op
    hat(Z)_mu^((plus.minus))
    +
    sqrt(-1)
    dot.op
    exp(-sqrt(-1) (2 pi mu)/(M))
    (
      sum_(
        n >= 1 \
        n "is odd"
      )
      (
        (1/n!)
        K_1^(n)
      )
    )
    dot.op
    hat(Y)_mu
    \
    &=
    cosh(K_1)
    dot.op
    hat(Z)_mu^((plus.minus))
    +
    sqrt(-1)
    dot.op
    exp(-sqrt(-1) (2 pi mu)/(M))
    dot.op
    sinh(K_1)
    dot.op
    hat(Y)_mu
    \
  $

  $(h_1.y)$について、
  $
    ("左辺")
    &=
    (1/0!)
    hat(Y)_mu
    +
    sum_(
      n = 1
    )^infinity
      (1/n!)
      (
        cases(
          sqrt(-1)
          dot.op
          K_1^(n)
          dot.op
          exp(sqrt(-1) (2 pi mu)/(M))
          dot.op
          hat(Y)_mu
          & (n "is odd"),
          K_1^(n)
          dot.op
          hat(Z)_mu^((plus.minus))
          & (n "is even"),
        )
      )
    \
    &=
    sum_(
      n >= 0 \
      n "is even"
    )
    (
      (1/n!)
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
    )
    +
    sum_(
      n >= 1 \
      n "is odd"
    )
    (
      (1/n!)
      sqrt(-1)
      dot.op
      K_1^(n)
      dot.op
      exp(sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
    )
  $

  $(h_2.z^-)$について、
  $
    ("左辺")
    &=
    (1/0!)
    hat(Z)_mu^((minus))
    +
    sum_(
      n = 1
    )^infinity
      (1/n!)
      (
        cases(
          sqrt(-1)
          dot.op
          K_2^*^(n)
          dot.op
          hat(Z)_mu^((minus))
          & (n "is even"),
          sqrt(-1)
          dot.op
          K_2^*^(n)
          dot.op
          hat(Y)_mu
          & (n "is odd"),
        )
      )
    \
    &=
    sum_(
      n >= 0 \
      n "is even"
    )
    (
      (1/n!)
      K_2^*^(n)
      dot.op
      hat(Z)_mu^((minus))
    )
    +
    sum_(
      n >= 1 \
      n "is odd"
    )
    (
      (1/n!)
      sqrt(-1)
      dot.op
      K_2^*^(n)
      dot.op
      hat(Y)_mu
    )
  $

 ]
]<extract_taylor_coefficient_of_Z_Y>
