#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition([$gamma(theta_mu)$の定義])[
  $mu in cal(M)$について、

  $gamma_1(theta_mu) >= 1$ より $"arccosh"(gamma_1(theta_mu))$ はwell-definedであり、

  $
    gamma(theta_mu) := "arccosh" (gamma_1(theta_mu)) in RR_(>= 0)
  $

  と定める。
]<def_gamma_theta_mu>

#claim([$lambda_(plus.minus, mu) = e^(plus.minus gamma(theta_mu))$])[
  $mu in cal(M)$について、

  $
    lambda_(plus, mu) = e^(gamma(theta_mu)), quad
    lambda_(minus, mu) = e^(-gamma(theta_mu))
  $

  #proof[
    $det A(theta_mu) = 1$ より $lambda_(plus, mu) dot.op lambda_(minus, mu) = 1$ である。

    $A(theta_mu)
    =
    mat(
      gamma_1(theta_mu),
      gamma_2(theta_mu);
      - gamma_2(-theta_mu),
      gamma_1(theta_mu);
    )
    $ のトレースは固有値の和に等しいから、

    $
      lambda_(plus, mu) + lambda_(minus, mu)
      &= "tr" A(theta_mu)
      \
      &= gamma_1(theta_mu) + gamma_1(theta_mu)
      \
      &= 2 gamma_1(theta_mu)
      \
      &>= 2
      quad (because gamma_1(theta_mu) >= 1)
    $

    $lambda_(plus, mu) dot.op lambda_(minus, mu) = 1 > 0$ かつ $lambda_(plus, mu) + lambda_(minus, mu) >= 2 > 0$ であるから、$lambda_(plus, mu), lambda_(minus, mu) > 0$ である。

    $lambda_(plus, mu) dot.op lambda_(minus, mu) = 1$ かつ $lambda_(plus, mu) >= lambda_(minus, mu) > 0$ より、
    $gamma(theta_mu) >= 0$ を用いて $lambda_(plus, mu) = e^(gamma(theta_mu))$, $lambda_(minus, mu) = e^(-gamma(theta_mu))$ と書ける。

    実際、

    $
      lambda_(plus, mu) + lambda_(minus, mu)
      = e^(gamma(theta_mu)) + e^(-gamma(theta_mu))
      = 2 cosh(gamma(theta_mu))
      = 2 gamma_1(theta_mu)
    $

    より $cosh(gamma(theta_mu)) = gamma_1(theta_mu)$ であり、定義と整合する。
  ]
]<lambda_eq_exp_gamma>
