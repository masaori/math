/-
# 実数の冪の包含は包含の冪に等しい（具体版を必要十分版から導く）

具体版 `ClaimRealInclusionPreservesPower.lean` の `real_inclusion_of_power`（人手 `real_inclusion_preserves_power`）を、
必要十分版 `Ising2D/NecSuf/MultiplicativeMapPreservesPower.lean` の `NecSuf.map_pow_of_map_one_of_map_mul'` の
`A := ℝ`、`B := ℂ`、`f := ι_{ℝ→ℂ}`（`Complex.ofReal`）の特殊化として得る。仮定の `f(1) = 1` は `Complex.ofReal_one`、
`f(ab) = f(a)f(b)` は具体版 `real_inclusion_mul`（人手 `real_inclusion_preserves_product`）を右辺から左辺へ使ったものである。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesPower
import Ising2D.NecSuf.MultiplicativeMapPreservesPower

namespace Ising2D

/-- `real_inclusion_of_power` を `NecSuf.map_pow_of_map_one_of_map_mul'` の `f := ι_{ℝ→ℂ}` として得る。 -/
theorem real_inclusion_of_power_of_necSuf (r : ℝ) (m : ℕ) : ((r ^ m : ℝ) : ℂ) = (r : ℂ) ^ m :=
  NecSuf.map_pow_of_map_one_of_map_mul' (fun x : ℝ => (x : ℂ)) Complex.ofReal_one
    (fun a b => (real_inclusion_mul a b).symm) r m

end Ising2D
