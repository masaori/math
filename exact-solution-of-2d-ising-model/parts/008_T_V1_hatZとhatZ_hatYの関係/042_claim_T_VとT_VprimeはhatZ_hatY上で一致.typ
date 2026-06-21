#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$T_((V))$ と $T_((V'))$ は $hat(Z)^((minus)), hat(Y)$ 上で一致する])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  すべての $mu in cal(M)$ について、

  $
    T_((V))(hat(Z)_mu^((minus))) = T_((V'))(hat(Z)_mu^((minus))),
    quad
    T_((V))(hat(Y)_mu) = T_((V'))(hat(Y)_mu)
  $

  #proof[
    $mu in cal(M)$ を固定する。$T_((V))$ は $#ref(<def_T_V>)$ より3つの写像 $T_((V_1^((plus.minus)))^(1/2))$, $T_((V_2))$, $T_((V_1^((plus.minus)))^(1/2))$ の合成であり、各写像は $T_g$（$#ref(<def_T_g>)$）の形で $#ref(<mat_conj>)$ より線型写像であるから、線型写像の合成として $T_((V))$ も線型写像である。$T_((V'))$ は $T_g$（$#ref(<def_T_g>)$）の $g = V'$ の場合であり、$#ref(<def_Vprime>)$ より $V'$ は可逆であるから $#ref(<mat_conj>)$ より線型写像である。

    $gamma_2(theta_mu)$ が $0$ であるか否かで場合分けする。

    === 場合 1: $gamma_2(theta_mu) eq.not 0$

    このとき $#ref(<def_fermi>)$ より $psi_mu^dagger, psi_mu$ が定義され、

    $
      mat(
        psi_mu^dagger,
        psi_mu
      )
      =
      (
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      P_mu
    $

    が成り立つ。ここで $P_mu$ は $#ref(<diagonalization_P_D>)$ で与えられる $2 times 2$ 複素行列である。

    まず $P_mu$ が可逆であることを示す。$#ref(<diagonalization_P_D>)$ より

    $
      P_mu
      =
      (1) / (2 sqrt(M) gamma_2(-theta_(mu)))
      mat(
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))),
        minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)));
        gamma_2(-theta_(mu)),
        gamma_2(-theta_(mu))
      )
    $

    であるから、行列式は

    $
      det P_mu
      &=
      (1) / ((2 sqrt(M) gamma_2(-theta_(mu)))^2)
      (
        (plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))) gamma_2(-theta_(mu))
        -
        (minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))) gamma_2(-theta_(mu))
      )
      quad (because "2次行列式の定義")
      \
      &=
      (1) / ((2 sqrt(M) gamma_2(-theta_(mu)))^2)
      dot.op
      2 sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      gamma_2(-theta_(mu))
    $

    である。$#ref(<relation_of_gamma_2>)$ より $gamma_2(theta_mu) eq.not 0 <=> gamma_2(-theta_mu) eq.not 0$、ゆえ $gamma_2(theta_(mu)) gamma_2(-theta_(mu)) eq.not 0$ かつ $sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) eq.not 0$（$#ref(<square_of_sqrt>)$ より $(sqrt(z))^2 = z eq.not 0$ ゆえ $sqrt(z) eq.not 0$）である。よって $det P_mu eq.not 0$ であり $P_mu$ は可逆である。

    $P_mu$ の逆行列を $P_mu^(-1) = mat(q_(11), q_(12); q_(21), q_(22))$（各 $q_(i j) in CC$）とおくと、

    $
      (
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      &=
      (
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      P_mu P_mu^(-1)
      quad (because P_mu P_mu^(-1) = I)
      \
      &=
      mat(
        psi_mu^dagger,
        psi_mu
      )
      P_mu^(-1)
      quad (because #ref(<def_fermi>))
      \
      &=
      (
        q_(11) psi_mu^dagger + q_(21) psi_mu,
        q_(12) psi_mu^dagger + q_(22) psi_mu
      )
    $

    が成り立つ。すなわち

    $
      hat(Z)_mu^((minus)) = q_(11) psi_mu^dagger + q_(21) psi_mu,
      quad
      hat(Y)_mu = q_(12) psi_mu^dagger + q_(22) psi_mu
    $

    である。

    一方、$#ref(<commutation_V_psi>)$ と $#ref(<lambda_eq_exp_gamma>)$ より

    $
      T_((V))(psi_mu^dagger) = e^(gamma(theta_mu)) psi_mu^dagger,
      quad
      T_((V))(psi_mu) = e^(-gamma(theta_mu)) psi_mu
    $

    であり、$#ref(<action_of_T_Vprime_on_psi>)$ より

    $
      T_((V'))(psi_mu^dagger) = e^(gamma(theta_mu)) psi_mu^dagger,
      quad
      T_((V'))(psi_mu) = e^(-gamma(theta_mu)) psi_mu
    $

    である。したがって

    $
      T_((V))(psi_mu^dagger) = T_((V'))(psi_mu^dagger),
      quad
      T_((V))(psi_mu) = T_((V'))(psi_mu)
      quad (dots.c (star))
    $

    が成り立つ。これより、

    $
      T_((V))(hat(Z)_mu^((minus)))
      &=
      T_((V))(q_(11) psi_mu^dagger + q_(21) psi_mu)
      quad (because hat(Z)_mu^((minus)) = q_(11) psi_mu^dagger + q_(21) psi_mu)
      \
      &=
      q_(11) T_((V))(psi_mu^dagger) + q_(21) T_((V))(psi_mu)
      quad (because T_((V)) "の線型性、" #ref(<mat_conj>))
      \
      &=
      q_(11) T_((V'))(psi_mu^dagger) + q_(21) T_((V'))(psi_mu)
      quad (because (star))
      \
      &=
      T_((V'))(q_(11) psi_mu^dagger + q_(21) psi_mu)
      quad (because T_((V')) "の線型性、" #ref(<mat_conj>))
      \
      &=
      T_((V'))(hat(Z)_mu^((minus)))
      quad (because hat(Z)_mu^((minus)) = q_(11) psi_mu^dagger + q_(21) psi_mu)
    $

    が成り立つ。同様に、

    $
      T_((V))(hat(Y)_mu)
      &=
      T_((V))(q_(12) psi_mu^dagger + q_(22) psi_mu)
      quad (because hat(Y)_mu = q_(12) psi_mu^dagger + q_(22) psi_mu)
      \
      &=
      q_(12) T_((V))(psi_mu^dagger) + q_(22) T_((V))(psi_mu)
      quad (because T_((V)) "の線型性、" #ref(<mat_conj>))
      \
      &=
      q_(12) T_((V'))(psi_mu^dagger) + q_(22) T_((V'))(psi_mu)
      quad (because (star))
      \
      &=
      T_((V'))(q_(12) psi_mu^dagger + q_(22) psi_mu)
      quad (because T_((V')) "の線型性、" #ref(<mat_conj>))
      \
      &=
      T_((V'))(hat(Y)_mu)
      quad (because hat(Y)_mu = q_(12) psi_mu^dagger + q_(22) psi_mu)
    $

    が成り立つ。

    === 場合 2: $gamma_2(theta_mu) = 0$

    $T_((V))$ について、$#ref(<T_V_hatZ_hatY>)$ より

    $
      (T_((V))(hat(Z)_mu^((minus))), T_((V))(hat(Y)_mu))
      =
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      A(theta_mu)
    $

    であり、$#ref(<diagonalization_P_D>)$ より $gamma_2(theta_mu) = 0$ のとき $A(theta_mu) = I$（$2 times 2$ 単位行列）であるから、

    $
      (T_((V))(hat(Z)_mu^((minus))), T_((V))(hat(Y)_mu))
      &=
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      I
      quad (because #ref(<diagonalization_P_D>))
      \
      &=
      (hat(Z)_mu^((minus)), hat(Y)_mu)
    $

    すなわち

    $
      T_((V))(hat(Z)_mu^((minus))) = hat(Z)_mu^((minus)),
      quad
      T_((V))(hat(Y)_mu) = hat(Y)_mu
    $

    である。

    $T_((V'))$ について、$#ref(<T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>)$ より

    $
      T_((V'))(hat(Z)_mu^((minus))) = hat(Z)_mu^((minus)),
      quad
      T_((V'))(hat(Y)_mu) = hat(Y)_mu
    $

    である。したがって

    $
      T_((V))(hat(Z)_mu^((minus))) = hat(Z)_mu^((minus)) = T_((V'))(hat(Z)_mu^((minus))),
      quad
      T_((V))(hat(Y)_mu) = hat(Y)_mu = T_((V'))(hat(Y)_mu)
    $

    が成り立つ。

    === 結論

    場合 1, 2 いずれでも

    $
      T_((V))(hat(Z)_mu^((minus))) = T_((V'))(hat(Z)_mu^((minus))),
      quad
      T_((V))(hat(Y)_mu) = T_((V'))(hat(Y)_mu)
    $

    が成り立つ。$mu in cal(M)$ は任意であったから、主張が示された。

    $qed$
  ]
]<T_V_eq_T_Vprime_on_hatZ_hatY>
