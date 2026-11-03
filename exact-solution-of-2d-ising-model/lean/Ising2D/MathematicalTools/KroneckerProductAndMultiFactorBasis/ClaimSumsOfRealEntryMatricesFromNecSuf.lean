/-
# 成分がすべて実数の行列の和・差・有限和（具体版を必要十分版から導く）

具体版 `matrix_add_hasRealEntries`・`matrix_sub_hasRealEntries`・`finite_sum_hasRealEntries` の主張を、必要十分版
`Ising2D/NecSuf/SumsOfClosedEntries.lean` の `add_entries_mem`・`sub_entries_mem`・`finite_sum_entries_mem` の係数 `R := ℂ`、
性質 `S := ℝ の像に入る`（`∃ r : ℝ, z = r_ℂ`）の特殊化として得る。
和で閉じること `hadd` は、具体版の和の成分の鎖と同じ計算（`real_image_add_closed`）、積で閉じること `hmul` は
`real_image_mul_closed`（`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`）、`-1` が性質に入ること `hm1` は `(-1)_ℂ` が `-1 ∈ ℝ` の像であること、
`hsub`・`hneg` は人手の `def_complex_difference`・`multiply_by_minus_one` に当たる `ℂ` の等式である。
人手のラベルは `sum_of_real_entry_matrices_has_real_entries`・`difference_of_real_entry_matrices_has_real_entries`・
`finite_sum_of_real_entry_matrices_has_real_entries`。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimSumsOfRealEntryMatricesHaveRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerOfRealEntryMatricesFromNecSuf
import Ising2D.NecSuf.SumsOfClosedEntries

namespace Ising2D

/-- `ℝ` の像は和で閉じている（具体版 `matrix_add_hasRealEntries` の成分の鎖の 3〜6 段と同じ計算）。 -/
theorem real_image_add_closed (a b : ℂ) :
    (∃ r : ℝ, a = (r : ℂ)) → (∃ r : ℝ, b = (r : ℂ)) → ∃ r : ℝ, a + b = (r : ℂ) := by
  rintro ⟨s, rfl⟩ ⟨t, rfl⟩
  refine ⟨s + t, ?_⟩
  calc (s : ℂ) + (t : ℂ)
      = (⟨s, 0⟩ : ℂ) + ⟨t, 0⟩ := rfl                                        -- `inclusion_rr_to_cc`
    _ = ⟨s + t, 0 + 0⟩ := rfl                                               -- `definition_of_cc` の和
    _ = ⟨s + t, 0⟩ := by rw [add_zero (0 : ℝ)]                              -- ℝ で `0 + 0 = 0`
    _ = ((s + t : ℝ) : ℂ) := rfl                                            -- `inclusion_rr_to_cc`

/-- `matrix_add_hasRealEntries` を `NecSuf.add_entries_mem` の特殊化として得る。 -/
theorem matrix_add_hasRealEntries_of_necSuf {α β : Type*} (A B : Matrix α β ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A + B) :=
  NecSuf.add_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_add_closed A B hA hB

/-- `matrix_sub_hasRealEntries`（と `sub_hasRealEntries_tensorPow`）を `NecSuf.sub_entries_mem` の特殊化として得る。 -/
theorem matrix_sub_hasRealEntries_of_necSuf {α β : Type*} (A B : Matrix α β ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A - B) :=
  NecSuf.sub_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) sub_eq_add_neg
    (fun x => (neg_one_mul x).symm) ⟨-1, by rw [Complex.ofReal_neg, Complex.ofReal_one]⟩
    real_image_mul_closed real_image_add_closed A B hA hB

/-- `finite_sum_hasRealEntries` を `NecSuf.finite_sum_entries_mem` の特殊化として得る。 -/
theorem finite_sum_hasRealEntries_of_necSuf {α β : Type*} (r : ℕ) (X : Fin (r + 1) → Matrix α β ℂ)
    (hX : ∀ j, MatrixHasRealEntries (X j)) : MatrixHasRealEntries (∑ j, X j) :=
  NecSuf.finite_sum_entries_mem (fun w : ℂ => ∃ r : ℝ, w = (r : ℂ)) real_image_add_closed r X hX

end Ising2D
