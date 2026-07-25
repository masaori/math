#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim("ホロノミック量子場 p142下段 1>")[
  $
  T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus)))
  &=
  (V_1^((plus.minus)))^(1/2)
  dot
  hat(Z)_mu^((minus))
  dot
  (V_1^((plus.minus)))^(-1/2) \
  &=
  cosh(K_1)
  dot
  hat(Z)_mu^((minus))
  +
  sqrt(-1)
  exp(
    -
    sqrt(-1)
    (2 pi mu) / M
  )
  sinh(K_1)
  dot
  hat(Y)_mu
  \
  &=
  mat(
    hat(Z)_mu^((minus)),
    hat(Y)_mu,
  )
  mat(
    cosh(K_1);
    sqrt(-1)
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    sinh(K_1);
  )
  \
  T_((V_1^((plus.minus)))^(1/2))(hat(Y)_mu)
  &=
  (V_1^((plus.minus)))^(1/2)
  dot
  hat(Y)_mu
  dot
  (V_1^((plus.minus)))^(-1/2) \
  &=
  -
  sqrt(-1)
  exp(
    sqrt(-1)
    (2 pi mu) / M
  )
  sinh(K_1)
  dot.op
  hat(Z)_mu^((minus))
  +
  cosh(K_1)
  dot
  hat(Y)_mu
  \
  &=
  mat(
    hat(Z)_mu^((minus)),
    hat(Y)_mu,
  )
  mat(
    sqrt(-1)
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    sinh(K_1);
    cosh(K_1);
  )
  \

  T_(V_2)(hat(Z)_mu^((minus)))
  &=
  V_2
  dot
  hat(Z)_mu^((minus))
  dot
  V_2^(-1) \
  &=
  cosh(2 K_2^*)
  dot
  hat(Z)_mu^((minus))
  -
  sqrt(-1)
  sinh(2 K_2^*)
  dot
  hat(Y)_mu
  \
  &=
  mat(
    hat(Z)_mu^((minus)),
    hat(Y)_mu,
  )
  mat(
    cosh(2 K_2^*);
    - sqrt(-1)
    sinh(2 K_2^*);
  )
  \

  T_(V_2)(hat(Y)_mu)
  &=
  V_2
  dot
  hat(Y)_mu
  dot
  V_2^(-1) \
  &=
  sqrt(-1)
  sinh(2 K_2^*)
  dot
  hat(Z)_mu^((-))
  +
  cosh(2 K_2^*)
  dot
  hat(Y)_mu
  \
  &=
  mat(
    hat(Z)_mu^((minus)),
    hat(Y)_mu,
  )
  mat(
    sqrt(-1)
    sinh(2 K_2^*);
    cosh(2 K_2^*);
  )
  \
  $

  #proof[
    $T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus)))$について、

    $
    T_((V_1^((plus.minus)))^(1/2))(hat(Z)_mu^((minus)))
    &=
    (V_1^((plus.minus)))^(1/2)
    dot
    hat(Z)_mu^((minus))
    dot
    (V_1^((plus.minus)))^(-1/2)
    \
    &=
    (exp(sqrt(-1) K_1 dot.op H_1^((plus.minus))))^(1/2)
    dot
    hat(Z)_mu^((minus))
    dot
    (exp(sqrt(-1) K_1 dot.op H_1^((plus.minus))))^(-1/2)
    \
    &=
    (exp((1/2) sqrt(-1) K_1 dot.op H_1^((plus.minus))))
    dot
    hat(Z)_mu^((minus))
    dot
    (exp(-((1/2) sqrt(-1) K_1 dot.op H_1^((plus.minus)))))
    \
    &=
    sum_(
      n >= 0
    )^infinity
      (1/n!)
      overbrace(
      [
        (1/2) sqrt(-1) K_1 dot.op H_1^((plus.minus)),
        dots,
        [
          (1/2) sqrt(-1) K_1 dot.op H_1^((plus.minus)),
          hat(Z)_mu^((minus))
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    & quad (because #ref(<exp_X_Y_exp_-X>) )
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
    & quad (because #ref(<extract_taylor_coefficient_of_Z_Y>) )
    $

    $T_((V_1^((plus.minus)))^(1/2))(hat(Y))$について、

    同様

    $T_(V_2)(hat(Z)_mu^((minus)))$について、

    $
    T_(V_2)(hat(Z)_mu^((minus)))
    &=
    V_2
    dot
    hat(Z)_mu^((minus))
    dot
    V_2^(-1)
    \
    &=
    (
      (2s_2)^(M/2)exp(sqrt(-1) K_2^* dot.op H_2)
    )
    dot
    hat(Z)_mu^((minus))
    dot
    (
      (2s_2)^(M/2)exp(-sqrt(-1) K_2^* dot.op H_2)
    )^(-1)
    \
    &=
    (2s_2)^(M/2)
    dot
    ((2s_2)^(M/2))^(-1)
    dot
    sum_(
      n >= 0
    )^infinity
      (1/n!)
      overbrace(
      [
        sqrt(-1) K_2^* dot.op H_2,
        dots,
        [
          sqrt(-1) K_2^* dot.op H_2,
          hat(Z)_mu^((minus))
        ]
        dots
      ]
      ,
      n "times"
    )
    \
    &=
    cosh(2 K_2^*)
    dot
    hat(Z)_mu^((minus))
    -
    sqrt(-1)
    sinh(2 K_2^*)
    dot
    hat(Y)_mu
    $

    $T_(V_2)(hat(Y)_mu)$について、

    同様


  ]
]<ホロノミック量子場_p142下段_1>
