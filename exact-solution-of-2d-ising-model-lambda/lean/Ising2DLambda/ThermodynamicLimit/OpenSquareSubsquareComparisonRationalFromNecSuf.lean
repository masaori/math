/-
「開境界正方形と部分正方形の値の比較（正の有理点、q は 1 以下）」の具体版が、
必要十分版 `split_twice_bounds_necSuf`（実数版と共有。可換半環の順序と非負元の乗法単調性だけを使う）
の特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareSubsquareComparisonRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareSubsquareComparison

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

/-- 具体版を必要十分版から導く。`p := q^L`, `q := q^a`,
`Bac := 2^{ac}(1+q)^{2ac}`, `BcL := 2^{cL}(1+q)^{2cL}`。 -/
theorem openPartitionValueRat_square_subsquare_bounds_of_le_one_from_necSuf
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ (a + L) * openPartitionValueRat a a q ≤ openPartitionValueRat L L q ∧
      openPartitionValueRat L L q ≤
        ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * (L ^ 2 - a ^ 2)) *
          openPartitionValueRat a a q := by
  obtain ⟨c, rfl⟩ := Nat.exists_eq_add_of_le haL.le
  have hc : 0 < c := by omega
  have hexp : (a + c) ^ 2 - a ^ 2 = a * c + c * (a + c) :=
    Nat.sub_eq_of_eq_add (by ring)
  obtain ⟨hsecond_lo, hsecond_hi⟩ :=
    openPartitionValueRat_glueSecond_bounds_of_le_one (a := a) (b := a) (c := c) ha hc hq0 hq1
  obtain ⟨hfirst_lo, hfirst_hi⟩ :=
    openPartitionValueRat_glueFirst_bounds_of_le_one (a := a) (b := a + c) (c := c) ha hc hq0 hq1
  obtain ⟨hlo, hhi⟩ := NecSuf.ThermodynamicLimit.split_twice_bounds_necSuf
    (pow_pos_by_induction hq0 (a + c)).le (pow_pos_by_induction hq0 a).le
    (openPartitionValueRat_pos a a hq0).le (openPartitionValueRat_pos a (a + c) hq0).le
    (openPartitionValueRat_pos c (a + c) hq0).le
    (mul_nonneg (Nat.cast_nonneg _) (pow_pos_by_induction (by linarith) _).le)
    (one_le_openPartitionValueRat a c hq0) (one_le_openPartitionValueRat c (a + c) hq0)
    hsecond_lo hsecond_hi hfirst_lo hfirst_hi
    (openPartitionValueRat_le_upperBound a c hq0)
    (openPartitionValueRat_le_upperBound c (a + c) hq0)
  constructor
  · calc
      q ^ (a + (a + c)) * openPartitionValueRat a a q
          = q ^ (a + c) * (q ^ a * openPartitionValueRat a a q) := by rw [pow_add]; ring
      _ ≤ openPartitionValueRat (a + c) (a + c) q := hlo
  · calc
      openPartitionValueRat (a + c) (a + c) q
          ≤ (((2 ^ (a * c) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * c))) *
              (((2 ^ (c * (a + c)) : ℕ) : ℚ) * (1 + q) ^ (2 * (c * (a + c)))) *
              openPartitionValueRat a a q := hhi
      _ = ((2 ^ ((a + c) ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * ((a + c) ^ 2 - a ^ 2)) *
            openPartitionValueRat a a q := by
            rw [hexp]; push_cast; ring

end Ising2DLambda.ThermodynamicLimit
