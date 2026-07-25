#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$H_1^((plus.minus))$,$H_2$と$hat(Z)_mu^((plus.minus))$, $hat(Y)_mu$の交換関係])[
  $
    [H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]
    =&
    2
    dot.op
    (
      cases(
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Y)_((-mu))
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
        & quad (1 <= mu <= M),
      )
    )
    \
    =&
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
      #block(
        $
          because & hat(Y)"の定義より、"M"ズレは値が等しくなるので、"
          \ &
          hat(Y)_((mu)) = hat(Y)_((M + mu)),
          \ &
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
        $
      )
    )
    \
    [H_1^((plus.minus)), hat(Z)_mu^((minus.plus))]
    =&
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
    [H_1^((plus.minus)), hat(Y)_mu]
    =&
    -
    2
    dot.op
    (
      cases(
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
        & quad (mu <= -1),
        exp(
          -
          sqrt(-1)
          (2 pi (M - mu)) / M
        )
        dot.op
        hat(Z)_((-M + mu))^((plus.minus))
        & quad (1 <= mu <= M-1),
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Z)_((-mu))^((plus.minus))
        & quad (mu = M),
      )
    )
    \
    =&
    -
    2
    dot.op
    (
      cases(
        hat(Z)_((-M))^((plus.minus))
        & quad (mu = -M),
        exp(
          -
          sqrt(-1)
          (2 pi (-mu)) / M
        )
        dot.op
        hat(Z)_((mu))^((plus.minus))
        & quad (-M+1 <= mu <= -1),
        exp(
          -
          sqrt(-1)
          (2 pi (M - mu)) / M
        )
        dot.op
        hat(Z)_((-M + mu))^((plus.minus))
        & quad (1 <= mu <= M-1),
        hat(Z)_((-M))^((plus.minus))
        & quad (mu = M),
      )
    )
    \
    =&
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
    \
    =&
    -
    2
    dot.op
    (
      exp(
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      hat(Z)_((mu))^((plus.minus))
    )
    \ &
    (
      #block(
        $
          because & hat(Z)"の定義より、"M"ズレは値が等しくなるので、"
          \ &
          hat(Z)_((mu))^((plus.minus)) = hat(Z)_((-M + mu))^((plus.minus)),
          \ &
          exp(
            -
            sqrt(-1)
            (2 pi (M)) / M
          )
          dot.op
          hat(Z)_((-M))^((plus.minus))
          =
          1
          dot.op
          hat(Z)_((M - 2M))^((plus.minus))
          =
          exp(
            -
            sqrt(-1)
            (2 pi (-M)) / M
          )
          dot.op
          hat(Z)_((M))^((plus.minus))
        $
      )
    )
    \
    [H_2, hat(Z)_mu^((minus))]
    =&
    -2
    (  
      cases(
        hat(Y)_((-mu))
        & quad (mu = -M),
        hat(Y)_((M + mu))
        & quad (-M + 1 <= mu <= -1),
        hat(Y)_mu
        & quad (1 <= mu <= M),
      )
    )
    \
    =&
    -2
    dot.op
    hat(Y)_mu
    \
    & (
      because "同様"
    )
    \
    [H_2, hat(Z)_mu^((plus))]
    =&
    -2
    (
      cases(
        hat(Y)_((-mu))
        & quad (mu = -M),
        hat(Y)_((M + mu))
        & quad (-M + 1 <= mu <= -1),
        hat(Y)_mu
        & quad (1 <= mu <= M),
      )
    )
    \
    &quad +
    1/M
    (  
      sum_(j in {1, dots.c, M}) (
        -2
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            (-j)
            +
            mu
          )
        )
        dot.op
        hat(Y)_j
      )
    )
    \
    =&
    -2
    dot.op
    hat(Y)_mu
    \
    &quad +
    1/M
    (  
      sum_(j in {1, dots.c, M}) (
        -2
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            (-j)
            +
            mu
          )
        )
        dot.op
        hat(Y)_j
      )
    )
    \
    [H_2, hat(Y)_mu]
    =&
    2
    dot.op
    (
      cases(
        hat(Z)_(mu)^((-))
        & quad (mu <= -1),
        hat(Z)_((-M + mu))^((-))
        & quad (1 <= mu <= M-1),
        hat(Z)_((-mu))^((-))
        & quad (mu = M),
      )
    )
    \
    =&
    2
    dot.op
    hat(Z)_(mu)^((-))
  $

  #note[
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
      \
      [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((plus.minus))]_(+) &= 2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      \
      [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((minus.plus))]_(+) &= underbrace(
        2M delta^M_(mu + nu, 0)
        I_((CC^2)^(times.o M))
        ,
        [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((plus.minus))]_(+)
        )
        +
        (
          -2
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              mu
              +
              nu
            )
          )
          dot.op
          2I_((CC^2)^(times.o M))
        )
      \
      [hat(Z)_mu^((plus.minus)), hat(Y)_nu]_(+) &= 0
      \
      [hat(Y)_mu, hat(Y)_nu]_(+) &= 2M delta^M_(mu + nu, 0) I
      \
      sum_(j=1)^M exp(k dot (2 pi sqrt(-1) j)/M) &= M delta^M_((k, 0))
    $
  ]
  #proof[
    1. $[H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]$について、
    $mu in cal(M)$について、
    $
    [H_1^((plus.minus)), hat(Z)_mu^((plus.minus))]
    &=
    [
      overbrace(
        1/M sum_(j in {1, dots.c, M}) (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
        ),
        H_1^((plus.minus))
      )
      ,
      hat(Z)_mu^((plus.minus))
    ]
    \
    &=
    1/M
    (
      (
        sum_(j in {1, dots.c, M}) (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
        )
      )
      dot.op
      hat(Z)_mu^((plus.minus))
      -
      hat(Z)_mu^((plus.minus))
      dot.op
      (
        sum_(j in {1, dots.c, M}) (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
        )
      )
    )
    \
    &=
    1/M
    (
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((plus.minus))
        )
      )
      -
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Z)_mu^((plus.minus))
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
      (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((plus.minus))
        )
        -
        (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Z)_mu^((plus.minus))
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        (  
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((plus.minus))
          -
          hat(Z)_mu^((plus.minus))
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        (  
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((plus.minus))
          +
          hat(Y)_j
          hat(Z)_mu^((plus.minus))
          hat(Z)_(-j)^((plus.minus))
        )
      )
    )
    quad
    (
      because #ref(<anticommutator_of_hat_Z_and_hat_Y>)
      "より、"hat(Z)_mu^((plus.minus)) hat(Y)_j = -hat(Y)_j hat(Z)_mu^((plus.minus)) 
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (  
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((plus.minus))
          +
          hat(Z)_mu^((plus.minus))
          hat(Z)_(-j)^((plus.minus))
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        [
          hat(Z)_(-j)^((plus.minus)),
          hat(Z)_mu^((plus.minus))
        ]_(+)
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (
          2M
          dot.op
          delta^M_((-j) + mu, 0)
          dot.op
          I_((CC^2)^(times.o M))
        )
      )
    )
    quad (
      because #ref(<anticommutator_of_hat_Z_and_hat_Y>)
    )
    \
    &=
    2
    dot.op
    (
      sum_(j in {1, dots.c, M}) (
        (
          delta^M_((-j) + mu, 0)
        )
        dot.op
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        I_((CC^2)^(times.o M))
      )
    )
    \
    &=
    2
    dot.op
    (
      sum_(
        j in {1, dots.c, M} \
        (-j) + mu equiv 0 mod M
      ) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
      )
    )
    \
    &note(
      &(-j+mu = 2M, M, 0, -M, -2M)\
      &(
          mu - j = cases(
            2M,
            M,
            0,
            -M,
            -2M
          )
          \
          j - mu = cases(
            2M,
            M,
            0,
            -M,
            -2M
          )
          \
          j = cases(
            2M + mu,
            M + mu,
            0 + mu,
            -M + mu,
            -2M + mu
          )
          \
          j = cases(
            -mu & quad (mu = -M),
            M + mu & quad (-M + 1 <= mu <= -1),
            mu & quad (1 <= mu <= M),
          )
      )
      \
    )
    \
    &=
    2
    dot.op
    (
      sum_(
        cases(
          j = M & quad (mu = -M),
          j = M + mu & quad (-M + 1 <= mu <= -1),
          j = mu & quad (1 <= mu <= M),
        )
      ) (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
      )
    )
    \
    &=
    2
    dot.op
    (
      cases(
        exp(
          -
          sqrt(-1)
          (2 pi M) / M
        )
        dot.op
        hat(Y)_M
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
        hat(Y)_mu
        & quad (1 <= mu <= M),
      )
    )
    \
    &=
    2
    dot.op
    (
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      hat(Y)_mu
    )
    \
    qed
    $

    $2. [H_1^((plus.minus)), hat(Z)_mu^((minus.plus))]$について、

    $mu in cal(M)$について、

    $
      [H_1^((plus.minus)), hat(Z)_mu^((minus.plus))]
      &=
      [
        overbrace(
          1/M sum_(j in {1, dots.c, M}) (
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
          ),
          H_1^((plus.minus))
        )
        ,
        hat(Z)_mu^((minus.plus))
      ]
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        [
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          ,
          hat(Z)_mu^((minus.plus))
        ]
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        [
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          ,
          hat(Z)_mu^((minus.plus))
        ]
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((minus.plus))
          -
          hat(Z)_mu^((minus.plus))
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
        )
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((minus.plus))
          -
          hat(Z)_mu^((minus.plus))
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
        )
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        (
          hat(Y)_j
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((minus.plus))
          +
          hat(Y)_j
          hat(Z)_mu^((minus.plus))
          hat(Z)_(-j)^((plus.minus))
        )
      )
      quad
      (
        because #ref(<anticommutator_of_hat_Z_and_hat_Y>)
        "より、"hat(Z)_mu^((minus.plus)) hat(Y)_j = -hat(Y)_j hat(Z)_mu^((minus.plus))
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (
          hat(Z)_(-j)^((plus.minus))
          hat(Z)_mu^((minus.plus))
          +
          hat(Z)_mu^((minus.plus))
          hat(Z)_(-j)^((plus.minus))
        )
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        [
          hat(Z)_(-j)^((plus.minus)),
          hat(Z)_mu^((minus.plus))
        ]_(+)
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (
          underbrace(
            2M delta^M_((-j) + mu, 0)
            I_((CC^2)^(times.o M))
            ,
            [hat(Z)_(-j)^((plus.minus)), hat(Z)_mu^((plus.minus))]_(+)
          )
          +
          (
            -2
            exp(
              -
              sqrt(-1)
              (2 pi) / M
              (
                (-j)
                +
                mu
              )
            )
            dot.op
            2I_((CC^2)^(times.o M))
          )
        )
      )
      \
      &=
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (
          2M delta^M_((-j) + mu, 0)
          I_((CC^2)^(times.o M))
        )
      )
      \
      &
      quad
      quad
      +
      1/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        (
          -2
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              (-j)
              +
              mu
            )
          )
          dot.op
          2I_((CC^2)^(times.o M))
        )
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      \
      &
      quad
      quad
      -
      4/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
          -
          sqrt(-1)
          (2 pi) / M
          (
            (-j)
            +
            mu
          )
        )
        dot.op
        hat(Y)_j
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_j
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      sum_(j in {1, dots.c, M})
      (
        hat(Y)_j
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      sum_(j in {1, dots.c, M})
      (
        sum_(k=1)^M (
          Y_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi j) / M
          )
        )
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      sum_(k=1)^M (
      sum_(j in {1, dots.c, M})
      (
          Y_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi j) / M
          )
        )
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      sum_(k=1)^M (
      Y_k 
      dot.op
      sum_(j in {1, dots.c, M})
      (
          exp(
            -
            k
            sqrt(-1)
            (2 pi j) / M
          )
        )
      )
      \
      &=
      2
      sum_(j in {1, dots.c, M})
      (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
        )
        dot.op
        hat(Y)_j
        dot.op
        delta^M_((-j) + mu, 0)
      )
      -
      4/M
      exp(
        -
        sqrt(-1)
        (2 pi mu) / M
      )
      dot.op
      sum_(k=1)^M (
        Y_k 
        dot.op
        M delta^M_((k, 0))
      )
      quad
      ( because #ref(<exp_sum>) )

      \
      &
      #note[
        $
          (-j) + mu equiv 0 mod M
          \
          (-j) + mu = cases(
            0,
            M,
            2M,
            -M,
            -2M
          )
          \
          -j = cases(
            0 - mu,
            M - mu,
            2M - mu,
            -M - mu,
            -2M - mu,
          )
          \
          j = cases(
            mu & (1 <= mu <= M),
            #strike[-M + mu],
            #strike[-2M + mu],
            M + mu & (-M + 1 <= mu <= -1),
            2M + mu & (mu = -M),
          )
        $
      ]
      \
      &=
      2
      cases(
        exp(
          -
          sqrt(-1)
          (2 pi (2M + mu)) / M
        )
        dot.op
        hat(Y)_((2M + mu))
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
        hat(Y)_mu
        & quad (1 <= mu <= M),
      )
      -
      0
      \
      &=
      2
      dot.op
      (
        exp(
          -
          sqrt(-1)
          (2 pi mu) / M
        )
        dot.op
        hat(Y)_mu
      )
      
    $


    $2. [H_1^((plus.minus)), hat(Y)_mu]$について、

    $mu in cal(M)$について、

    $
      [H_1^((plus.minus)), hat(Y)_mu]
      &=
      [
        overbrace(
          1/M sum_(j in {1, dots.c, M}) (
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
          ),
          H_1^((plus.minus))
        )
        ,
        hat(Y)_mu
      ] \ &quad ("note": "交換関係カッコはなるべく外さずに進めた方が計算見やすそう")
      \
      &=
      1/M
      (
        (
          sum_(j in {1, dots.c, M}) (
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
          )
        )
        dot.op
        hat(Y)_mu
        -
        hat(Y)_mu
        dot.op
        (
          sum_(j in {1, dots.c, M}) (
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
          )
        )
      )
      \
      &=
      1/M
      (
        (
          sum_(j in {1, dots.c, M}) (
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
            dot.op
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            hat(Y)_mu
          )
        )
        -
        (
          sum_(j in {1, dots.c, M}) (
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
            dot.op
            hat(Y)_mu
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
          )
        )
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          (
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
            dot.op
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            hat(Y)_mu
          )
          -
          (
            exp(
              -
              sqrt(-1)
              (2 pi j) / M
            )
            dot.op
            hat(Y)_mu
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
          )
        ) 
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          (
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
            hat(Y)_mu
            -
            hat(Y)_mu
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
          )
        ) 
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          (
            -
            hat(Y)_j
            hat(Y)_mu
            hat(Z)_(-j)^((plus.minus))
            -
            hat(Y)_mu
            hat(Y)_j
            hat(Z)_(-j)^((plus.minus))
          )
        ) 
      )
      quad
      (
        because #ref(<anticommutator_of_hat_Z_and_hat_Y>)
        "より、"hat(Z)_(-j)^((plus.minus)) hat(Y)_mu = -hat(Y)_mu hat(Z)_(-j)^((plus.minus))
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          (
            -
            hat(Y)_j
            hat(Y)_mu
            -
            hat(Y)_mu
            hat(Y)_j
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          (
            -
            [
              hat(Y)_j,
              hat(Y)_mu
            ]_(+)
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &=
      1/M
      (
        sum_(j in {1, dots.c, M}) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          (
            -
            2M delta^M_(j + mu, 0)
            dot.op
            I_((CC^2)^(times.o M))
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &=
      -
      2
      dot.op
      (
        sum_(j in {1, dots.c, M}) (
          delta^M_(j + mu, 0)
          dot.op
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &note(
        &(j+mu = 2M, M, 0, -M, -2M)\
        &(
            cases(
              mu = -M => j = M,
              mu = -M + 1 => j = M - 1,
              ...,
              mu = -1 => j = 1,
              mu = 1 => j = M - 1,
              mu = 2 => j = M - 2,
              ...,
              mu = M - 1 => j = 1,
              mu = M => j = M
            )
        )
      )
      \
      &=
      -
      2
      dot.op
      (
        sum_(
          underbrace(
          cases(
            j = -mu & quad (mu <= -1),
            j = M - mu & quad (1 <= mu <= M-1),
            j = M & quad (mu = M),
          ),
          )
        ) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &=
      -
      2
      dot.op
      (
        sum_(
          cases(
            j = -mu & quad (mu <= -1),
            j = M - mu & quad (1 <= mu <= M-1),
            j = M & quad (mu = M),
          )
        ) (
          exp(
            -
            sqrt(-1)
            (2 pi j) / M
          )
          dot.op
          hat(Z)_(-j)^((plus.minus))
        ) 
      )
      \
      &=
      -
      2
      dot.op
      (
        cases(
          exp(
            -
            sqrt(-1)
            (2 pi (-mu)) / M
          )
          dot.op
          hat(Z)_(-(-mu))^((plus.minus))
          & quad (mu <= -1),
          exp(
            -
            sqrt(-1)
            (2 pi (M - mu)) / M
          )
          dot.op
          hat(Z)_(-(M - mu))^((plus.minus))
          & quad (1 <= mu <= M-1),
          exp(
            -
            sqrt(-1)
            (2 pi M) / M
          )
          dot.op
          hat(Z)_(-M)^((plus.minus))
          & quad (mu = M),
        )
      )
      \
      qed
    $

    $3. [H_2, hat(Z)_mu^((plus.minus))]$について、

    $mu in cal(M)$について、

    $
      [H_2, hat(Z)_mu^((plus.minus))]
      &=
      [
        overbrace(
          1/M sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
          ),
          H_2
        )
        ,
        hat(Z)_mu^((plus.minus))
      ]
      \
      &=
      1/M
      (
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
          )
        )
        dot.op
        hat(Z)_mu^((plus.minus))
        -
        hat(Z)_mu^((plus.minus))
        dot.op
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
          )
        )
      )
      \
      &=
      1/M
      (
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
          )
        )
        dot.op
        hat(Z)_mu^((plus.minus))
        -
        hat(Z)_mu^((plus.minus))
        dot.op
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
          )
        )
      )
      \
      &=
      1/M
      (
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_(-j)^((-))
            hat(Y)_j
            hat(Z)_mu^((plus.minus))
          )
        )
        -
        (
          sum_(j in {1, dots.c, M}) (
            hat(Z)_mu^((plus.minus))
            hat(Z)_(-j)^((-))
            hat(Y)_j
          )
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          hat(Z)_(-j)^((-))
          hat(Y)_j
          hat(Z)_mu^((plus.minus))
          -
          hat(Z)_mu^((plus.minus))
          hat(Z)_(-j)^((-))
          hat(Y)_j
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          -
          hat(Z)_(-j)^((-))
          hat(Z)_mu^((plus.minus))
          hat(Y)_j
          -
          hat(Z)_mu^((plus.minus))
          hat(Z)_(-j)^((-))
          hat(Y)_j
        )
      )
      quad
      (
        because #ref(<anticommutator_of_hat_Z_and_hat_Y>)
        "より、"hat(Z)_mu^((plus.minus)) hat(Y)_j = -hat(Y)_j hat(Z)_mu^((plus.minus))
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            hat(Z)_(-j)^((-))
            hat(Z)_mu^((plus.minus))
            -
            hat(Z)_mu^((plus.minus))
            hat(Z)_(-j)^((-))
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            [
              hat(Z)_(-j)^((-)),
              hat(Z)_mu^((plus.minus))
            ]_(+)
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
            underbrace(
            (
              -
              [
                hat(Z)_mu^((plus.minus)),
                hat(Z)_(-j)^((-))
              ]_(+)
            )
            ,
            hat(Z)"の符号によって計算結果が分岐する"
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
    $

    $quad 3.1. [H_2, hat(Z)_mu^((minus))]$について、

    $
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            [
              hat(Z)_mu^((minus)),
              hat(Z)_(-j)^((-))
            ]_(+)
          ) 
          dot.op
          hat(Y)_j
        )
      )
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            2M delta^M_((-j) + mu, 0)
            I_((CC^2)^(times.o M))
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (  
        sum_(j in {1, dots.c, M}) (
          (
            delta^M_((-j) + mu, 0)
            I_((CC^2)^(times.o M))
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (  
        sum_(j in {1, dots.c, M}) (
          (
            delta^M_((-j) + mu, 0)
            I_((CC^2)^(times.o M))
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (  
        sum_(
          cases(
            j = M & quad (mu = -M),
            j = M + mu & quad (-M + 1 <= mu <= -1),
            j = mu & quad (1 <= mu <= M),
          )
        ) (
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (  
        cases(
          hat(Y)_M
          & quad (mu = -M),
          hat(Y)_((M + mu))
          & quad (-M + 1 <= mu <= -1),
          hat(Y)_mu
          & quad (1 <= mu <= M),
        )
      )
    $

    $quad 3.2. [H_2, hat(Z)_mu^((plus))]$について、

    $
      &1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            [
              hat(Z)_mu^((plus)),
              hat(Z)_(-j)^((-))
            ]_(+)
          ) 
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            underbrace(
              2M delta^M_((-j) + mu, 0)
              I_((CC^2)^(times.o M))
              ,
              [hat(Z)_mu^((plus.minus)), hat(Z)_((-j))^((plus.minus))]_(+)
            )
            +
            (
              -2
              exp(
                -
                sqrt(-1)
                (2 pi) / M
                (
                  (-j)
                  +
                  mu
                )
              )
              dot.op
              2I_((CC^2)^(times.o M))
            )
          )
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          (
            -
            2M delta^M_((-j) + mu, 0)
            dot.op
            hat(Y)_j
            +
            (
              -2
              exp(
                -
                sqrt(-1)
                (2 pi) / M
                (
                  (-j)
                  +
                  mu
                )
              )
              dot.op
              hat(Y)_j
            )
          )
        )
      )
      \
      &=
      1/M
      (  
        sum_(
          cases(
            j = M & quad (mu = -M),
            j = M + mu & quad (-M + 1 <= mu <= -1),
            j = mu & quad (1 <= mu <= M),
          )
        ) (
          -
          2M
          dot.op
          hat(Y)_j
        )
        +
        sum_(j in {1, dots.c, M}) (
          -2
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              (-j)
              +
              mu
            )
          )
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (
        sum_(
          cases(
            j = M & quad (mu = -M),
            j = M + mu & quad (-M + 1 <= mu <= -1),
            j = mu & quad (1 <= mu <= M),
          )
        ) (
          hat(Y)_j
        )
      )
      +
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          -2
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              (-j)
              +
              mu
            )
          )
          dot.op
          hat(Y)_j
        )
      )
      \
      &=
      -2
      (
        cases(
          hat(Y)_M
          & quad (mu = -M),
          hat(Y)_((M + mu))
          & quad (-M + 1 <= mu <= -1),
          hat(Y)_mu
          & quad (1 <= mu <= M),
        )
      )
      +
      1/M
      (  
        sum_(j in {1, dots.c, M}) (
          -2
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              (-j)
              +
              mu
            )
          )
          dot.op
          hat(Y)_j
        )
      )
      
    $

    $[H_2, hat(Y)_mu]$について、
    
    $
    &[H_2, hat(Y)_mu]
    \
    &=
    [
      overbrace(
        1/M sum_(j in {1, dots.c, M}) (
          hat(Z)_(-j)^((-))
          hat(Y)_j
        ),
        H_2
      )
      ,
      hat(Y)_mu
    ]
    \
    &=
    1/M
    (
      (
        sum_(j in {1, dots.c, M}) (
          hat(Z)_(-j)^((-))
          hat(Y)_j
        )
      )
      dot.op
      hat(Y)_mu
      -
      hat(Y)_mu
      dot.op
      (
        sum_(j in {1, dots.c, M}) (
          hat(Z)_(-j)^((-))
          hat(Y)_j
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        hat(Z)_(-j)^((-))
        hat(Y)_j
        hat(Y)_mu
      )
      -
      sum_(j in {1, dots.c, M}) (
        hat(Y)_mu
        hat(Z)_(-j)^((-))
        hat(Y)_j
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        hat(Z)_(-j)^((-))
        hat(Y)_j
        hat(Y)_mu
        -
        hat(Y)_mu
        hat(Z)_(-j)^((-))
        hat(Y)_j
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        hat(Z)_(-j)^((-))
        hat(Y)_j
        hat(Y)_mu
        +
        hat(Z)_(-j)^((-))
        hat(Y)_mu
        hat(Y)_j
      )
    )
    quad (because #ref(<anticommutator_of_hat_Z_and_hat_Y>))
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        hat(Z)_(-j)^((-))
        (
          hat(Y)_j
          hat(Y)_mu
          +
          hat(Y)_mu
          hat(Y)_j
        )
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        hat(Z)_(-j)^((-))
        [
          hat(Y)_j,
          hat(Y)_mu
        ]_(+)
      )
    )
    \
    &=
    1/M
    (
      sum_(j in {1, dots.c, M}) (
        2M delta^M_(j + mu, 0)
        dot.op
        hat(Z)_(-j)^((-))
      )
    )
    \
    &=
    2
    (
      sum_(
        cases(
          j = -mu & quad (mu <= -1),
          j = M - mu & quad (1 <= mu <= M-1),
          j = M & quad (mu = M),
        )
      ) (
        hat(Z)_(-j)^((-))
      )
    )
    \
    &=
    2
    (
      cases(
        hat(Z)_(mu)^((-))
        & quad (mu <= -1),
        hat(Z)_((-M + mu))^((-))
        & quad (1 <= mu <= M-1),
        hat(Z)_((-M))^((-))
        & quad (mu = M),
      )
    )
  
      
    $

  ]
]<commutator_of_H_and_Z_Y>
