/- 具体版 `PeriodicOpenComparisonLog` の主張が、必要十分版
`twoSided_bounds_transport_through_monotone_map_necSuf`（二側の評価を順序を保つ写像 1 本で運び、
両端の像を等式で目標の形へ整えるだけ）の特殊化であることを示す。
`ell := log`（`K` は正の有理数の部分型）、二側の評価は
`claim_periodic_open_boundary_comparison_rational`、下端の等式は
`logRat_periodicOpenLowerValue_eq`、上端の等式は `rfl`（上端は `log Z^op_{L,L}(q)` そのもの）。
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」のものをそのまま共有する（新設しない）。 -/
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonLog
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

theorem logOrderLE_periodicOpenLog_bounds_of_le_one_from_necSuf
    (L : ℕ) [NeZero L] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE ((2 * L) • logRat q + logRat (openPartitionValueRat L L q))
        (freeEntropy L q) ∧
      logOrderLE (freeEntropy L q) (logRat (openPartitionValueRat L L q)) := by
  have hZ : 0 < Polynomial.aeval q (PartitionPolynomial.partitionPolynomial L) :=
    partitionPolynomial_eval_pos L hq0
  have hZop : 0 < openPartitionValueRat L L q := openPartitionValueRat_pos L L hq0
  have hlow : 0 < q ^ (2 * L) * openPartitionValueRat L L q := mul_pos (pow_pos hq0 _) hZop
  have hbounds := partitionValueRat_periodicOpen_bounds_of_le_one L hq0 hq1
  unfold freeEntropy
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨q ^ (2 * L) * openPartitionValueRat L L q, hlow⟩)
    (x := ⟨Polynomial.aeval q (PartitionPolynomial.partitionPolynomial L), hZ⟩)
    (upper := ⟨openPartitionValueRat L L q, hZop⟩)
    (lowForm := (2 * L) • logRat q + logRat (openPartitionValueRat L L q))
    (upForm := logRat (openPartitionValueRat L L q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_periodicOpenLowerValue_eq L hq0 hZop)
    rfl

end Ising2DLambda.ThermodynamicLimit
