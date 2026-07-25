#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition("フェルミオン", [
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $gamma_2(theta_mu) eq.not 0$ なる $mu in cal(M)$ についてのみ、$psi_mu, psi_mu^dagger in "Mat"(2, CC)^(times.o M)$を、

  $
    mat(
      psi_mu^dagger,
      psi_mu
    )
    :&=
    (
      hat(Z)_mu^((minus)),
      hat(Y)_mu
    )
    dot.c
    P_mu
    \
    &=
    (
      hat(Z)_mu^((minus)),
      hat(Y)_mu
    )
    dot.c
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
    (1) / (2 sqrt(M) gamma_2(-theta_(mu)))
    (
      (
        plus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      hat(Z)_mu^((minus))
      +
      (
        gamma_2(-theta_(mu))
      )
      hat(Y)_mu
      ,
      (
        minus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      hat(Z)_mu^((minus))
      +
      (
        gamma_2(-theta_(mu))
      )
      hat(Y)_mu
    )
    \
    &=
    (
      (
        plus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      /
      (
        2 sqrt(M) gamma_2(-theta_(mu))
      )
      hat(Z)_mu^((minus))
      +
      (1) / (2 sqrt(M))
      hat(Y)_mu
      ,
      (
        minus
        sqrt(
          -1
        )
        sqrt(
          gamma_2(theta_(mu))
          gamma_2(-theta_(mu))
        )
      )
      /
      (
        2 sqrt(M) gamma_2(-theta_(mu))
      )
      hat(Z)_mu^((minus))
      +
      (1) / (2 sqrt(M))
      hat(Y)_mu
    )
  $

  と定める。

  #note[
    上の定義は正規化因子 $(1) / (2 sqrt(M) gamma_2(-theta_(mu)))$ を含むため、$gamma_2(-theta_mu) eq.not 0$ すなわち $gamma_2(theta_mu) eq.not 0$（$#ref(<relation_of_gamma_2>)$ より両者は同値）のときにのみ意味をもつ。
    $gamma_2(theta_mu) = 0$ となる $mu in cal(M)$ については $P_mu$（$#ref(<diagonalization_P_D>)$）が定義されず、正規化因子 $(1) / gamma_2(-theta_(mu))$ が $0$ 除算となるため、#strong[$psi_mu, psi_mu^dagger$ は定義されない（存在しない）]。
    $#ref(<gamma_2_theta_is_0>)$ より $gamma_2(theta_mu) = 0$ となるのは $mu = plus.minus M$ かつ臨界条件 $c_1 = s_1 c_2$（$#ref(<critical_condition_c1_eq_s1_c2>)$ より Ising 臨界点 $sinh 2K_1 sinh 2K_2 = 1$ に対応）を満たす場合に限られる。特に臨界点では $psi_M, psi_M^dagger$ が存在しない。この $mu$ に対する $T_((V))$, $T_((V'))$ の作用は $#ref(<T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>)$ および $#ref(<T_V_eq_T_Vprime_on_hatZ_hatY>)$ の場合 2 で、フェルミオンを経由せず直接扱う。
  ]

  #note[
    #ref(<equation_of_a_theta_mu>) の Part A より、
    $arg^([0, 2pi))(gamma_2(-theta_mu))$ に応じて符号 $epsilon_mu in {plus 1, minus 1}$ が定まり、
    $
      (sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))) / (gamma_2(-theta_(mu)))
      =
      epsilon_mu dot.op a(theta_mu)
    $
    が成り立つ。よって、上記のフェルミオンの定義は

    $
      psi_mu^dagger
      &=
      (1) / (2 sqrt(M))
      (
        hat(Y)_mu
        +
        epsilon_mu dot.op sqrt(-1) a(theta_mu)
        hat(Z)_mu^((minus))
      )
      \
      psi_mu
      &=
      (1) / (2 sqrt(M))
      (
        hat(Y)_mu
        -
        epsilon_mu dot.op sqrt(-1) a(theta_mu)
        hat(Z)_mu^((minus))
      )
    $

    のようにも書ける。

    これは、ホロノミック量子場 付録B 式(B.11)(B.12) の定義とは
    - $a(theta_mu)$が逆数になっている
    - 領域に応じた符号 $epsilon_mu$ がある
    という違いがある。
  ]
])<def_fermi>
