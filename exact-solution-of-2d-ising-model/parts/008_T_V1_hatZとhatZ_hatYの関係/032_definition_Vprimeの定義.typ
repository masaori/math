#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition([$V'$の定義])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $
    V' := exp(
      +
      sum_(mu = 1)^M
      gamma(theta_mu)
      (
        psi_mu^dagger psi_(-mu) - 1/2
      )
    )
  $

  #note[
    この定義はホロノミック量子場の定義とは異なる。ホロノミック量子場では $psi_mu^dagger psi_mu$（同インデックス）が用いられ和の範囲も $mu in cal(M)$ 全体にわたるが、その場合 $psi_mu^dagger$ が $"ad"(X)$ の固有ベクトルにならないため $T_((V'))(psi_mu^dagger) = e^(gamma(theta_mu)) psi_mu^dagger$ が成り立たない。本定義では $psi_mu^dagger psi_(-mu)$（反転インデックス）を使い和を $mu in {1, dots, M}$ にとることで、この問題を回避している。
  ]
]<def_Vprime>
