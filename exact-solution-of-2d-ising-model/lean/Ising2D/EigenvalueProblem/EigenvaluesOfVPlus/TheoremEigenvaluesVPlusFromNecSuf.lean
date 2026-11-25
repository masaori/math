/-
# `V^{(+)}` の固有値の大小の比較（具体版を必要十分版から導く）

具体版 `TheoremEigenvaluesVPlus.lean` の `checkBigLambda_le_checkBigLambda_univ`・`checkBigLambda_empty_le_checkBigLambda`
（人手 `eigenvalues_of_V_plus` (2) の大小の比較）の主張を、必要十分版 `Ising2D/NecSuf/SimpleEigenvalue.lean` の
`sum_weight_le_univ`・`sum_weight_empty_le` の `R := ℝ`、`k := halfSign` への特殊化として得る。

ここで得る形は重みが非負（`0 ≤ g`）で足り、具体版の仮定 `0 < g`（人手の `γ(θ~_μ) > 0`）より弱い。具体版の主張は、
この形に `le_of_lt` で `0 < g` から `0 ≤ g` を渡した特殊化である。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremEigenvaluesVPlus
import Ising2D.NecSuf.SimpleEigenvalue

namespace Ising2D

section EigenVPlusFromNecSuf

variable {M : ℕ}

/-- **`checkBigLambda_le_checkBigLambda_univ` を必要十分版から導く**: 必要十分版 `NecSuf.sum_weight_le_univ`
（重みは非負で足りる）を `R := ℝ`、`k := halfSign` へ特殊化し、具体版 `checkBigLambda_le_checkBigLambda_univ` と同じく `a > 0` と
`exp` の単調性で `Λ̌` へ移す。 -/
theorem checkBigLambda_le_checkBigLambda_univ_of_necSuf (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 T ≤ checkBigLambda F g s2 Finset.univ := by
  haveI : Nonempty (CheckIdx M) := ⟨CheckFermiSetup.checkIdxOfFin ⟨0, Nat.pos_of_ne_zero F.hM⟩⟩
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
  exact mul_le_mul_of_nonneg_left (real_exp_le_exp_of_le
    (NecSuf.sum_weight_le_univ halfSign (by rw [halfSign_one_sub_halfSign_zero]; exact zero_le_one) g hg T))
    (le_of_lt hapos)

/-- **`checkBigLambda_empty_le_checkBigLambda` を必要十分版から導く**: 必要十分版 `NecSuf.sum_weight_empty_le`（重みは非負で足りる）の `R := ℝ`、`k := halfSign` への特殊化。 -/
theorem checkBigLambda_empty_le_checkBigLambda_of_necSuf (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 (∅ : Finset (CheckIdx M)) ≤ checkBigLambda F g s2 T := by
  haveI : Nonempty (CheckIdx M) := ⟨CheckFermiSetup.checkIdxOfFin ⟨0, Nat.pos_of_ne_zero F.hM⟩⟩
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
  exact mul_le_mul_of_nonneg_left (real_exp_le_exp_of_le
    (NecSuf.sum_weight_empty_le halfSign (by rw [halfSign_one_sub_halfSign_zero]; exact zero_le_one) g hg T))
    (le_of_lt hapos)

end EigenVPlusFromNecSuf

end Ising2D
