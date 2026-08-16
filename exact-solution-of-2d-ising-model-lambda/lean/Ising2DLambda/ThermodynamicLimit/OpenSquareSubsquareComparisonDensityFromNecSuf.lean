/- 具体版が必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf`
（`NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）の特殊化であることを示す。
`ell := λ ↦ (1/L²)·ι(λ)`（`Λ → Λ_ℚ`。順序を保つことは
`rationalLogOrderLE_scaled_toRational_iff L` の ← ）、二側の評価は
`claim_open_square_subsquare_comparison_log_le_one`、両端の等式は
`scaled_subsquareLowerForm_eq`・`scaled_subsquareUpperForm_eq` へ特殊化する。
`ell x` は `openScaledFreeEntropy L q` そのもの（定義の展開）。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonDensity
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one_from_necSuf
    (a L : ℕ) [NeZero a] [NeZero L] (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        ((((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q)
        (openScaledFreeEntropy L q) ∧
      rationalLogOrderLE (openScaledFreeEntropy L q)
        ((((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
          (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q) := by
  have hbounds := logOrderLE_openSquareSubsquareLog_bounds_of_le_one a L
    (Nat.pos_of_ne_zero (NeZero.ne a)) haL hq0 hq1
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := LogOrderGroup) (A := RationalLogOrderGroup)
    (leK := logOrderLE) (leA := rationalLogOrderLE)
    (ell := fun l => ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
    (lower := (a + L) • logRat q + logRat (openPartitionValueRat a a q))
    (x := logRat (openPartitionValueRat L L q))
    (upper := (L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
      (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q))
    (lowForm := (((a + L : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat q) +
      (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q)
    (upForm := (((L ^ 2 - a ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (generator ⟨2, Nat.prime_two⟩) +
      (((2 * (L ^ 2 - a ^ 2) : ℕ) : ℚ) / ((L : ℚ) ^ 2)) • toRational (logRat (1 + q)) +
      (((a : ℚ) ^ 2) / ((L : ℚ) ^ 2)) • openScaledFreeEntropy a q)
    (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff L u v).mpr huv)
    hbounds.1 hbounds.2
    (scaled_subsquareLowerForm_eq a L q)
    (scaled_subsquareUpperForm_eq a L q)

end Ising2DLambda.ThermodynamicLimit
