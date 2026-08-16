/- 具体版の二場合が必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf` の
特殊化であることを示す。`ell := log`（`ℚ_{>0} → Λ`。第一の写像は正の有理数の上でだけ
順序を保つので、`K` を正の有理数の部分型に取る）、二側の評価は
`claim_open_square_block_tiling_rational` の二場合、両端の等式は
`logRat_blockTilingLowerValue_eq`・`logRat_blockTilingUpperValue_eq` へ特殊化する。
`1 ≤ q` の場合は `lower`・`upper` の役割を入れ替えて同じ必要十分版から得る。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingLog
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy
open NecSuf.ThermodynamicLimit

theorem logOrderLE_openSquareBlockTilingLog_bounds_of_le_one_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    logOrderLE
        ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat (k * a) (k * a) q)) ∧
      logOrderLE (logRat (openPartitionValueRat (k * a) (k * a) q))
        ((k * k) • logRat (openPartitionValueRat a a q)) := by
  -- 準備の第一: 値と両側の評価の値の正値性
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZka : 0 < openPartitionValueRat (k * a) (k * a) q :=
    openPartitionValueRat_pos (k * a) (k * a) hq0
  have hinner : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)
  have hlow : 0 < q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hinner _)
  have hup : 0 < (openPartitionValueRat a a q ^ k) ^ k :=
    pow_pos_by_induction (pow_pos_by_induction hZa _) _
  -- ブロック敷き詰め評価（claim_open_square_block_tiling_rational の 0<q≤1 の場合）
  have hbounds := openPartitionValueRat_squareBlockTiling_bounds_of_le_one a k ha hk hq0 hq1
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k, hlow⟩)
    (x := ⟨openPartitionValueRat (k * a) (k * a) q, hZka⟩)
    (upper := ⟨(openPartitionValueRat a a q ^ k) ^ k, hup⟩)
    (lowForm := (2 * (k * ((k - 1) * a))) • logRat q +
      (k * k) • logRat (openPartitionValueRat a a q))
    (upForm := (k * k) • logRat (openPartitionValueRat a a q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_blockTilingLowerValue_eq a k hq0)
    (logRat_blockTilingUpperValue_eq a k hq0)

theorem logOrderLE_openSquareBlockTilingLog_bounds_of_one_le_from_necSuf
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq : 1 ≤ q) :
    logOrderLE ((k * k) • logRat (openPartitionValueRat a a q))
        (logRat (openPartitionValueRat (k * a) (k * a) q)) ∧
      logOrderLE (logRat (openPartitionValueRat (k * a) (k * a) q))
        ((2 * (k * ((k - 1) * a))) • logRat q +
          (k * k) • logRat (openPartitionValueRat a a q)) := by
  have hq0 : 0 < q := lt_of_lt_of_le one_pos hq
  -- 準備の第一: 値と両側の評価の値の正値性
  have hZa : 0 < openPartitionValueRat a a q := openPartitionValueRat_pos a a hq0
  have hZka : 0 < openPartitionValueRat (k * a) (k * a) q :=
    openPartitionValueRat_pos (k * a) (k * a) hq0
  have hinner : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hZa _)
  have hlow : 0 < q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k :=
    mul_pos (pow_pos_by_induction hq0 _) (pow_pos_by_induction hinner _)
  have hup : 0 < (openPartitionValueRat a a q ^ k) ^ k :=
    pow_pos_by_induction (pow_pos_by_induction hZa _) _
  -- ブロック敷き詰め評価（claim_open_square_block_tiling_rational の 1≤q の場合）
  have hbounds := openPartitionValueRat_squareBlockTiling_bounds_of_one_le a k ha hk hq
  -- lower・upper の役割を 0<q≤1 の場合から入れ替えて、同じ必要十分版を引く
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := {r : ℚ // 0 < r})
    (leK := fun u v => u.1 ≤ v.1) (leA := logOrderLE)
    (ell := fun u => logRat u.1)
    (lower := ⟨(openPartitionValueRat a a q ^ k) ^ k, hup⟩)
    (x := ⟨openPartitionValueRat (k * a) (k * a) q, hZka⟩)
    (upper := ⟨q ^ ((k - 1) * (k * a)) *
      (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k, hlow⟩)
    (lowForm := (k * k) • logRat (openPartitionValueRat a a q))
    (upForm := (2 * (k * ((k - 1) * a))) • logRat q +
      (k * k) • logRat (openPartitionValueRat a a q))
    (fun {u v} huv => (logRat_le_iff u.2 v.2).mp huv)
    hbounds.1 hbounds.2
    (logRat_blockTilingUpperValue_eq a k hq0)
    (logRat_blockTilingLowerValue_eq a k hq0)

end Ising2DLambda.ThermodynamicLimit
