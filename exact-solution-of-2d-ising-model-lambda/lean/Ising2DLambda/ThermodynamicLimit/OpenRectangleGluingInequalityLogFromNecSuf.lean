/- 具体版 `OpenRectangleGluingInequalityLog` の四つの主張が、必要十分版
`twoSided_bounds_transport_through_monotone_map_necSuf`（二側の評価を順序を保つ写像 1 本で運び、
両端の像を等式で目標の形へ整えるだけ）の特殊化であることを示す。
`ell := log`（`K` は正の有理数の部分型）、二側の評価は
`claim_open_rectangle_gluing_inequality_rational` の四つの場合、両端の等式は
`logRat_gluingLowerValue_eq`・`logRat_gluingUpperValue_eq`。
`1 ≤ q` の場合は `lower`・`upper` の役割を入れ替えて同じ必要十分版から得る。
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」のものをそのまま共有する（新設しない）。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityLog
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

theorem logOrderLE_openRectangleGlueFirstLog_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        (b • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat c b q))
        (logRat (openPartitionValueRat (a + c) b q)) ∧
      logOrderLE (logRat (openPartitionValueRat (a + c) b q))
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q)) := by
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZcb : 0 < openPartitionValueRat c b q := openPartitionValueRat_pos c b hq0
  have hZ : 0 < openPartitionValueRat (a + c) b q := openPartitionValueRat_pos (a + c) b hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat c b q := mul_pos hZab hZcb
  have hlow : 0 < q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueFirst_bounds_of_le_one a b c ha hc hq0 hq1
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q), hlow⟩)
    (x := ⟨openPartitionValueRat (a + c) b q, hZ⟩)
    (upper := ⟨openPartitionValueRat a b q * openPartitionValueRat c b q, hup⟩)
    (lowForm := b • logRat q + logRat (openPartitionValueRat a b q) +
      logRat (openPartitionValueRat c b q))
    (upForm := logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_gluingLowerValue_eq b hq0 hZab hZcb)
    (logRat_gluingUpperValue_eq hZab hZcb)

theorem logOrderLE_openRectangleGlueFirstLog_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q))
        (logRat (openPartitionValueRat (a + c) b q)) ∧
      logOrderLE (logRat (openPartitionValueRat (a + c) b q))
        (b • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat c b q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZcb : 0 < openPartitionValueRat c b q := openPartitionValueRat_pos c b hq0
  have hZ : 0 < openPartitionValueRat (a + c) b q := openPartitionValueRat_pos (a + c) b hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat c b q := mul_pos hZab hZcb
  have hlow : 0 < q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueFirst_bounds_of_one_le a b c ha hc hq
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨openPartitionValueRat a b q * openPartitionValueRat c b q, hup⟩)
    (x := ⟨openPartitionValueRat (a + c) b q, hZ⟩)
    (upper := ⟨q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q), hlow⟩)
    (lowForm := logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat c b q))
    (upForm := b • logRat q + logRat (openPartitionValueRat a b q) +
      logRat (openPartitionValueRat c b q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_gluingUpperValue_eq hZab hZcb)
    (logRat_gluingLowerValue_eq b hq0 hZab hZcb)

theorem logOrderLE_openRectangleGlueSecondLog_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        (a • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat a c q))
        (logRat (openPartitionValueRat a (b + c) q)) ∧
      logOrderLE (logRat (openPartitionValueRat a (b + c) q))
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q)) := by
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZac : 0 < openPartitionValueRat a c q := openPartitionValueRat_pos a c hq0
  have hZ : 0 < openPartitionValueRat a (b + c) q := openPartitionValueRat_pos a (b + c) hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat a c q := mul_pos hZab hZac
  have hlow : 0 < q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueSecond_bounds_of_le_one a b c hb hc hq0 hq1
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q), hlow⟩)
    (x := ⟨openPartitionValueRat a (b + c) q, hZ⟩)
    (upper := ⟨openPartitionValueRat a b q * openPartitionValueRat a c q, hup⟩)
    (lowForm := a • logRat q + logRat (openPartitionValueRat a b q) +
      logRat (openPartitionValueRat a c q))
    (upForm := logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_gluingLowerValue_eq a hq0 hZab hZac)
    (logRat_gluingUpperValue_eq hZab hZac)

theorem logOrderLE_openRectangleGlueSecondLog_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE
        (logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q))
        (logRat (openPartitionValueRat a (b + c) q)) ∧
      logOrderLE (logRat (openPartitionValueRat a (b + c) q))
        (a • logRat q + logRat (openPartitionValueRat a b q) +
          logRat (openPartitionValueRat a c q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  have hZab : 0 < openPartitionValueRat a b q := openPartitionValueRat_pos a b hq0
  have hZac : 0 < openPartitionValueRat a c q := openPartitionValueRat_pos a c hq0
  have hZ : 0 < openPartitionValueRat a (b + c) q := openPartitionValueRat_pos a (b + c) hq0
  have hup : 0 < openPartitionValueRat a b q * openPartitionValueRat a c q := mul_pos hZab hZac
  have hlow : 0 < q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) :=
    mul_pos (pow_pos_by_induction hq0 _) hup
  have hbounds := openPartitionValueRat_glueSecond_bounds_of_one_le a b c hb hc hq
  exact twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨openPartitionValueRat a b q * openPartitionValueRat a c q, hup⟩)
    (x := ⟨openPartitionValueRat a (b + c) q, hZ⟩)
    (upper := ⟨q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q), hlow⟩)
    (lowForm := logRat (openPartitionValueRat a b q) + logRat (openPartitionValueRat a c q))
    (upForm := a • logRat q + logRat (openPartitionValueRat a b q) +
      logRat (openPartitionValueRat a c q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_gluingUpperValue_eq hZab hZac)
    (logRat_gluingLowerValue_eq a hq0 hZab hZac)

end Ising2DLambda.ThermodynamicLimit
