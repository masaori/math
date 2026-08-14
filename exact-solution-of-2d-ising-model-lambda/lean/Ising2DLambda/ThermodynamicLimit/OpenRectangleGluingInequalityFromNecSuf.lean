/- 具体版の接合不等式が必要十分版の特殊化であることを示す。
添字を配位、全単射を接合の全単射、指数を破れボンド数、三項分解を接合面分解、
接合面因子の評価を自然数冪の順序の評価へそれぞれ代入する。 -/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenRectangleGluingInequality

namespace Ising2DLambda.ThermodynamicLimit

open Finset

/-- 第一の座標の向き、`0 < t ≤ 1` の場合の導出。 -/
theorem openPartitionValue_glueFirst_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ b * (openPartitionValue a b t * openPartitionValue c b t) ≤
        openPartitionValue (a + c) b t ∧
      openPartitionValue (a + c) b t ≤
        openPartitionValue a b t * openPartitionValue c b t := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivFirst a b c) t
    (openBrokenBondCount a b) (openBrokenBondCount c b)
    (openBrokenBondCount (a + c) b)
    (openSeamBrokenCountFirst a b c ha hc)
    (fun σ τ => openBrokenBondCount_glueFirst a b c ha hc σ τ)
    (t ^ b) 1 ht0.le
    (fun σ τ => pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
      (openSeamBrokenCountFirst_le a b c ha hc σ τ))
    (fun σ τ => pow_le_one_by_induction ht0.le ht1 _)
  rw [one_mul] at h
  rw [openPartitionValue_eq_sum a b, openPartitionValue_eq_sum c b,
    openPartitionValue_eq_sum (a + c) b]
  exact h

/-- 第一の座標の向き、`1 ≤ t` の場合の導出。 -/
theorem openPartitionValue_glueFirst_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (ha : 0 < a) (hc : 0 < c) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t * openPartitionValue c b t ≤
        openPartitionValue (a + c) b t ∧
      openPartitionValue (a + c) b t ≤
        t ^ b * (openPartitionValue a b t * openPartitionValue c b t) := by
  have ht0 : (0 : ℝ) ≤ t := le_trans zero_le_one ht
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivFirst a b c) t
    (openBrokenBondCount a b) (openBrokenBondCount c b)
    (openBrokenBondCount (a + c) b)
    (openSeamBrokenCountFirst a b c ha hc)
    (fun σ τ => openBrokenBondCount_glueFirst a b c ha hc σ τ)
    1 (t ^ b) ht0
    (fun σ τ => one_le_pow_by_induction ht _)
    (fun σ τ => pow_le_pow_of_one_le_of_exp_le_by_induction ht
      (openSeamBrokenCountFirst_le a b c ha hc σ τ))
  rw [one_mul] at h
  rw [openPartitionValue_eq_sum a b, openPartitionValue_eq_sum c b,
    openPartitionValue_eq_sum (a + c) b]
  exact h

/-- 第二の座標の向き、`0 < t ≤ 1` の場合の導出。 -/
theorem openPartitionValue_glueSecond_bounds_of_le_one_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ a * (openPartitionValue a b t * openPartitionValue a c t) ≤
        openPartitionValue a (b + c) t ∧
      openPartitionValue a (b + c) t ≤
        openPartitionValue a b t * openPartitionValue a c t := by
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivSecond a b c) t
    (openBrokenBondCount a b) (openBrokenBondCount a c)
    (openBrokenBondCount a (b + c))
    (openSeamBrokenCountSecond a b c hb hc)
    (fun σ τ => openBrokenBondCount_glueSecond a b c hb hc σ τ)
    (t ^ a) 1 ht0.le
    (fun σ τ => pow_le_pow_of_le_one_of_exp_le_by_induction ht0 ht1
      (openSeamBrokenCountSecond_le a b c hb hc σ τ))
    (fun σ τ => pow_le_one_by_induction ht0.le ht1 _)
  rw [one_mul] at h
  rw [openPartitionValue_eq_sum a b, openPartitionValue_eq_sum a c,
    openPartitionValue_eq_sum a (b + c)]
  exact h

/-- 第二の座標の向き、`1 ≤ t` の場合の導出。 -/
theorem openPartitionValue_glueSecond_bounds_of_one_le_from_necSuf
    (a b c : ℕ) (hb : 0 < b) (hc : 0 < c) {t : ℝ} (ht : 1 ≤ t) :
    openPartitionValue a b t * openPartitionValue a c t ≤
        openPartitionValue a (b + c) t ∧
      openPartitionValue a (b + c) t ≤
        t ^ a * (openPartitionValue a b t * openPartitionValue a c t) := by
  have ht0 : (0 : ℝ) ≤ t := le_trans zero_le_one ht
  have h := NecSuf.ThermodynamicLimit.sum_pow_glue_bounds_necSuf
    (openConfigGlueEquivSecond a b c) t
    (openBrokenBondCount a b) (openBrokenBondCount a c)
    (openBrokenBondCount a (b + c))
    (openSeamBrokenCountSecond a b c hb hc)
    (fun σ τ => openBrokenBondCount_glueSecond a b c hb hc σ τ)
    1 (t ^ a) ht0
    (fun σ τ => one_le_pow_by_induction ht _)
    (fun σ τ => pow_le_pow_of_one_le_of_exp_le_by_induction ht
      (openSeamBrokenCountSecond_le a b c hb hc σ τ))
  rw [one_mul] at h
  rw [openPartitionValue_eq_sum a b, openPartitionValue_eq_sum a c,
    openPartitionValue_eq_sum a (b + c)]
  exact h

end Ising2DLambda.ThermodynamicLimit
