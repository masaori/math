#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_1(theta_mu) >= 1$])[
  $mu in cal(M)$について、

  $
    gamma_1(theta_mu) >= 1
  $

  #proof[
    $gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu) = 1$ であり、

    $#ref(<relation_of_gamma_2>)$ より $gamma_2(theta_mu) gamma_2(-theta_mu) = -|gamma_2(theta_mu)|^2$ であるから、

    $
      gamma_1(theta_mu)^2
      &= 1 - gamma_2(theta_mu) gamma_2(-theta_mu)
      \
      &= 1 + |gamma_2(theta_mu)|^2
      \
      &>= 1
    $

    一方、$gamma_1(theta_mu) = c_1 c_2^* - s_1 s_2^* cos theta_mu$ である。

    $cos theta_mu <= 1$ であるから、

    $
      gamma_1(theta_mu)
      &= c_1 c_2^* - s_1 s_2^* cos theta_mu
      \
      &>= c_1 c_2^* - s_1 s_2^*
    $

    $cosh x > sinh x$ ($because e^x > 0$, $forall x in RR$) より $c_1 > s_1$ かつ $c_2^* > s_2^*$ であるから、

    $
      c_1 c_2^* > s_1 s_2^*
    $

    すなわち $c_1 c_2^* - s_1 s_2^* > 0$ である。

    よって $gamma_1(theta_mu) > 0$ であり、$gamma_1(theta_mu)^2 >= 1$ と合わせて $gamma_1(theta_mu) >= 1$ である。
  ]
]<gamma1_geq_1>
