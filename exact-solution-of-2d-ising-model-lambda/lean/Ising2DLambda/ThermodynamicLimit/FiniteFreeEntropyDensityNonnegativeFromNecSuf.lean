/- 必要十分版を二度特殊化して具体版を得る。
一度目: `X := ℚ`、`P := (0 < ·)`、`leX := ≤`、`Y := Λ`、`leY := logOrderLE`、`f := logRat`、
`x₀ := 1`、`y₀ := 0`（`logRat_one`）、`z := Z_L(q)`（`1 ≤ Z_L(q)` は `one_le_partitionPolynomial_eval_rat`）。
二度目: `X := Λ`、`P := True`、`leX := logOrderLE`、`Y := Λ_ℚ`、`leY := rationalLogOrderLE`、
`f := (1/L^2)·ι(·)`、`x₀ := 0`、`y₀ := 0`（`scaled_toRational_zero`）、`z := Φ_L(q)`。 -/
import Ising2DLambda.ThermodynamicLimit.FiniteFreeEntropyDensityNonnegative
import Ising2DLambda.NecSuf.ThermodynamicLimit.FiniteFreeEntropyDensityNonnegative

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy PartitionPolynomial

theorem rationalLogOrderLE_zero_scaledFreeEntropy_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) : rationalLogOrderLE 0 (scaledFreeEntropy L q) := by
  -- 一度目: ℚ_{>0} → Λ
  have hΛ : logOrderLE 0 (freeEntropy L q) :=
    NecSuf.ThermodynamicLimit.le_base_transport_of_monotone_necSuf
      (fun a : ℚ => 0 < a) (· ≤ ·) logOrderLE logRat
      (fun a b ha hb hab => (logRat_le_iff ha hb).mp hab)
      one_pos (partitionPolynomial_eval_pos L hq) logRat_one
      (one_le_partitionPolynomial_eval_rat L hq)
  -- 二度目: Λ → Λ_ℚ
  exact NecSuf.ThermodynamicLimit.le_base_transport_of_monotone_necSuf
    (fun _ : LogOrderGroup => True) logOrderLE rationalLogOrderLE
    (fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
    (fun a b _ _ hab => (rationalLogOrderLE_scaled_toRational_iff L a b).mpr hab)
    trivial trivial (scaled_toRational_zero L) hΛ

end Ising2DLambda.ThermodynamicLimit
