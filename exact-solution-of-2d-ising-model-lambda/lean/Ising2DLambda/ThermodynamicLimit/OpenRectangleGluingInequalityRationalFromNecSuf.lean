/- 具体版の接合不等式（正の有理点。`claim_open_rectangle_gluing_inequality_rational`）が
必要十分版 `sum_pow_glue_bounds_necSuf` の特殊化であることを示す。
必要十分版は実数版と共有する（係数の住処は可換半環と順序だけで足り、有理数体・実数体は本質でない）。
添字を配位、全単射を接合の全単射、指数を破れボンド数、三項分解を接合面分解、
接合面因子の評価を自然数冪の順序の評価へそれぞれ代入する。`K := ℚ`。

住処: ℚ と ℕ のみ。ℝ / ℂ は現れない。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityRational
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- 第一の座標の向き、`0 < q ≤ 1` の場合の導出。 -/
theorem openPartitionValueRat_glueFirst_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) ≤
        openPartitionValueRat (a + c) b q ∧
      openPartitionValueRat (a + c) b q ≤
        openPartitionValueRat a b q * openPartitionValueRat c b q := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivFirst a b c) q
    (openBrokenBondCount a b) (openBrokenBondCount c b)
    (openBrokenBondCount (a + c) b)
    (openSeamBrokenCountFirst a b c ha hc)
    (fun σ τ => openBrokenBondCount_glueFirst a b c ha hc σ τ)
    (q ^ b) 1 hq0.le
    (fun σ τ => pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
      (openSeamBrokenCountFirst_le a b c ha hc σ τ))
    (fun σ τ => pow_le_one_by_induction_rat hq0.le hq1 _)
  rw [one_mul] at h
  rw [openPartitionValueRat_eq_sum a b, openPartitionValueRat_eq_sum c b,
    openPartitionValueRat_eq_sum (a + c) b]
  exact h

/-- 第一の座標の向き、`1 ≤ q` の場合の導出。 -/
theorem openPartitionValueRat_glueFirst_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat a b q * openPartitionValueRat c b q ≤
        openPartitionValueRat (a + c) b q ∧
      openPartitionValueRat (a + c) b q ≤
        q ^ b * (openPartitionValueRat a b q * openPartitionValueRat c b q) := by
  have hq0 : (0 : ℚ) ≤ q := le_trans zero_le_one hq
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivFirst a b c) q
    (openBrokenBondCount a b) (openBrokenBondCount c b)
    (openBrokenBondCount (a + c) b)
    (openSeamBrokenCountFirst a b c ha hc)
    (fun σ τ => openBrokenBondCount_glueFirst a b c ha hc σ τ)
    1 (q ^ b) hq0
    (fun σ τ => one_le_pow_by_induction_rat hq _)
    (fun σ τ => pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
      (openSeamBrokenCountFirst_le a b c ha hc σ τ))
  rw [one_mul] at h
  rw [openPartitionValueRat_eq_sum a b, openPartitionValueRat_eq_sum c b,
    openPartitionValueRat_eq_sum (a + c) b]
  exact h

/-- 第二の座標の向き、`0 < q ≤ 1` の場合の導出。 -/
theorem openPartitionValueRat_glueSecond_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) ≤
        openPartitionValueRat a (b + c) q ∧
      openPartitionValueRat a (b + c) q ≤
        openPartitionValueRat a b q * openPartitionValueRat a c q := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivSecond a b c) q
    (openBrokenBondCount a b) (openBrokenBondCount a c)
    (openBrokenBondCount a (b + c))
    (openSeamBrokenCountSecond a b c hb hc)
    (fun σ τ => openBrokenBondCount_glueSecond a b c hb hc σ τ)
    (q ^ a) 1 hq0.le
    (fun σ τ => pow_le_pow_of_le_one_of_exp_le_by_induction_rat hq0 hq1
      (openSeamBrokenCountSecond_le a b c hb hc σ τ))
    (fun σ τ => pow_le_one_by_induction_rat hq0.le hq1 _)
  rw [one_mul] at h
  rw [openPartitionValueRat_eq_sum a b, openPartitionValueRat_eq_sum a c,
    openPartitionValueRat_eq_sum a (b + c)]
  exact h

/-- 第二の座標の向き、`1 ≤ q` の場合の導出。 -/
theorem openPartitionValueRat_glueSecond_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {q : ℚ} (hq : 1 ≤ q) :
    openPartitionValueRat a b q * openPartitionValueRat a c q ≤
        openPartitionValueRat a (b + c) q ∧
      openPartitionValueRat a (b + c) q ≤
        q ^ a * (openPartitionValueRat a b q * openPartitionValueRat a c q) := by
  have hq0 : (0 : ℚ) ≤ q := le_trans zero_le_one hq
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivSecond a b c) q
    (openBrokenBondCount a b) (openBrokenBondCount a c)
    (openBrokenBondCount a (b + c))
    (openSeamBrokenCountSecond a b c hb hc)
    (fun σ τ => openBrokenBondCount_glueSecond a b c hb hc σ τ)
    1 (q ^ a) hq0
    (fun σ τ => one_le_pow_by_induction_rat hq _)
    (fun σ τ => pow_le_pow_of_one_le_of_exp_le_by_induction_rat hq
      (openSeamBrokenCountSecond_le a b c hb hc σ τ))
  rw [one_mul] at h
  rw [openPartitionValueRat_eq_sum a b, openPartitionValueRat_eq_sum a c,
    openPartitionValueRat_eq_sum a (b + c)]
  exact h

end Ising2DLambda.ThermodynamicLimit
