#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$det A(theta_mu) = 1$])[
  $mu in cal(M)$について、

  $
    det A(theta_mu) = 1
  $

  すなわち、

  $
    gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu) = 1
  $

  $
    lambda_(plus, mu) dot.op lambda_(minus, mu) = 1
  $

  #proof[
    $#ref(<factorization_of_A_theta>)$ より、$A(theta_mu) = B_1(theta_mu) dot.op B_2 dot.op B_1(theta_mu)$ である。

    各行列の行列式を計算する:

    $
      det B_1(theta_mu)
      &=
      cosh^2(K_1)
      -
      (- sqrt(-1) e^(sqrt(-1) theta_mu) sinh(K_1))
      (sqrt(-1) e^(-sqrt(-1) theta_mu) sinh(K_1))
      \
      &=
      cosh^2(K_1)
      -
      sinh^2(K_1)
      \
      &=
      1
    $

    $
      det B_2
      &=
      cosh^2(2 K_2^*)
      -
      (sqrt(-1) sinh(2 K_2^*))
      (- sqrt(-1) sinh(2 K_2^*))
      \
      &=
      cosh^2(2 K_2^*)
      -
      sinh^2(2 K_2^*)
      \
      &=
      1
    $

    したがって、

    $
      det A(theta_mu)
      = det B_1(theta_mu) dot.op det B_2 dot.op det B_1(theta_mu)
      = 1 dot.op 1 dot.op 1
      = 1
    $

    $A(theta_mu)
    =
    mat(
      gamma_1(theta_mu),
      gamma_2(theta_mu);
      - gamma_2(-theta_mu),
      gamma_1(theta_mu);
    )
    $ であるから、

    $
      det A(theta_mu)
      &=
      gamma_1(theta_mu) dot.op gamma_1(theta_mu)
      -
      gamma_2(theta_mu) dot.op (- gamma_2(-theta_mu))
      \
      &=
      gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu)
      \
      &= 1
    $

    また、

    $
      lambda_(plus, mu) dot.op lambda_(minus, mu)
      &=
      (gamma_1(theta_mu) + sqrt(-gamma_2(theta_mu) gamma_2(-theta_mu)))
      (gamma_1(theta_mu) - sqrt(-gamma_2(theta_mu) gamma_2(-theta_mu)))
      \
      &=
      gamma_1(theta_mu)^2 - (-gamma_2(theta_mu) gamma_2(-theta_mu))
      \
      &=
      gamma_1(theta_mu)^2 + gamma_2(theta_mu) gamma_2(-theta_mu)
      \
      &= 1
    $
  ]
]<det_A_theta>
