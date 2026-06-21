#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$hat(Z), hat(Y)$から$Z, Y$の復元])[
  #ref(<def_hatZ_hatY>) の記号のもと、
  $c_j := cases(-1 "if" j = 1, 1 "if" j != 1)$ とおく
  （これは $hat(Z)^((-))$ の重みである。すなわち $hat(Z)_mu^((-)) = sum_(j=1)^M c_j Z_j exp(- sqrt(-1) j (2 pi mu) / M)$）。

  各 $m in {1, dots.c, M}$ について、次が成り立つ。

  $
    sum_(mu=1)^M (
      hat(Y)_mu
      exp(
        sqrt(-1)
        m
        (2 pi mu) / M
      )
    )
    =
    M Y_m
  $

  $
    sum_(mu=1)^M (
      hat(Z)_mu^((-))
      exp(
        sqrt(-1)
        m
        (2 pi mu) / M
      )
    )
    =
    M c_m Z_m
  $

  ゆえに、$c_m in {-1, 1}$ より $1 \/ c_m = c_m$ であるから、

  $
    Y_m
    =
    1/M
    sum_(mu=1)^M (
      hat(Y)_mu
      exp(
        sqrt(-1)
        m
        (2 pi mu) / M
      )
    )
  $

  $
    Z_m
    =
    c_m/M
    sum_(mu=1)^M (
      hat(Z)_mu^((-))
      exp(
        sqrt(-1)
        m
        (2 pi mu) / M
      )
    )
  $

  #proof[
    $m in {1, dots.c, M}$ を任意に固定する。

    === 補題: $mu$ についての指数和の直交性

    $j in {1, dots.c, M}$ を固定する。$k := m - j$ とおくと $k in ZZ$ であり、
    #ref(<exp_sum>) の主張において和の変数を $j <-> mu$、定数を $k = m - j$ と読み替えることで、

    $
      sum_(mu=1)^M (
        exp(
          (m - j)
          dot
          (2 pi sqrt(-1) mu) / M
        )
      )
      =
      M
      delta^M_((m - j, 0))
      quad (because #ref(<exp_sum>))
    $

    が成り立つ。さらに $m, j in {1, dots.c, M}$ より $-(M - 1) <= m - j <= M - 1$、
    すなわち $abs(m - j) < M$ であるから、$m - j equiv 0 mod M$ であることと $m = j$ であることは同値である。
    したがって、

    $
      sum_(mu=1)^M (
        exp(
          (m - j)
          dot
          (2 pi sqrt(-1) mu) / M
        )
      )
      =
      cases(
        M & quad (j = m),
        0 & quad (j != m),
      )
      quad (because #ref(<exp_sum>))
    $

    が成り立つ（以下この等式を $(star)$ と呼ぶ）。

    === Step 1: $hat(Y)$ からの復元

    $
      sum_(mu=1)^M (
        hat(Y)_mu
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
      &=
      sum_(mu=1)^M (
        (
          sum_(j=1)^M (
            Y_j
            exp(
              -
              sqrt(-1)
              j
              (2 pi mu) / M
            )
          )
        )
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
      quad (because #ref(<def_hatZ_hatY>))
      \
      &=
      sum_(mu=1)^M (
        sum_(j=1)^M (
          Y_j
          exp(
            sqrt(-1)
            (m - j)
            (2 pi mu) / M
          )
        )
      )
      quad (because "指数法則")
      \
      &=
      sum_(j=1)^M (
        Y_j
        sum_(mu=1)^M (
          exp(
            (m - j)
            dot
            (2 pi sqrt(-1) mu) / M
          )
        )
      )
      quad (because "有限二重和の順序交換")
      \
      &=
      sum_(j=1)^M (
        Y_j
        dot
        cases(
          M & quad (j = m),
          0 & quad (j != m),
        )
      )
      quad (because (star))
      \
      &=
      M Y_m
    $

    === Step 2: $hat(Z)^((-))$ からの復元

    $
      sum_(mu=1)^M (
        hat(Z)_mu^((-))
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
      &=
      sum_(mu=1)^M (
        (
          sum_(j=1)^M (
            c_j
            Z_j
            exp(
              -
              sqrt(-1)
              j
              (2 pi mu) / M
            )
          )
        )
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
      quad (because #ref(<def_hatZ_hatY>))
      \
      &=
      sum_(mu=1)^M (
        sum_(j=1)^M (
          c_j
          Z_j
          exp(
            sqrt(-1)
            (m - j)
            (2 pi mu) / M
          )
        )
      )
      quad (because "指数法則")
      \
      &=
      sum_(j=1)^M (
        c_j
        Z_j
        sum_(mu=1)^M (
          exp(
            (m - j)
            dot
            (2 pi sqrt(-1) mu) / M
          )
        )
      )
      quad (because "有限二重和の順序交換")
      \
      &=
      sum_(j=1)^M (
        c_j
        Z_j
        dot
        cases(
          M & quad (j = m),
          0 & quad (j != m),
        )
      )
      quad (because (star))
      \
      &=
      M c_m Z_m
    $

    === Step 3: 復元式

    Step 1 で得た等式の両辺を $M$ で割って、

    $
      Y_m
      =
      1/M
      sum_(mu=1)^M (
        hat(Y)_mu
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
    $

    を得る。Step 2 で得た等式の両辺を $M$ で割ると、

    $
      c_m
      Z_m
      =
      1/M
      sum_(mu=1)^M (
        hat(Z)_mu^((-))
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
    $

    となる。両辺に $c_m$ を掛けると、$c_m in {-1, 1}$ より $c_m^2 = 1$ であるから、

    $
      Z_m
      =
      c_m/M
      sum_(mu=1)^M (
        hat(Z)_mu^((-))
        exp(
          sqrt(-1)
          m
          (2 pi mu) / M
        )
      )
      quad (because c_m^2 = 1)
    $

    を得る。

    $qed$
  ]
]<recover_Z_Y_from_hatZ_hatY>
