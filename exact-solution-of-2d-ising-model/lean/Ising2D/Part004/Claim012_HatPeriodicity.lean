/-
# `hat(Z)`, `hat(Y)` の `M` 周期性

対応する人手証明:
`parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ` (`<hatZ_hatY_M_periodicity>`)

原文の主張: `hat(Z)_M^{(-)} = hat(Z)_{-M}^{(-)}`、`hat(Y)_M = hat(Y)_{-M}`。

原文の証明は「各 `j` について `exp(-√-1 j · 2πM/M) = e^{-2π√-1 j} = 1 = e^0
= exp(-√-1 j · 2π(-M)/M)` だから係数が一致する」。
本ファイルではこれを一般の `μ ∈ ℤ` に対する周期性

  `hat(Z)_{μ+M}^{(η)} = hat(Z)_μ^{(η)}`,  `hat(Y)_{μ+M} = hat(Y)_μ`

として証明し（`hatZ_periodic`, `hatY_periodic`）、原文の主張はその系として得る
（`hatZMinus_M_eq_neg_M`, `hatY_M_eq_neg_M`）。
原文が特殊値 `μ = ±M` でしか述べていないのは、それが使われる場面だけを書いたためで、
一般の `μ` でも同じ計算が通る。
-/
import Ising2D.Part004.Definition009_HatZHatY

namespace Ising2D

variable {M : ℕ}

/-- 位相因子の `M` 周期性: `exp(-√-1 · 2π(k + nM)/M) = exp(-√-1 · 2πk/M)`。

原文の `exp(-√-1 j · 2πM/M) = 1` にあたる部分。 -/
theorem expPhase_add_mul_natCast (hM : M ≠ 0) (k n : ℤ) :
    expPhase M (k + n * M) = expPhase M k := by
  rw [expPhase_add, (expPhase_eq_one_iff hM (n * M)).2 ⟨n, mul_comm _ _⟩, mul_one]

/-- **`hat(Z)` の `M` 周期性**: `hat(Z)_{μ+M}^{(η)} = hat(Z)_μ^{(η)}`。 -/
theorem hatZ_periodic (hM : M ≠ 0) (η : ℂ) (μ : ℤ) :
    hatZ M η (μ + M) = hatZ M η μ := by
  rw [hatZ, hatZ]
  refine Finset.sum_congr rfl fun j _ => ?_
  have h : (((j : ℕ) : ℤ) + 1) * (μ + M)
      = (((j : ℕ) : ℤ) + 1) * μ + (((j : ℕ) : ℤ) + 1) * M := by ring
  rw [h, expPhase_add_mul_natCast hM]

/-- **`hat(Y)` の `M` 周期性**: `hat(Y)_{μ+M} = hat(Y)_μ`。 -/
theorem hatY_periodic (hM : M ≠ 0) (μ : ℤ) :
    hatY M (μ + M) = hatY M μ := by
  rw [hatY, hatY]
  refine Finset.sum_congr rfl fun j _ => ?_
  have h : (((j : ℕ) : ℤ) + 1) * (μ + M)
      = (((j : ℕ) : ℤ) + 1) * μ + (((j : ℕ) : ℤ) + 1) * M := by ring
  rw [h, expPhase_add_mul_natCast hM]

/-- **`<hatZ_hatY_M_periodicity>` の形式化（`hat(Z)^{(-)}` の側）**:
`hat(Z)_M^{(-)} = hat(Z)_{-M}^{(-)}`。 -/
theorem hatZMinus_M_eq_neg_M (hM : M ≠ 0) :
    hatZMinus M (M : ℤ) = hatZMinus M (-(M : ℤ)) := by
  have h1 : hatZ M 1 ((0 : ℤ) + M) = hatZ M 1 0 := hatZ_periodic hM 1 0
  have h2 : hatZ M 1 ((-(M : ℤ)) + M) = hatZ M 1 (-(M : ℤ)) := hatZ_periodic hM 1 _
  rw [neg_add_cancel] at h2
  rw [hatZMinus_def, hatZMinus_def, ← h2, ← h1, zero_add]

/-- **`<hatZ_hatY_M_periodicity>` の形式化（`hat(Y)` の側）**:
`hat(Y)_M = hat(Y)_{-M}`。 -/
theorem hatY_M_eq_neg_M (hM : M ≠ 0) :
    hatY M (M : ℤ) = hatY M (-(M : ℤ)) := by
  have h1 : hatY M ((0 : ℤ) + M) = hatY M 0 := hatY_periodic hM 0
  have h2 : hatY M ((-(M : ℤ)) + M) = hatY M (-(M : ℤ)) := hatY_periodic hM _
  rw [neg_add_cancel] at h2
  rw [← h2, ← h1, zero_add]

end Ising2D
