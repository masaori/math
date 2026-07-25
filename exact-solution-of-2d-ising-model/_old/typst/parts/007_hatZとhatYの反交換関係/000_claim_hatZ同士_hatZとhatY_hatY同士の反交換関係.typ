#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$hat(Z)$と$hat(Y)$の反交換関係])[
  $
    [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((plus.minus))]_(+) = 2M delta^M_(mu + nu, 0) I
    quad ("複合同順")
    \
    [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((minus.plus))]_(+) = underbrace(
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
    quad ("複合同順")
    \
    [hat(Z)_mu^((plus.minus)), hat(Y)_nu]_(+) = 0
    \
    [hat(Y)_mu, hat(Y)_nu]_(+) = 2M delta^M_(mu + nu, 0) I
  $

  #proof[
    $
      [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((plus.minus))]_(+)
      &=
      [
        sum_(j=1)^M (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        ),
        sum_(k=1)^M (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      ]_(+)
      \
      &=
      (
        sum_(j=1)^M (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      dot.op
      (
        sum_(k=1)^M (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      \
      & quad +
      (
        sum_(k=1)^M (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      dot.op
      (
        sum_(j=1)^M (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
        dot.op
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      \
      & quad +
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
        dot.op
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      \
      & quad +
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
          dot.op
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      \
      & quad +
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          Z_k
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
          dot.op
          Z_j
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_j
          Z_k
          exp(
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
          )
        )
      )
      \
      & quad +
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          Z_k
          Z_j
          exp(
            -
            sqrt(-1)
            k
            (2 pi nu)/(M)
            -
            sqrt(-1)
            j
            (2 pi mu)/(M)
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_j
          Z_k
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              j mu
              +
              k nu
            )
          )
        )
      )
      \
      & quad +
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          Z_k
          Z_j
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              k nu
              +
              j mu
            )
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_j
          Z_k
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              j mu
              +
              k nu
            )
          )
        )
        \
        & quad +
        (
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          Z_k
          Z_j
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              k nu
              +
              j mu
            )
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_j
          Z_k
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              j mu
              +
              k nu
            )
          )
        )
        \
        & quad +
        (
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " k != 1,
              minus.plus 1 "if " k = 1
            )
          )
          dot.op
          Z_k
          Z_j
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              k nu
              +
              j mu
            )
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          cases(
            +1 "if " j != 1,
            minus.plus 1 "if " j = 1
          )
        )
        dot.op
        (
          cases(
            +1 "if " k != 1,
            minus.plus 1 "if " k = 1
          )
        )
        \
        & quad 
        dot.op
        (
          (
            Z_j
            Z_k
            exp(
              -
              sqrt(-1)
              (2 pi) / M
              (
                j mu
                +
                k nu
              )
            )
          )
          +
          (
            Z_k
            Z_j
            exp(
              -
              sqrt(-1)
              (2 pi) / M
              (
                k nu
                +
                j mu
              )
            )
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          cases(
            +1 "if " j != 1,
            minus.plus 1 "if " j = 1
          )
        )
        dot.op
        (
          cases(
            +1 "if " k != 1,
            minus.plus 1 "if " k = 1
          )
        )
        \
        & quad 
        dot.op
        (
          (
            Z_j
            Z_k
            exp(
              -
              sqrt(-1)
              (2 pi) / M
              (
                j mu
                +
                k nu
              )
            )
          )
          +
          (
            Z_k
            Z_j
            exp(
              -
              sqrt(-1)
              (2 pi) / M
              (
                j mu
                +
                k nu
              )
            )
          )
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          cases(
            +1 "if " j != 1,
            minus.plus 1 "if " j = 1
          )
        )
        dot.op
        (
          cases(
            +1 "if " k != 1,
            minus.plus 1 "if " k = 1
          )
        )
        dot.op
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            j mu
            +
            k nu
          )
        )
        dot.op
        (
          Z_j
          Z_k
          +
          Z_k
          Z_j
        )
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          cases(
            +1 "if " j != 1,
            minus.plus 1 "if " j = 1
          )
        )
        dot.op
        (
          cases(
            +1 "if " k != 1,
            minus.plus 1 "if " k = 1
          )
        )
        dot.op
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            j mu
            +
            k nu
          )
        )
        dot.op
        [
          Z_j
          ,
          Z_k
        ]_(+)
      )
      \
      &=
      sum_(j,k=1)^M (
        (
          cases(
            +1 "if " j != 1,
            minus.plus 1 "if " j = 1
          )
        )
        dot.op
        (
          cases(
            +1 "if " k != 1,
            minus.plus 1 "if " k = 1
          )
        )
        dot.op
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            j mu
            +
            k nu
          )
        )
        dot.op
        2I_((CC^2)^(times.o M)) delta^M_((j, k))
      )
      \
      &=
      sum_(j=1)^M (
        underbrace(
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          ,
          "符号がjに関わらず一致しているので" =1
        )
        dot.op
        exp(
          -
          sqrt(-1)
          (2 pi) / M
          (
            j mu
            +
            j nu
          )
        )
        dot.op
        2I_((CC^2)^(times.o M))
      )
      \
      &=
      sum_(j=1)^M (
        exp(
          -
          sqrt(-1)
          (2 pi j) / M
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
      &=
      2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      quad
      (because #ref(<exp_sum>))
    $

    $
      [hat(Z)_mu^((plus.minus)), hat(Z)_nu^((minus.plus))]_(+)

      &=
      sum_(j=1)^M (
        underbrace(
          (
            cases(
              +1 "if " j != 1,
              minus.plus 1 "if " j = 1
            )
          )
          dot.op
          (
            cases(
              +1 "if " j != 1,
              plus.minus 1 "if " j = 1
            )
          )
          ,
          j=1"の時のみ"-1", その他の場合は"+1
        )
        dot.op
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              j mu
              +
              j nu
            )
          )
          dot.op
          2I_((CC^2)^(times.o M))
        )
        \
        &=
        underbrace(
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
          ),
          j=1"の項を打ち消すために2回引く"
        )
        +
        sum_(j=1)^M (
          exp(
            -
            sqrt(-1)
            (2 pi) / M
            (
              j mu
              +
              j nu
            )
          )
          dot.op
          2I_((CC^2)^(times.o M))
        )
        \
        &=
        underbrace(
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
    $
    $[hat(Z)_mu^((plus.minus)), hat(Y)_nu]_(+), [hat(Y)_mu, hat(Y)_nu]_(+)$についても同様
  ]
]<anticommutator_of_hat_Z_and_hat_Y>
