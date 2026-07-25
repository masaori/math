#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim(none)[

  $n >= 0$とする。

  $(h_1.z)$
  $
    overbrace(
      [
        K_1 dot.op H_1^((plus.minus)),
        dots,
        [K_1 dot.op H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]
        dots
      ]
      ,
      n "times"
    )
    =
    cases(
      (-1)^((n-1)/2)
      dot.op
      (2 K_1)^(n)
      dot.op
      exp(-sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (2 K_1)^(n)
      dot.op
      hat(Z)_mu^((plus.minus))
      & (n "is even"),
    )
  $

  ただし$n = 0$のときは、
  $
  overbrace(
    [
      K_1 dot.op H_1^((plus.minus)),
      dots,
      [K_1 dot.op H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]
      dots
    ]
    ,
    0 "times"
  )
  =
  hat(Z)_mu^((plus.minus))
  $

  と定める。

  $(h_1.y)$
  $
    overbrace(
      [
        K_1 dot.op H_1^((plus.minus)),
        dots,
        [K_1 dot.op H_1^((plus.minus)), hat(Y)_mu]
        dots
      ]
      ,
      n "times"
    )
    =
    cases(
      (-1)^((n+1)/2)
      dot.op
      (2 K_1)^(n)
      dot.op
      exp(sqrt(-1) (2 pi mu)/(M))
      dot.op
      hat(Z)_mu^((plus))
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (2 K_1)^(n)
      dot.op
      hat(Y)_mu
      & (n "is even"),
    )
  $

  ただし$n = 0$のときは、
  $
  overbrace(
    [
      K_1 dot.op H_1^((plus.minus)),
      dots,
      [K_1 dot.op H_1^((plus.minus)), hat(Y)_mu]
      dots
    ]
    ,
    0 "times"
  )
  =
  hat(Y)_mu
  $
  と定める。

  $(h_2.z^+)$

  $
    overbrace(
      [
        K_2^(*) dot.op H_2,
        dots,
        [K_2^(*) dot.op H_2, hat(Z)_mu^((plus))]
        dots
      ]
      ,
      n "times"
    )
    =
    "メモ(0322) これは使われない"
  $
  ただし$n = 0$のときは、
  $
  overbrace(
    [
      K_2^(*) dot.op H_2,
      dots,
      [K_2^(*) dot.op H_2, hat(Z)_mu^((plus))]
      dots
    ]
    ,
    0 "times"
  )
  =
  hat(Z)_mu^((plus))
  $
  と定める。

  $(h_2.z^-)$
  $
    overbrace(
      [
        K_2^(*) dot.op H_2,
        dots,
        [K_2^(*) dot.op H_2, hat(Z)_mu^((-))]
        dots
      ]
      ,
      n "times"
    )
    =
    cases(
      (-1)^((n+1)/2)
      dot.op
      (2 K_2^(*))^(n)
      dot.op
      hat(Y)_mu
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (2 K_2^(*))^(n)
      dot.op
      hat(Z)_mu^((-))
      & (n "is even"),
    )
  $
  ただし$n = 0$のときは、
  $
  overbrace(
    [
      K_2^(*) dot.op H_2,
      dots,
      [K_2^(*) dot.op H_2, hat(Z)_mu^((-))]
      dots
    ]
    ,
    0 "times"
  )
  =
  hat(Z)_mu^((-))
  $
  と定める。

  $(h_2.y)$
  $
    overbrace(
      [
        K_2^(*) dot.op H_2,
        dots,
        [K_2^(*) dot.op H_2, hat(Y)_mu]
        dots
      ]
      ,
      n "times"
    )
    =
    cases(
      (-1)^((n-1)/2)
      dot.op
      (2 K_2^(*))^(n)
      dot.op
      hat(Z)_mu^((minus))
      & (n "is odd"),
      (-1)^(n/2)
      dot.op
      (2 K_2^(*))^(n)
      dot.op
      hat(Y)_mu
      & (n "is even"),
    )
  $
  ただし$n = 0$のときは、
  $
  overbrace(
    [
      K_2^(*) dot.op H_2,
      dots,
      [K_2^(*) dot.op H_2, hat(Y)_mu]
      dots
    ]
    ,
    0 "times"
  )
  =
  hat(Y)_mu
  $
  と定める。

  #note[
    @commutator_of_H_and_Z_Y
  ]

  #note[

    $(h_1.z)$
    $n = 0$
    $
    overbrace(
      [
        K_1 dot.op H_1^((plus.minus)),
        dots,
        [K_1 dot.op H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]
        dots
      ]
      ,
      0 "times"
    )
    =
    hat(Z)_mu^((plus.minus))
    $

    $n = 1$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      hat(Z)_mu^((plus.minus))
    ]
    &=
    K_1
    dot.op
    [
      H_1^((plus.minus)),
      hat(Z)_mu^((plus.minus))
    ]
    \
    &=
    K_1
    dot.op
    2
    dot.op
    (
      cases(
        hat(Y)_((M))
        & quad (mu = -M),
        exp(
          -
          sqrt(-1)
          (2 pi (M + mu)) / M
        )
        dot.op
        hat(Y)_((M + mu))
        & quad (-M + 1 <= mu <= -1),
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_((mu))
        & quad (1 <= mu <= M - 1),
        hat(Y)_((M))
        & quad (mu = M),
      )
    )
    \
    &=
    K_1
    dot.op
    2
    dot.op
    (
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      hat(Y)_((mu))
    )
    \
    & quad
    (
      because
      hat(Y)"の定義より、Mズレは値が等しくなるので、" hat(Y)_((mu)) = hat(Y)_((M + mu)),
      exp(
        -
        sqrt(-1)
        (2 pi (-M)) / M
      )
      dot.op
      hat(Y)_((-M))
      =
      1
      dot.op
      hat(Y)_((M - 2M))
      =
      exp(
        -
        sqrt(-1)
        (2 pi M) / M
      )
      dot.op
      hat(Y)_((M))
    )
    $

    $n = 2$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      [
        K_1 dot.op H_1^((plus.minus)),
        hat(Z)_mu^((plus.minus))
      ]
    ]
    &=
    [
      K_1
      dot.op
      H_1^((plus.minus)),
      K_1
      dot.op
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_((mu))
      )
    ]
    \
    &=
    K_1^2
    dot.op
    2
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    [
      H_1^((plus.minus)),
      hat(Y)_((mu))
    ]
    \
    &=
    K_1^2
    dot.op
    2
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    (
      -
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
      )
    )
    \
    &=
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    exp(
      overbrace(
        -
        sqrt(-1)
        (2 pi mu) / M
        -
        sqrt(-1)
        (2 pi (-mu)) / M
        ,
        0
      )
    )
    dot.op
    hat(Z)_((mu))^((plus.minus))
    \
    &=
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    hat(Z)_((mu))^((plus.minus))
    $

    $n = 3$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      overbrace(
      [
        K_1 dot.op H_1^((plus.minus)),
        [
          K_1 dot.op H_1^((plus.minus)),
          hat(Z)_mu^((plus.minus))
        ]
      ],
      n = 2
      )
    ]
    &=
    [
      K_1 dot.op H_1^((plus.minus)),
      K_1^2
      dot.op
      2^2
      dot.op
      (-1)^1
      dot.op
      hat(Z)_((mu))^((plus.minus))
    ]
    \
    &=
    K_1
    dot.op
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    [
      H_1^((plus.minus)),
      hat(Z)_((mu))^((plus.minus))
    ]
    \
    &=
    K_1
    dot.op
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    (
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_((mu))
      )
    )
    \
    &=
    K_1^3
    dot.op
    2^3
    dot.op
    (-1)^1
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    hat(Y)_((mu))
    $

    $n = 4$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      overbrace(
        [
          K_1 dot.op H_1^((plus.minus)),
          [
            K_1 dot.op H_1^((plus.minus)),
            [
              K_1 dot.op H_1^((plus.minus)),
              hat(Z)_mu^((plus.minus))
            ]
          ]
        ]
        ,
        n = 3
      )
    ]
    &=
    [
      K_1 dot.op H_1^((plus.minus)),
      K_1^3
      dot.op
      2^3
      dot.op
      (-1)^1
      dot.op
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      hat(Y)_((mu))
    ]
    \
    &=
    K_1
    dot.op
    K_1^3
    dot.op
    2^3
    dot.op
    (-1)^1
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    [
      H_1^((plus.minus)),
      hat(Y)_((mu))
    ]
    \
    &=
    K_1
    dot.op
    K_1^3
    dot.op
    2^3
    dot.op
    (-1)^1
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    (
      -
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
      )
    )
    \
    &=
    K_1^4
    dot.op
    2^4
    dot.op
    (-1)^2
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi (-mu)) / M
    )
    dot.op
    hat(Z)_((mu))^((plus.minus))
    \
    &=
    K_1^4
    dot.op
    2^4
    dot.op
    (-1)^2
    dot.op
    exp(
      overbrace(
        -
        sqrt(-1)
        (2 pi mu) / M
        -
        sqrt(-1)
        (2 pi (-mu)) / M
        ,
        0
      )
    )
    dot.op
    hat(Z)_((mu))^((plus.minus))
    \
    &=
    K_1^4
    dot.op
    2^4
    dot.op
    (-1)^2
    dot.op
    hat(Z)_((mu))^((plus.minus))
    $

    $(h_1.y)$

    $n = 0$
    $
    overbrace(
      [
        K_1 dot.op H_1^((plus.minus)),
        dots,
        [K_1 dot.op H_1^((plus.minus)), hat(Y)_mu]
        dots
      ]
      ,
      0 "times"
    )
    =
    hat(Y)_mu
    $

    $n = 1$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      hat(Y)_mu
    ]
    &=
    K_1
    dot.op
    [
      H_1^((plus.minus)),
      hat(Y)_mu
    ]
    \
    &=
    K_1
    dot.op
    (
      -
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
      )
    )
    \
    &=
    K_1
    dot.op
    2
    dot.op
    (-1)
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi (-mu)) / M
    )
    dot.op
    hat(Z)_((mu))^((plus.minus))
    $

    $n = 2$
    $
    [
      K_1 dot.op H_1^((plus.minus)),
      overbrace(
        [
          K_1 dot.op H_1^((plus.minus)),
          hat(Y)_mu
        ]
        ,
        n = 1
      )
    ]
    &=
    [
      K_1 dot.op H_1^((plus.minus)),
      K_1
      dot.op
      2
      dot.op
      (-1)
      dot.op
      exp(
        -
        sqrt(-1)
        (2 pi (-mu)) / M
      )
      dot.op
      hat(Z)_((mu))^((plus.minus))
    ]
    \
    &=
    K_1^2
    dot.op
    2
    dot.op
    (-1)
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi (-mu)) / M
    )
    dot.op
    [
      H_1^((plus.minus)),
      hat(Z)_((mu))^((plus.minus))
    ]
    \
    &=
    K_1^2
    dot.op
    2
    dot.op
    (-1)
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi (-mu)) / M
    )
    dot.op
    (
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_((mu))
      )
    )
    \
    &=
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi (-mu)) / M
    )
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    hat(Y)_((mu))
    \
    &=
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)
    dot.op
    exp(
      overbrace(
        -
        sqrt(-1)
        (2 pi (-mu)) / M
        -
        sqrt(-1)
        (2 pi mu) / M
        ,
        0
      )
    )
    dot.op
    hat(Y)_((mu))
    \
    &=
    K_1^2
    dot.op
    2^2
    dot.op
    (-1)
    dot.op
    hat(Y)_((mu))
    $

    $n = 3$

    $
    [
      K_1 dot.op H_1^((plus.minus)),
      overbrace(
        [
          K_1 dot.op H_1^((plus.minus)),
          [
            K_1 dot.op H_1^((plus.minus)),
            hat(Y)_mu
          ]
        ]
        ,
        n = 2
      )
    ]
    &=
    [
      K_1 dot.op H_1^((plus.minus)),
      K_1^2
      dot.op
      2^2
      dot.op
      (-1)
      dot.op
      hat(Y)_((mu))
    ]
    \
    &=
    K_1^3
    dot.op
    2^2
    dot.op
    (-1)
    dot.op
    [
      H_1^((plus.minus)),
      hat(Y)_((mu))
    ]
    \
    &=
    K_1^3
    dot.op
    2^2
    dot.op
    (-1)
    dot.op
    (
      -
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
      )
    )
    \
    &=
    K_1^3
    dot.op
    2^3
    dot.op
    (-1)^2
    dot.op
    exp(
      -
      sqrt(-1)
      (2 pi mu) / M
    )
    dot.op
    hat(Z)_((mu))^((plus.minus))
    $

    $(h_2.z-)$

    $n = 1$
    $
    [
      (K_2^(*)) dot.op H_2,
      hat(Z)_mu^((-))
    ]
    &=
    (K_2^(*))
    dot.op
    [
      H_2,
      hat(Z)_mu^((-))
    ]
    \
    &=
    (K_2^(*))
    dot.op
    (
      -2
      dot.op
      hat(Y)_mu
    )
    \
    &=
    (K_2^(*))^1
    dot.op
    2^1
    dot.op
    (-1)^1
    dot.op
    hat(Y)_mu
    $

    $n = 2$

    $
    [
      (K_2^(*)) dot.op H_2,
      overbrace(
        [
          (K_2^(*)) dot.op H_2,
          hat(Z)_mu^((-))
        ]
        ,
        n = 1
      )
    ]
    &=
    [
      (K_2^(*)) dot.op H_2,
      (K_2^(*))^1
      dot.op
      2^1
      dot.op
      (-1)^1
      dot.op
      hat(Y)_mu
    ]
    \
    &=
    (K_2^(*))^2
    dot.op
    2^1
    dot.op
    (-1)^1
    dot.op
    [
      H_2,
      hat(Y)_mu
    ]
    \
    &=
    (K_2^(*))^2
    dot.op
    2^1
    dot.op
    (-1)^1
    dot.op
    (
      2
      dot.op
      hat(Z)_(mu)^((-))
    )
    \
    &=
    (K_2^(*))^2
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    hat(Z)_(mu)^((-))
    \
    $

    $n = 3$

    $
    [
      (K_2^(*)) dot.op H_2,
      overbrace(
        [
          (K_2^(*)) dot.op H_2,
          [
            (K_2^(*)) dot.op H_2,
            hat(Z)_mu^((-))
          ]
        ]
        ,
        n = 2
      )
    ]
    &=
    [
      (K_2^(*)) dot.op H_2,
      (K_2^(*))^2
      dot.op
      2^2
      dot.op
      (-1)^1
      dot.op
      hat(Z)_(mu)^((-))
    ]
    \
    &=
    (K_2^(*))^3
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    [
      H_2,
      hat(Z)_(mu)^((-))
    ]
    \
    &=
    (K_2^(*))^3
    dot.op
    2^2
    dot.op
    (-1)^1
    dot.op
    (
      -2
      dot.op
      hat(Y)_mu
    )
    \
    &=
    (K_2^(*))^3
    dot.op
    2^3
    dot.op
    (-1)^2
    dot.op
    hat(Y)_mu
    \
    $
  ]

  #proof[
    TODO : note参考にして、帰納法で行ける
  ]
]<nesting_of_commutator_of_H_and_Z>
