/-
# 【単位ベクトルでの評価】の `m_p ≥ m_1^p` を必要十分版から得る

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008_claim_trace_power_sandwich`、ラベル **`trace_power_sandwich`** の【単位ベクトルでの評価】）

具体版 `Ising2D.moment_ge_moment_one_pow`（`ClaimTracePowerSandwichUnitVectorBound.lean`）と同じ型の主張を、必要十分版
`Ising2D.NecSuf.IsPdPair.moment_pow_le` の特殊化から得る。内積は `x ⬝ᵥ y`（`matBilin 1`）、作用素は `W_ℝ` の定める線型写像（`mulVecLin`）で、
組は `isPdPair_of_matrix` が作る。具体版が必要十分版の特殊化として得られることの記録で、具体版の証明と通しの証明には使わない。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimTracePowerSandwichUnitVectorBound
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimMomentLogConvexityFromNecSuf

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手【単位ベクトルでの評価】の `m_p ≥ m_1^p` を必要十分版から得たもの**（具体版 `moment_ge_moment_one_pow` と同じ型）。 -/
theorem moment_ge_moment_one_pow_of_necSuf (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    {x : Conf M → ℝ} (hx : vecNorm x = 1) :
    ∀ p : ℕ, momentWReal W hW x p ≥ momentWReal W hW x 1 ^ p := by
  have hpair := isPdPair_of_matrix hWRsymm hpd
  have hsq : vecNormSq x = 1 := by
    have h := hx
    rwa [vecNorm, Real.sqrt_eq_one] at h
  have hip : matBilin (1 : Matrix (Conf M) (Conf M) ℝ) x x = 1 := by
    rw [matBilin_one_apply]
    exact hsq
  intro p
  have h := hpair.moment_pow_le (ne_zero_of_vecNorm_eq_one hx) hip p
  rw [momentWReal_eq_necSuf_moment, momentWReal_eq_necSuf_moment, pow_one]
  exact h

end Ising2D
