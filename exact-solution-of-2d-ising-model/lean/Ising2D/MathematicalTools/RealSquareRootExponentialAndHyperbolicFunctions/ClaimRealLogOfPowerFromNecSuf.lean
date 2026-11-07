/-
# `log(a^n) = ι(n) log a`（具体版を必要十分版から導く）

具体版 `ClaimRealLogOfPower.lean` の主張を、必要十分版
`Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_map_pow` の
`G := ℝ`、`R := ℝ`、`L := Real.log`、`P y := 0 < y`、積の法則 `real_log_of_product` の特殊化として得る。
`G` の `n` 倍 `n • log a` は、ℝ では `(n : ℝ) * log a`（`nsmul_eq_mul`）である。人手のラベルは `real_log_of_power`。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfPower
import Ising2D.NecSuf.InverseOfAdditiveToMultiplicativeMap

namespace Ising2D

/-- `real_log_of_power` を `NecSuf.inv_map_pow` の特殊化として得る。 -/
theorem real_log_of_power_of_necSuf {a : ℝ} (ha : 0 < a) (n : ℕ) (hn : 1 ≤ n) :
    0 < a ^ n ∧ Real.log (a ^ n) = (n : ℝ) * Real.log a := by
  have h := NecSuf.inv_map_pow Real.log (fun y : ℝ => 0 < y)
    (fun _ _ ha hb => (real_log_of_product ha hb).2) (fun _ _ ha hb => mul_pos ha hb) ha n hn
  exact ⟨h.1, by rw [h.2, nsmul_eq_mul]⟩

end Ising2D
