/- 具体版 `OpenSquareSubsquareComparisonLog` の主張が、必要十分版
`twoSided_bounds_transport_through_monotone_map_necSuf`（二側の評価を順序を保つ写像 1 本で運び、
両端の像を等式で目標の形へ整えるだけ）の特殊化であることを示す。
`ell := log`（`K` は正の有理数の部分型）、二側の評価は
`claim_open_square_subsquare_comparison_rational_le_one`、両端の等式は
`logRat_subsquareLowerValue_eq`・`logRat_subsquareUpperValue_eq`。
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」のものをそのまま共有する（新設しない）。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonLog
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

theorem logOrderLE_openSquareSubsquareLog_bounds_of_le_one_from_necSuf
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE ((a + L) • logRat q + logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat L L q)) ∧
      logOrderLE (logRat (openPartitionValueRat L L q))
        ((L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
          (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q)) := by
  have h1q : 0 < 1 + q := by linarith
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZL : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq0
  have hlow : 0 < q ^ (a + L) * openPartitionValueRat a a q :=
    mul_pos (pow_pos_by_induction hq0 _) hZa
  have hup : 0 < ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * (L ^ 2 - a ^ 2)) *
      openPartitionValueRat a a q :=
    mul_pos (mul_pos (by positivity) (pow_pos h1q _)) hZa
  have hbounds := openPartitionValueRat_square_subsquare_bounds_of_le_one a L ha haL hq0 hq1
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨q ^ (a + L) * openPartitionValueRat a a q, hlow⟩)
    (x := ⟨openPartitionValueRat L L q, hZL⟩)
    (upper := ⟨((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * (L ^ 2 - a ^ 2)) *
      openPartitionValueRat a a q, hup⟩)
    (lowForm := (a + L) • logRat q + logRat (openPartitionValueRat a a q))
    (upForm := (L ^ 2 - a ^ 2) • generator ⟨2, Nat.prime_two⟩ +
      (2 * (L ^ 2 - a ^ 2)) • logRat (1 + q) + logRat (openPartitionValueRat a a q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_subsquareLowerValue_eq (a + L) hq0 hZa)
    (logRat_subsquareUpperValue_eq (L ^ 2 - a ^ 2) hq0 hZa)

end Ising2DLambda.ThermodynamicLimit
