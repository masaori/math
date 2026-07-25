#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$A(theta)$の対角化 ($P_mu$, $D_mu$の定義)])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$について、

  $gamma_2(theta_mu) eq.not 0$のとき、$#ref(<eigenvector_of_A_theta>)$ の任意定数を $c = (1) / (2 sqrt(M) gamma_2(-theta_(mu)))$ と選んで、

  $
    P_mu
    :&=
    (1) / (2 sqrt(M) gamma_2(-theta_(mu)))
    mat(
      plus
      sqrt(
        -1
      )
      sqrt(
        gamma_2(theta_(mu))
        gamma_2(-theta_(mu))
      )
      ,
      minus
      sqrt(
        -1
      )
      sqrt(
        gamma_2(theta_(mu))
        gamma_2(-theta_(mu))
      );
      gamma_2(-theta_(mu))
      ,
      gamma_2(-theta_(mu))
    )
    \
    &=
    mat(
      (
        plus
        sqrt(-1)
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      )
      /
      (
        2 sqrt(M) gamma_2(-theta_(mu))
      )
      ,
      (
        minus
        sqrt(-1)
        sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
      )
      /
      (
        2 sqrt(M) gamma_2(-theta_(mu))
      )
      ;
      (1) / (2 sqrt(M))
      ,
      (1) / (2 sqrt(M))
    )
    \
    D_mu
    :&=
    mat(
      lambda_(plus, mu), 0;
      0, lambda_(minus, mu)
    )
  $

  #note[
    任意定数 $c$ をこの値に選ぶことで、$#ref(<def_fermi>)$ で定義するフェルミオン $psi_mu^dagger, psi_mu$ が反交換関係 $[psi_mu^dagger, psi_nu]_(+) = delta^M_(mu + nu, 0) I$ を満たすように正規化される（$#ref(<anticommutator_of_psi>)$ 参照）。
  ]

  とおけば、

  $
    A(theta_(mu))
    =
    P_mu
    D_mu
    P_mu
    ^
    (-1)
  $

  $gamma_2(theta_mu) = 0$のとき、$P_mu$ は定義されないが、

  $
    A(theta_(mu))
    =
    I "(単位行列)"
    quad (because #ref(<A_theta_is_identity_when_gamma2_zero>))
  $
]<diagonalization_P_D>
