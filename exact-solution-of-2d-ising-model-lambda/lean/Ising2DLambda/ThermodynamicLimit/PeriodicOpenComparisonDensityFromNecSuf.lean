/- 具体版が必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf`
（`NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）の特殊化であることを示す。
`ell := λ ↦ (1/L²)·ι(λ)`（`Λ → Λ_ℚ`。順序を保つことは
`rationalLogOrderLE_scaled_toRational_iff L` の ← ）、二側の評価は
`claim_periodic_open_boundary_comparison_log_le_one`、下端の等式は
`scaled_periodicOpenLowerForm_eq`、上端の等式は定義の展開（`rfl`）へ特殊化する。
`ell x` は `scaledFreeEntropy L q` そのもの（定義の展開）。 -/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonDensity
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one_from_necSuf
    (L : ℕ) [NeZero L] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q))
        (scaledFreeEntropy L q) ∧
      rationalLogOrderLE (scaledFreeEntropy L q) (openScaledFreeEntropy L q) := by
  have hbounds := logOrderLE_periodicOpenLog_bounds_of_le_one L hq0 hq1
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := LogOrderGroup) (A := RationalLogOrderGroup)
    (leK := logOrderLE) (leA := rationalLogOrderLE)
    (ell := fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
    (lower := (2 * L) • logRat q + logRat (openPartitionValueRat L L q))
    (x := freeEntropy L q)
    (upper := logRat (openPartitionValueRat L L q))
    (lowForm := openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q))
    (upForm := openScaledFreeEntropy L q)
    (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff L u v).mpr huv)
    hbounds.1 hbounds.2
    (scaled_periodicOpenLowerForm_eq L q)
    rfl

end Ising2DLambda.ThermodynamicLimit
