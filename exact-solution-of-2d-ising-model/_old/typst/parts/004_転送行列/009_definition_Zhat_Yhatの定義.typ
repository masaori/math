#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#definition($hat(Z), hat(Y)"の定義"$)[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$について、

  $
  hat(Z)_mu^((plus.minus))
  :&= 
  sum_(j=1)^M (
    (
      cases(
        minus.plus 1 "if" j = 1,
        1 "if" j != 1,
      )
    )
    dot
    Z_j
    exp(
      -
      sqrt(-1)
      j
      (2 pi mu) / M
    )
  )
  \
  &=
  minus.plus
  Z_1
  exp(
    -
    sqrt(-1)
    (2 pi mu) / M
  )
  +
  sum_(j=2)^M (
    Z_j
    exp(
      -
      sqrt(-1)
      j
      (2 pi mu) / M
    )
  )
  \
  hat(Y)_mu
  :&=
  sum_(j=1)^M (
    Y_j
    exp(
      -
      sqrt(-1)
      j
      (2 pi mu) / M
    )
  )
  $
]<def_hatZ_hatY>
