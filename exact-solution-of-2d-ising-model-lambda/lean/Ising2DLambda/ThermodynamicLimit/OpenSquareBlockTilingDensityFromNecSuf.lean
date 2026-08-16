/- 具体版の二場合が必要十分版 `twoSided_bounds_transport_through_monotone_map_necSuf`
（`NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）の特殊化であることを示す。
`ell := λ ↦ (1/(ka)²)·ι(λ)`（`Λ → Λ_ℚ`。順序を保つことは
`rationalLogOrderLE_scaled_toRational_iff (k*a)` の ← ）、二側の評価は
`claim_open_square_block_tiling_log` の二場合、両端の等式は
`scaled_blockTilingLowerForm_eq`・`scaled_blockTilingUpperForm_eq` へ特殊化する。
`ell x` は `openScaledFreeEntropy (k*a) q` そのもの（定義の展開）。
`1 ≤ q` の場合は `lower`・`upper` の役割を入れ替えて同じ必要十分版から得る。 -/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingDensity
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareBlockTilingLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one_from_necSuf
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          openScaledFreeEntropy a q)
        (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q) (openScaledFreeEntropy a q) := by
  have hbounds := logOrderLE_openSquareBlockTilingLog_bounds_of_le_one a k
    (Nat.pos_of_ne_zero (NeZero.ne a)) (Nat.one_le_iff_ne_zero.mpr (NeZero.ne k)) hq0 hq1
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := LogOrderGroup) (A := RationalLogOrderGroup)
    (leK := logOrderLE) (leA := rationalLogOrderLE)
    (ell := fun l => ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) • toRational l)
    (lower := (2 * (k * ((k - 1) * a))) • logRat q +
      (k * k) • logRat (openPartitionValueRat a a q))
    (x := logRat (openPartitionValueRat (k * a) (k * a) q))
    (upper := (k * k) • logRat (openPartitionValueRat a a q))
    (lowForm := ((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
      openScaledFreeEntropy a q)
    (upForm := openScaledFreeEntropy a q)
    (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff (k * a) u v).mpr huv)
    hbounds.1 hbounds.2
    (scaled_blockTilingLowerForm_eq a k q)
    (scaled_blockTilingUpperForm_eq a k q)

theorem rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_one_le_from_necSuf
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq : 1 ≤ q) :
    rationalLogOrderLE (openScaledFreeEntropy a q) (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q)
        (((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
          openScaledFreeEntropy a q) := by
  have hbounds := logOrderLE_openSquareBlockTilingLog_bounds_of_one_le a k
    (Nat.pos_of_ne_zero (NeZero.ne a)) (Nat.one_le_iff_ne_zero.mpr (NeZero.ne k)) hq
  -- lower・upper の役割を 0<q≤1 の場合から入れ替えて、同じ必要十分版を引く
  exact NecSuf.ThermodynamicLimit.twoSided_bounds_transport_through_monotone_map_necSuf
    (K := LogOrderGroup) (A := RationalLogOrderGroup)
    (leK := logOrderLE) (leA := rationalLogOrderLE)
    (ell := fun l => ((1 : ℚ) / (((k * a : ℕ) : ℚ) ^ 2)) • toRational l)
    (lower := (k * k) • logRat (openPartitionValueRat a a q))
    (x := logRat (openPartitionValueRat (k * a) (k * a) q))
    (upper := (2 * (k * ((k - 1) * a))) • logRat q +
      (k * k) • logRat (openPartitionValueRat a a q))
    (lowForm := openScaledFreeEntropy a q)
    (upForm := ((2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)) • toRational (logRat q) +
      openScaledFreeEntropy a q)
    (fun {u v} huv => (rationalLogOrderLE_scaled_toRational_iff (k * a) u v).mpr huv)
    hbounds.1 hbounds.2
    (scaled_blockTilingUpperForm_eq a k q)
    (scaled_blockTilingLowerForm_eq a k q)

end Ising2DLambda.ThermodynamicLimit
