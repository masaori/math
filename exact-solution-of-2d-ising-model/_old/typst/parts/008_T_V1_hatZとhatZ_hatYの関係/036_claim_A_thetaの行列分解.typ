#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$A(theta_mu)$の行列分解])[
  $mu in cal(M)$について、

  $
    B_1(theta_mu)
    &:=
    mat(
      cosh(K_1),
      - sqrt(-1)
      exp(
        sqrt(-1)
        theta_mu
      )
      sinh(K_1);
      sqrt(-1)
      exp(
        -
        sqrt(-1)
        theta_mu
      )
      sinh(K_1),
      cosh(K_1);
    )
    \
    B_2
    &:=
    mat(
      cosh(2 K_2^*),
      sqrt(-1)
      sinh(2 K_2^*);
      -
      sqrt(-1)
      sinh(2 K_2^*),
      cosh(2 K_2^*);
    )
  $

  とおくと、

  $
    A(theta_mu) = B_1(theta_mu) dot.op B_2 dot.op B_1(theta_mu)
  $

  #proof[
    $#ref(<calc_of_TxT_hatZxhatY>)$ より、$T_((V_1^((plus.minus)))^(1/2))$ は $(hat(Z)_mu^((minus)), hat(Y)_mu)$ に右から $B_1(theta_mu)$ を掛ける作用をし、$T_((V_2))$ は右から $B_2$ を掛ける作用をする。

    $T_((V))$ の作用は $T_((V_1^((plus.minus)))^(1/2)) compose T_((V_2)) compose T_((V_1^((plus.minus)))^(1/2))$ であるから、

    $
      (T_((V))(hat(Z)_mu^((minus))), T_((V))(hat(Y)_mu))
      &=
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      dot.op
      B_1(theta_mu) dot.op B_2 dot.op B_1(theta_mu)
    $

    一方、$A(theta_mu)$の定義より、

    $
      (T_((V))(hat(Z)_mu^((minus))), T_((V))(hat(Y)_mu))
      &=
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      dot.op
      A(theta_mu)
    $

    $hat(Z)_mu^((minus)), hat(Y)_mu$ は線型独立であるから、$A(theta_mu) = B_1(theta_mu) dot.op B_2 dot.op B_1(theta_mu)$ である。
  ]
]<factorization_of_A_theta>
