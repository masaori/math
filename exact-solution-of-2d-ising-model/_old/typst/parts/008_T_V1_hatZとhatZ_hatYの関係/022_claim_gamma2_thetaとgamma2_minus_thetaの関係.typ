#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_2(theta)$と$gamma_2(-theta)$の関係])[
  $mu in cal(M)$について、

  $
    gamma_2(-theta_mu) = -overline(gamma_2(theta_mu))
  $

  ゆえに、
  $
    gamma_2(theta_mu) gamma_2(-theta_mu)
    &= 
    gamma_2(theta_mu) (-overline(gamma_2(theta_mu)))
    \
    &=
    - |gamma_2(theta_mu)|^2
  $

  #proof[
    $
      gamma_2(-theta_mu)
      &=
      sqrt(-1) e^(sqrt(-1) (-theta_mu)) s_2^* (c_1 cos (-theta_mu) - sqrt(-1) sin (-theta_mu) - s_1 c_2)
      \
      &=
      sqrt(-1) e^(-sqrt(-1) theta_mu) s_2^* (c_1 cos (theta_mu) + sqrt(-1) sin (theta_mu) - s_1 c_2)
    $

    $
      overline(gamma_2(theta_mu))
      &=
      overline((
        sqrt(-1) e^(sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu - sqrt(-1) sin theta_mu - s_1 c_2)
      ))
      \
      &=
      (overline(sqrt(-1)))
      (overline(
        e^(sqrt(-1) theta_mu)
      ))
      (overline(
        s_2^*
      ))
      (overline(
        c_1 cos theta_mu - sqrt(-1) sin theta_mu - s_1 c_2
      ))
      \
      &=
      (-sqrt(-1))
      (e^(-sqrt(-1) theta_mu))
      (s_2^*)
      (c_1 cos theta_mu + sqrt(-1) sin theta_mu - s_1 c_2)
      \
      &=
      -
      (
        sqrt(-1) e^(-sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu + sqrt(-1) sin theta_mu - s_1 c_2)
      )
      \
      &=
      -gamma_2(-theta_mu)
      \
      qed
    $
  ]
]<relation_of_gamma_2>
