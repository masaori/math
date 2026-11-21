/-
`claim_eighth_root_exists` の具体版が必要十分版の特殊化であることの導出。
`K := Qbar` と置き、二の平方根と虚数単位は具体版の存在の主張から、`2 ≠ 0` は `ℚ` が部分体であることから、
零でない元の右逆元は体の逆元から与える。
-/
import Ising2DLambda.FisherZero.EighthRootExists
import Ising2DLambda.NecSuf.FisherZero.EighthRootExists

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_eighth_root_exists` の具体版を必要十分版から導く。 -/
theorem eighthRoot_exists_from_necSuf : ∃ zeta : Qbar, zeta ^ 4 = -1 :=
  Ising2DLambda.NecSuf.FisherZero.eighthRoot_exists_necSuf sqrtTwo_exists imaginaryUnit_exists
    two_ne_zero (fun a ha => ⟨a⁻¹, mul_inv_cancel₀ ha⟩)

end Ising2DLambda.FisherZero
