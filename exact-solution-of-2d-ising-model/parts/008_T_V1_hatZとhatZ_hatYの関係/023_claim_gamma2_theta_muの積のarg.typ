#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_2(theta_mu)$$gamma_2(-theta_mu)$])[
  $gamma_2(theta_mu) eq.not 0$ なる $mu in cal(M)$について、

  $
    arg^([0, 2pi))(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) = pi
  $

  #proof[
    $gamma_2(theta_mu) eq.not 0$ なる $mu in cal(M)$について、

    $
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      &=
      (
        sqrt(-1) e^(sqrt(-1) (theta_mu)) s_2^* (c_1 cos (theta_mu) - sqrt(-1) sin (theta_mu) - s_1 c_2)
      )
      (
        sqrt(-1) e^(sqrt(-1) (-theta_mu)) s_2^* (c_1 cos (-theta_mu) - sqrt(-1) sin (-theta_mu) - s_1 c_2)
      )
      \
      &=
      underbrace(
        (
          sqrt(-1)
          dot.op
          sqrt(-1)
        )
        (
          e^((sqrt(-1) (theta_mu) + sqrt(-1) (-theta_mu)))
        )
        ,
        minus 1
      )
      (
        s_2^* (c_1 cos (theta_mu) - sqrt(-1) sin (theta_mu) - s_1 c_2)
      )
      (
        s_2^* (c_1 cos (theta_mu) + sqrt(-1) sin (theta_mu) - s_1 c_2)
      )
      \
      &=
      underbrace(
        (
          -1
        )
        (
          e^(0)
        )
        ,
        minus 1
      )
      (
        s_2^* (c_1 cos (theta_mu) - sqrt(-1) sin (theta_mu) - s_1 c_2)
      )
      (
        s_2^* (c_1 cos (theta_mu) + sqrt(-1) sin (theta_mu) - s_1 c_2)
      )
      quad (because cos"は偶関数, "sin"は奇関数")
      \
      &=
      -
      (
        s_2^*
      )
      ^2
      (c_1 cos (theta_mu) - sqrt(-1) sin (theta_mu) - s_1 c_2)
      (c_1 cos (theta_mu) + sqrt(-1) sin (theta_mu) - s_1 c_2)
      \
      &=
      -
      (
        s_2^*
      )
      ^2
      (
        (c_1 cos (theta_mu) - s_1 c_2)^2
        +
        (sin (theta_mu))^2
      )
      \
      &=
      -
      (
        s_2^*
      )
      ^2
      (
        (c_1 cos ((2 pi mu)/(M)) - s_1 c_2)^2
        +
        (sin ((2 pi mu)/(M)))^2
      )
      quad (because theta_mu = (2 pi mu) / M)
    $

    ここで $s_2^* > 0$（$#ref(<def_transfer_matrix_symbols>)$）より $(s_2^*)^2 > 0$ である。また、$gamma_2(theta_mu)$ の定義より

    $
      abs(gamma_2(theta_mu))^2
      &=
      abs(sqrt(-1) e^(sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu - sqrt(-1) sin theta_mu - s_1 c_2))^2
      \
      &=
      (s_2^*)^2
      (
        (c_1 cos theta_mu - s_1 c_2)^2
        +
        (sin theta_mu)^2
      )
      quad (because abs(sqrt(-1)) = abs(e^(sqrt(-1) theta_mu)) = 1)
    $

    であり、$gamma_2(theta_mu) eq.not 0$ より $abs(gamma_2(theta_mu))^2 > 0$ であるから

    $
      (c_1 cos theta_mu - s_1 c_2)^2 + (sin theta_mu)^2
      =
      (abs(gamma_2(theta_mu))^2) / ((s_2^*)^2)
      > 0
    $

    である。したがって

    $
      gamma_2(theta_(mu)) gamma_2(-theta_(mu))
      =
      -
      (s_2^*)^2
      (
        (c_1 cos theta_mu - s_1 c_2)^2
        +
        (sin theta_mu)^2
      )
      < 0
    $

    すなわち $gamma_2(theta_(mu)) gamma_2(-theta_(mu))$ は負の実数である。負の実数の偏角は $pi$ であるから、

    $
      arg^([0, 2pi))(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) = pi
    $

    である。

    $qed$
  ]
]<arg_of_gamma_2_mu>
