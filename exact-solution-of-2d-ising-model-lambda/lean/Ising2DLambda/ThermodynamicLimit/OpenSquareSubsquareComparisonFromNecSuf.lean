/-
「開境界正方形と部分正方形の値の比較（t は 1 以下）」の具体版が、
必要十分版 `split_twice_bounds_necSuf` の特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparison
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareSubsquareComparison

namespace Ising2DLambda.ThermodynamicLimit

/-- 具体版を必要十分版から導く。`p := t^L`, `q := t^a`, `Bac := 2^{ac}`, `BcL := 2^{cL}`。 -/
theorem openPartitionValue_square_subsquare_bounds_of_le_one_from_necSuf
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ (a + L) * openPartitionValue a a t ≤ openPartitionValue L L t ∧
      openPartitionValue L L t ≤
        ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℝ) * openPartitionValue a a t := by
  obtain ⟨c, rfl⟩ := Nat.exists_eq_add_of_le haL.le
  have hc : 0 < c := by omega
  have hexp : (a + c) ^ 2 - a ^ 2 = a * c + c * (a + c) :=
    Nat.sub_eq_of_eq_add (by ring)
  obtain ⟨hsecond_lo, hsecond_hi⟩ :=
    openPartitionValue_glueSecond_bounds_of_le_one (a := a) (b := a) (c := c) ha hc ht0 ht1
  obtain ⟨hfirst_lo, hfirst_hi⟩ :=
    openPartitionValue_glueFirst_bounds_of_le_one (a := a) (b := a + c) (c := c) ha hc ht0 ht1
  obtain ⟨hlo, hhi⟩ := NecSuf.ThermodynamicLimit.split_twice_bounds_necSuf
    (pow_pos_by_induction ht0 (a + c)).le (pow_pos_by_induction ht0 a).le
    (openPartitionValue_pos a a ht0).le (openPartitionValue_pos a (a + c) ht0).le
    (openPartitionValue_pos c (a + c) ht0).le (Nat.cast_nonneg _)
    (one_le_openPartitionValue a c ht0) (one_le_openPartitionValue c (a + c) ht0)
    hsecond_lo hsecond_hi hfirst_lo hfirst_hi
    (openPartitionValue_le_configurationCount_of_le_one a c ht0 ht1)
    (openPartitionValue_le_configurationCount_of_le_one c (a + c) ht0 ht1)
  constructor
  · calc
      t ^ (a + (a + c)) * openPartitionValue a a t
          = t ^ (a + c) * (t ^ a * openPartitionValue a a t) := by rw [pow_add]; ring
      _ ≤ openPartitionValue (a + c) (a + c) t := hlo
  · calc
      openPartitionValue (a + c) (a + c) t
          ≤ ((2 ^ (a * c) : ℕ) : ℝ) * ((2 ^ (c * (a + c)) : ℕ) : ℝ) * openPartitionValue a a t := hhi
      _ = ((2 ^ ((a + c) ^ 2 - a ^ 2) : ℕ) : ℝ) * openPartitionValue a a t := by
            rw [hexp]; push_cast; ring

end Ising2DLambda.ThermodynamicLimit
