#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition([$V'$の定義])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $
    V' := exp(
      +
      sum_(mu in {1, dots, M} : gamma_2(theta_mu) eq.not 0)
      gamma(theta_mu)
      (
        psi_mu^dagger psi_(-mu) - 1/2
      )
    )
  $

  ここで和は $gamma_2(theta_mu) eq.not 0$ を満たす $mu in {1, dots, M}$ にわたる。この $mu$ に対しては $#ref(<def_fermi>)$ と $#ref(<relation_of_gamma_2>)$（$gamma_2(theta_mu) eq.not 0 <=> gamma_2(-theta_mu) eq.not 0$）より $psi_mu^dagger, psi_(-mu)$ がともに定義されるため、和の各項は well-defined である。

  #note[
    和の範囲を $gamma_2(theta_mu) eq.not 0$ なる $mu in {1, dots, M}$ に限定するのは、$gamma_2(theta_mu) = 0$ となる $mu$ では $#ref(<def_fermi>)$ より $psi_mu, psi_mu^dagger$ が定義されず、項 $psi_mu^dagger psi_(-mu)$ が意味をもたないためである。$#ref(<gamma_2_theta_is_0>)$ より $gamma_2(theta_mu) = 0$ となる $mu in {1, dots, M}$ は臨界条件下の $mu = M$ に限られる。除外されるこの $mu$ については、$#ref(<T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>)$ の Step 1 より $gamma(theta_mu) = 0$（係数が $0$）であるから、仮に項が定義できたとしても $V'$ には寄与せず、限定によって一般性を失わない。除外された $mu$ に対する $T_((V'))$ の作用は $#ref(<T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>)$ で $hat(Z)_mu^((minus)), hat(Y)_mu$ を経由して直接扱う。
  ]

  #note[
    この定義はホロノミック量子場の定義とは異なる。ホロノミック量子場では $psi_mu^dagger psi_mu$（同インデックス）が用いられ和の範囲も $mu in cal(M)$ 全体にわたるが、その場合 $psi_mu^dagger$ が $"ad"(X)$ の固有ベクトルにならないため $T_((V'))(psi_mu^dagger) = e^(gamma(theta_mu)) psi_mu^dagger$ が成り立たない。本定義では $psi_mu^dagger psi_(-mu)$（反転インデックス）を使い和を $gamma_2(theta_mu) eq.not 0$ なる $mu in {1, dots, M}$ にとることで、この問題を回避している。
  ]
]<def_Vprime>
