#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$V$と$psi$の交換関係(B.13)])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $gamma_2(theta_mu) eq.not 0$ なる $mu in cal(M)$について（このとき $#ref(<def_fermi>)$ より $psi_mu, psi_mu^dagger$ が定義される）、

  $
    T_((V))(psi_mu^dagger)
    &=
    (
      (
        gamma_1(theta_(mu))
      )
      plus
      sqrt(
        -
        (
          gamma_2(theta_(mu))
        )
        (
          gamma_2(-theta_(mu))
        )
      )
    )
    psi_mu^dagger
    \
    T_((V))(psi_mu)
    &=
    (
      (
        gamma_1(theta_(mu))
      )
      minus
      sqrt(
        -
        (
          gamma_2(theta_(mu))
        )
        (
          gamma_2(-theta_(mu))
        )
      )
    )
    psi_mu
  $

  #proof[
    $#ref(<def_fermi>)$ より、

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
      dot.c
      P_mu
    $

    $T_((V))$ は $#ref(<mat_conj>)$ より線型写像であり、$P_mu$ の各成分は $hat(Z)_mu^((minus)), hat(Y)_mu$ に依らない複素数なので、

    $
      T_((V))
      (
        mat(
          psi_mu^dagger,
          psi_mu
        )
      )
      &=
      T_((V))
      (
        (
          hat(Z)_mu^((minus)),
          hat(Y)_mu
        )
        dot.c
        P_mu
      )
      \
      &=
      mat(
        T_((V))(hat(Z)_mu^((minus))),
        T_((V))(hat(Y)_mu)
      )
      dot.c
      P_mu
      quad (because T_((V)) "の線形性")
      \
      &=
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      A(theta_(mu))
      dot.c
      P_mu
      quad (because #ref(<T_V_hatZ_hatY>))
      \
      &=
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      (
        P_mu D_mu P_mu^(-1)
      )
      dot.c
      P_mu
      quad (because #ref(<eigenvector_of_A_theta>) "から得られる " A(theta_(mu)) = P_mu D_mu P_mu^(-1))
      \
      &=
      mat(
        hat(Z)_mu^((minus)),
        hat(Y)_mu
      )
      P_mu
      D_mu
      \
      &=
      mat(
        psi_mu^dagger,
        psi_mu
      )
      D_mu
      \
      &=
      mat(
        psi_mu^dagger,
        psi_mu
      )
      mat(
        lambda_(plus, mu), 0;
        0, lambda_(minus, mu)
      )
      \
      &=
      mat(
        lambda_(plus, mu) psi_mu^dagger,
        lambda_(minus, mu) psi_mu
      )
      \
      &=
      mat(
        (
          (
            gamma_1(theta_(mu))
          )
          plus
          sqrt(
            -
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        )
        psi_mu^dagger
        ,
        (
          (
            gamma_1(theta_(mu))
          )
          minus
          sqrt(
            -
            (
              gamma_2(theta_(mu))
            )
            (
              gamma_2(-theta_(mu))
            )
          )
        )
        psi_mu
      )
      quad (because #ref(<eigenvector_of_A_theta>))
      \
      qed
    $
  ]
]<commutation_V_psi>
