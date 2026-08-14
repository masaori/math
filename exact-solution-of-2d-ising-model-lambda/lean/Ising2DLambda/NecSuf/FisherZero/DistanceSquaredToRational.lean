/-
「零点と有理点の距離の二乗」の必要十分版。

証明に要るのは体、二係数表示、零元でない元の平方が -1 でないことだけである。
代数閉性、順序、可算性は要求しない。
-/
import Mathlib.Algebra.Field.Defs
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 二係数表示から作る距離の二乗。 -/
def distanceSquaredOfPair {K : Type} [Field K] (ab : K × K) (q : K) : K :=
  (ab.1 - q) * (ab.1 - q) + ab.2 * ab.2

/-- 距離の二乗の零性を係数の一致へ戻す論理的な核。 -/
theorem distanceSquaredOfPair_eq_zero_iff_necSuf
    {K : Type} [Field K]
    (hnegOne : ∀ w : K, w ≠ 0 → w * w ≠ -1)
    (ab : K × K) (q : K) :
    distanceSquaredOfPair ab q = 0 ↔ ab = (q, 0) := by
  constructor
  · intro hdsq
    have hsum : (ab.1 - q) * (ab.1 - q) + ab.2 * ab.2 = 0 := hdsq
    have hb : ab.2 = 0 := by
      by_contra hbne
      let w : K := (ab.1 - q) * ab.2⁻¹
      have hsq : (ab.1 - q) * (ab.1 - q) = -(ab.2 * ab.2) := by
        exact eq_neg_of_add_eq_zero_left hsum
      have hw_sq : w * w = -1 := by
        calc
          w * w = ((ab.1 - q) * ab.2⁻¹) * ((ab.1 - q) * ab.2⁻¹) := by rfl
          _ = ((ab.1 - q) * (ab.1 - q)) * (ab.2⁻¹ * ab.2⁻¹) := by ring
          _ = (-(ab.2 * ab.2)) * (ab.2⁻¹ * ab.2⁻¹) := by rw [hsq]
          _ = -((ab.2 * ab.2⁻¹) * (ab.2 * ab.2⁻¹)) := by ring
          _ = -(1 * 1) := by rw [mul_inv_cancel₀ hbne]
          _ = -1 := by ring
      have hw : w ≠ 0 := by
        intro hwzero
        have : (0 : K) = -1 := by simpa [hwzero] using hw_sq
        exact one_ne_zero (neg_eq_zero.mp this.symm)
      exact hnegOne w hw hw_sq
    have ha : ab.1 = q := by
      have hsquare : (ab.1 - q) * (ab.1 - q) = 0 := by simpa [hb] using hsum
      exact sub_eq_zero.mp (mul_self_eq_zero.mp hsquare)
    exact Prod.ext ha hb
  · rintro rfl
    simp [distanceSquaredOfPair]

end Ising2DLambda.NecSuf.FisherZero
