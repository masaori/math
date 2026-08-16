/- 必要十分版 `le_base_transport_of_monotone_necSuf`（周期境界と共有。順序を保つ写像による下界の移送）を
二度特殊化して具体版を得る。
一度目: `X := ℚ`、`P := (0 < ·)`、`leX := ≤`、`Y := Λ`、`leY := logOrderLE`、`f := logRat`、
`x₀ := 1`、`y₀ := 0`（`logRat_one`）、`z := Z^op_{L,L}(q)`（`1 ≤ Z^op_{L,L}(q)` は `one_le_openPartitionValueRat`）。
二度目: `X := Λ`、`P := True`、`leX := logOrderLE`、`Y := Λ_ℚ`、`leY := rationalLogOrderLE`、
`f := (1/L^2)·ι(·)`、`x₀ := 0`、`y₀ := 0`（`scaled_toRational_zero`）、`z := log Z^op_{L,L}(q)`。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityNonnegative
import Ising2DLambda.NecSuf.ThermodynamicLimit.FiniteFreeEntropyDensityNonnegative

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_zero_openScaledFreeEntropy_from_necSuf (L : ℕ) [NeZero L] {q : ℚ}
    (hq : 0 < q) : rationalLogOrderLE 0 (openScaledFreeEntropy L q) := by
  -- 一度目: ℚ_{>0} → Λ
  have hΛ : logOrderLE 0 (logRat (openPartitionValueRat L L q)) :=
    NecSuf.ThermodynamicLimit.le_base_transport_of_monotone_necSuf
      (fun a : ℚ => 0 < a) (· ≤ ·) logOrderLE logRat
      (fun a b ha hb hab => (logRat_le_iff ha hb).mp hab)
      one_pos (openPartitionValueRat_pos L L hq) logRat_one
      (one_le_openPartitionValueRat L L hq)
  -- 二度目: Λ → Λ_ℚ
  exact NecSuf.ThermodynamicLimit.le_base_transport_of_monotone_necSuf
    (fun _ : LogOrderGroup => True) logOrderLE rationalLogOrderLE
    (fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
    (fun a b _ _ hab => (rationalLogOrderLE_scaled_toRational_iff L a b).mpr hab)
    trivial trivial (scaled_toRational_zero L) hΛ

end Ising2DLambda.ThermodynamicLimit
