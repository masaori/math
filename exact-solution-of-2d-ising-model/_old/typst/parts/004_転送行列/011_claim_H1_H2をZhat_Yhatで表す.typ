#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim[$H_1^((plus.minus)), H_2$を$hat(Z),hat(Y)$で表す][
  $
  H_1^((plus.minus)) &= 1/M sum_(j in {1, dots.c, M}) (
    hat(Y)_j
    hat(Z)_(-j)^((plus.minus))
    exp(
      -
      sqrt(-1)
      (2 pi j) / M
    )
  ) \

  H_2 &= 1/M sum_(j in {1, dots.c, M}) (
    hat(Z)_(-j)^((-))
    hat(Y)_j
  )
  $

  #note[
    $
    hat(Z)_mu^((plus.minus))
    &:= 
    sum_(j=1)^M (
      (
        cases(
          1 "if" j != 1,
          minus.plus 1 "if" j = 1
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
    &:=
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

    $
      sum_(j=1)^M exp(k dot (2 pi sqrt(-1) j)/M) = M delta^M_((k, 0))
    $
  ]

  #proof[
    $H_1^((plus.minus))$について、
    $
    "(右辺)"
    &=
    1/M sum_(j in {1, dots.c, M}) (
      hat(Y)_j
      hat(Z)_(-j)^((plus.minus))
      exp(
        -
        sqrt(-1)
        (2 pi j) / M
      )
    ) 
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      overbrace(
        (
          sum_(k_1=1)^M (
            Y_(k_1)
            exp(
              -
              sqrt(-1)
              k_1
              (2 pi j) / M
            )
          )
        ),
        hat(Y)_j
      )
      dot.c
      overbrace(
        (
          sum_(k_2=1)^M (
            (
              cases(
                1 "if" k_2 != 1,
                minus.plus 1 "if" k_2 = 1
              )
            )
            dot
            Z_(k_2)
            exp(
              -
              sqrt(-1)
              k_2
              (2 pi (-j)) / M
            )
          )
        ),
        hat(Z)_(-j)^((plus.minus))
      )
      exp(
        -
        sqrt(-1)
        (2 pi j) / M
      )
    ) 
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      sum_(k_1, k_2=1)^M (
        (
          Y_(k_1)
          exp(
            -
            sqrt(-1)
            k_1
            (2 pi j) / M
          )
        )
        dot.c
        (
          (
            cases(
              1 "if" k_2 != 1,
              minus.plus 1 "if" k_2 = 1,
            )
          )
          dot
          Z_(k_2)
          exp(
            -
            sqrt(-1)
            k_2
            (2 pi (-j)) / M
          )
        )
      )
      exp(
        -
        sqrt(-1)
        (2 pi j) / M
      )
    ) 
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      sum_(k_1, k_2=1)^M (
        (
          Y_(k_1)
        )
        dot.c
        (
          (
            cases(
              1 "if" k_2 != 1,
              minus.plus 1 "if" k_2 = 1,
            )
          )
          dot
          Z_(k_2)
        )
        dot.c
        exp(
          -
          sqrt(-1)
          k_1
          (2 pi j) / M
        )
        dot.c
        exp(
          -
          sqrt(-1)
          k_2
          (2 pi (-j)) / M
        )
        dot.c
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
      )
    ) 
    \
    &quad quad ("expを後ろに移動")
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        exp(
          -
          sqrt(-1)
          k_1
          (2 pi j) / M
        )
        dot.c
        exp(
          -
          sqrt(-1)
          k_2
          (2 pi (-j)) / M
        )
        dot.c
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    ) 
    \
    &quad quad ("符号を前に、YZを後ろに移動")
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        exp(
          -
          sqrt(-1)
          k_1
          (2 pi j) / M
          -
          sqrt(-1)
          k_2
          (2 pi (-j)) / M
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    ) 
    \
    &quad quad ("expをまとめる")
    \
    &=
    1/M sum_(j in {1, dots.c, M}) (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
          (
            k_1
            -
            k_2
            +
            1
          )
        )
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    ) 
    \
    &=
    1/M (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
            (
              k_1
              -
              k_2
              +
              1
            )
          )
        )
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    ) 
    \
    &=
    1/M (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            (
              k_1
              -
              k_2
              +
              1
            )
            sqrt(-1)
            (2 pi j) / M
          )
        )
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    )
    \
    &=
    1/M (
      sum_(k_1, k_2=1)^M (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        M delta^M_((
          -
          (
            k_1
            -
            k_2
            +
            1
          ),
          0
        ))
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    )
    \
    &quad quad (because #ref(<exp_sum>))
    \
    &=
    1/M (
      sum_(k_1, k_2 in {1, dots, M} \ -(k_1-k_2+1) equiv 0 mod M) (
        (
          cases(
            1 "if" k_2 != 1,
            minus.plus 1 "if" k_2 = 1,
          )
        )
        dot.c
        M
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    )
    \
    &=
    1/M (
      sum_(k_1 in {1, dots, M} \ k_2 in {2, dots, M} \ -(k_1-k_2+1) equiv 0 mod M) (
        M
        dot.c
        (
          Y_(k_1)
          Z_(k_2)
        )
      )
    )
    +
    1/M (
      sum_(k_1 in {1, dots, M} \ -k_1 equiv 0 mod M) (
        minus.plus
        M
        dot.c
        (
          Y_(k_1)
          Z_(1)
        )
      )
    )
    \
    &=
    (
      overbrace(
        Y_1 Z_2 + Y_2 Z_3 + dots.c + Y_(M-1) Z_M,
        because k_1 in {1, dots, M} and k_2 in {2, dots, M} and -(k_1-k_2+1) equiv 0 mod M
          \ => k_1 in {1, dots, M} and k_2 in {2, dots, M} and k_1 equiv k_2-1 mod M
          \ => k_1 in {1, dots, M} and k_2-1 in {1, dots, M-1} and k_1 equiv k_2-1 mod M
          \ => k_1 in {1, dots, M-1} and k_1 = k_2-1
          \ (because k_2-1 in {1, dots, M-1}"かつ"k_1 equiv k_2-1 mod M"を満たすような"k_1"は"{1, dots, M-1}"に限る")
      )
    )
    +
    (
      overbrace(
        minus.plus
        (
          Y_((M))
          Z_(1)
        ),
        because k_1 in {1, dots, M} and -k_1 equiv 0 mod M => k_1 = M
      )
    )
    \
    &=
    H_1^((plus.minus))
    \
    qed
    $

    $H_2$について、
    $
    "(右辺)"
    &=
    1/M sum_(j in {1, dots.c, M}) (
      hat(Z)_(-j)^((-))
      hat(Y)_j
    )
    \
    &=
    1/M
    sum_(j in {1, dots.c, M}) (
      overbrace(
        (
          sum_(k_1=1)^M (
            (
              cases(
                1 "if" k_1 != 1,
                plus 1 "if" k_1 = 1
              )
            )
            dot.op
            Z_k_1
            dot.op
            exp(
              -
              sqrt(-1)
              k_1
              (2 pi (-j)) / M
            )
          )
        ),
        hat(Z)_(-j)^((-))
      )
      dot.op
      overbrace(
        (
          sum_(k_2=1)^M (
            Y_(k_2)
            dot.op
            exp(
              -
              sqrt(-1)
              k_2
              (2 pi j) / M
            )
          )
        ),
        hat(Y)_j
      )
    )
    \
    &=
    1/M
    sum_(j in {1, dots.c, M}) (
      (
        sum_(k_1=1)^M (
          Z_k_1
          dot.op
          exp(
            -
            sqrt(-1)
            k_1
            (2 pi (-j)) / M
          )
        )
      )
      dot.op
      (
        sum_(k_2=1)^M (
          Y_(k_2)
          dot.op
          exp(
            -
            sqrt(-1)
            k_2
            (2 pi j) / M
          )
        )
      )
    )
    \
    &=
    1/M
    sum_(j in {1, dots.c, M}) (
      (
        sum_(k_1, k_2=1)^M (
          (
            Z_k_1
            dot.op
            exp(
              -
              sqrt(-1)
              k_1
              (2 pi (-j)) / M
            )
          )
          dot.op
          (
            Y_(k_2)
            dot.op
            exp(
              -
              sqrt(-1)
              k_2
              (2 pi j) / M
            )
          )
        )
      )
    )
    \
    &=
    1/M
    sum_(j in {1, dots.c, M}) (
      (
        sum_(k_1, k_2=1)^M (
          exp(
            -
            sqrt(-1)
            k_1
            (2 pi (-j)) / M
          )
          dot.op
          exp(
            -
            sqrt(-1)
            k_2
            (2 pi j) / M
          )
          dot.op
          Z_k_1
          Y_(k_2)
        )
      )
    )
    \
    &=
    1/M
    sum_(j in {1, dots.c, M}) (
      (
        sum_(k_1, k_2=1)^M (
          exp(
            -
            sqrt(-1)
            k_1
            (2 pi (-j)) / M
            -
            sqrt(-1)
            k_2
            (2 pi j) / M
          )
          dot.op
          Z_k_1
          Y_(k_2)
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(k_1, k_2=1)^M (
        underbrace(
          sum_(j in {1, dots.c, M}) (
            exp(
              (
                k_1
                -
                k_2
              )
              dot.op
              (2 pi sqrt(-1) j) / M
            )
          ),
          #ref(<exp_sum>)"を適用"
        )
        dot.op
        Z_k_1
        Y_(k_2)
      )
    )
    \
    &=
    1/M
    sum_(k_1, k_2=1)^M (
      overbrace(
        M delta^M_((k_1-k_2, 0)),
        because #ref(<exp_sum>)
      )
      dot.op
      Z_k_1
      Y_(k_2)
    )
    \
    &=
    sum_(k_1, k_2=1)^M (
      delta^M_((k_1-k_2, 0))
      dot.op
      Z_k_1
      Y_(k_2)
    )
    \
    &=
    sum_(
      k_1 in {1, dots, M} \
      k_2 in {1, dots, M} \
      k_1 - k_2 equiv 0 mod M
    ) (
      Z_k_1
      Y_(k_2)
    )
    \
    &=
    sum_(
      k_1 in {1, dots, M} \
      k_1 = k_2
    ) (
      Z_k_1
      Y_(k_2)
    )
    \
    &=
    Z_1 Y_1 + Z_2 Y_2 + dots.c + Z_M Y_M
    \
    &=
    H_2
    \
    qed
    $
  ]
]


