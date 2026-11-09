/-
# モーメント列の正値性と対数凸性を必要十分版から得る

正本: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
（`maxeig_008b_claim_moment_log_convexity`、ラベル **`moment_log_convexity`**）

具体版 `Ising2D.moment_log_convexity`（`ClaimMomentLogConvexity.lean`）と同じ型の主張を、必要十分版
`Ising2D.NecSuf.IsPdPair.moment_pos`（正値性）と `Ising2D.NecSuf.IsPsdPair.moment_log_convex`（対数凸性。添字は `k → k+1` とずらした形）の特殊化から得る。
内積は `x ⬝ᵥ y`（`matBilin 1`）、作用素は `W_ℝ` の定める線型写像（`mulVecLin`）で、組は `isPdPair_of_matrix` が作る。
具体版が必要十分版の特殊化として得られることの記録で、具体版の証明と通しの証明には使わない。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimMomentLogConvexity

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 必要十分版のモーメント `⟪x, W^kx⟫`（`matBilin 1`・`mulVecLin`）は、具体版の `m_k := x^⊤(W_ℝ)^kx`。 -/
theorem momentWReal_eq_necSuf_moment (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
    (x : Conf M → ℝ) (k : ℕ) :
    momentWReal W hW x k
      = matBilin (1 : Matrix (Conf M) (Conf M) ℝ) x
          (((realMatrixOfRealEntries W hW.1).mulVecLin ^ k) x) := by
  rw [mulVecLin_pow_apply, matBilin_one_apply]
  rfl

/-- **人手 `moment_log_convexity` を必要十分版から得たもの**（具体版 `moment_log_convexity` と同じ型）。 -/
theorem moment_log_convexity_of_necSuf (W : TensorPow M) (hW : MatrixIsRealSymmetric W)
    (hWRsymm : (realMatrixOfRealEntries W hW.1).IsSymm)
    (hpd : ∀ x : Conf M → ℝ, x ≠ 0 → 0 < x ⬝ᵥ realMatrixOfRealEntries W hW.1 *ᵥ x)
    {x : Conf M → ℝ} (hx : vecNorm x = 1) :
    (∀ k : ℕ, 0 < momentWReal W hW x k)
      ∧ ∀ k : ℕ, 1 ≤ k →
          momentWReal W hW x k ^ 2 ≤ momentWReal W hW x (k - 1) * momentWReal W hW x (k + 1) := by
  have hpair := isPdPair_of_matrix hWRsymm hpd
  refine ⟨fun k => ?_, fun k hk => ?_⟩
  · rw [momentWReal_eq_necSuf_moment]
    exact hpair.moment_pos (ne_zero_of_unit_norm hx) k
  · obtain ⟨j, rfl⟩ : ∃ j, k = j + 1 := ⟨k - 1, by omega⟩
    have h := hpair.toIsPsdPair.moment_log_convex x j
    rw [show j + 1 - 1 = j by omega, show j + 1 + 1 = j + 2 by omega,
      momentWReal_eq_necSuf_moment, momentWReal_eq_necSuf_moment, momentWReal_eq_necSuf_moment]
    exact h

end Ising2D
