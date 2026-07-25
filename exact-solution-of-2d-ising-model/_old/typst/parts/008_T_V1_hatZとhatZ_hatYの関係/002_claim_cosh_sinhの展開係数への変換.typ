#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim($#ref(<nesting_of_commutator_of_H_and_Z>)"を使い、consh/sinhの展開係数っぽくする"$)[
  $(h_1.z)$
  $
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
    &=
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
  $

  $(h_1.y)$
  $
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
    &=
    cases(
      sqrt(-1)
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      \
      "(次回 0419) expの方の符号がミスっている"
      \
      dot.op
      hat(Z)_mu^((plus))
      & (n "is odd"),
      K_1^(n)
      dot.op
      hat(Y)_mu
      & (n "is even"),
    )
  $

  $(h_2.z^(minus))$
  $
    overbrace(
      [
        sqrt(-1) dot.op K_2^(*) dot.op H_2,
        dots,
        [
          sqrt(-1) dot.op K_2^(*) dot.op H_2,
          hat(Z)_mu^((-))
        ]
        dots
      ]
      ,
      n "times"
    )
    &=
    cases(
      -
      sqrt(-1)
      dot.op
      (2K_2^(*))^(n)
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (2K_2^(*))^(n)
      dot.op
      hat(Z)_mu^((-))
      & (n "is even"),
    )
  $

  $(h_2.y)$
  $
    overbrace(
      [
        sqrt(-1) dot.op K_2^(*) dot.op H_2,
        dots,
        [
          sqrt(-1) dot.op K_2^(*) dot.op H_2,
          hat(Y)_mu
        ]
        dots
      ]
      ,
      n "times"
    )
    &=
    cases(
      sqrt(-1)
      dot.op
      (2K_2^(*))^(n)
      dot.op
      hat(Z)_mu^((-))
      & (n "is odd"),
      (2K_2^(*))^(n)
      dot.op
      hat(Y)_mu
      & (n "is even"),
    )
  $

  #proof[
  $
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
    &=
    cases(
      (-1)^((n-1)/2)
      dot.op
      (2 (1/2) sqrt(-1) dot.op K_1)^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (2 (1/2) sqrt(-1) dot.op K_1)^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
    cases(
      (-1)^((n-1)/2)
      dot.op
      (sqrt(-1))^n
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (sqrt(-1))^n
      dot.op
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
    cases(
      (-1)^((n-1)/2)
      dot.op
      (-1)^(n/2)
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (-1)^(n/2)
      dot.op
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
    cases(
      (-1)^(((n-1)/2 + n/2))
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^((n/2 + n/2))
      dot.op
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
    cases(
      (-1)^(((2n+2)/2 + 1/2))
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^((n/2 + n/2))
      dot.op
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
    cases(
      (-1)^(n+1)
      dot.op
      (-1)^(1/2)
      dot.op
      K_1^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n)
      dot.op
      K_1^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
    \
    &=
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
    \
    &=
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
  $
  ]
]
