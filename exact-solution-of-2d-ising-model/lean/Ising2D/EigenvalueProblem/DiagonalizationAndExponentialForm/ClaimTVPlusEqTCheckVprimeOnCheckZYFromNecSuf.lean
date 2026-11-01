/-
# `T_{(V^{(+)})}` と `T_{(V̌')}` の `Ž, Y̌` 上の一致の Step 1・Step 3 を**必要十分版から導出**する

対応する人手証明のラベル: `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evenfermi_007_claim_T_eq_on_check_Z_Y`）

具体版（人手と 1 対 1）は `ClaimTVPlusEqTCheckVprimeOnCheckZY.lean` の `checkZY_row_eq_rowMul_checkPmat_inv`（Step 1）と
`eq_on_checkZY_of_eq_on_checkPsi`（Step 1 と Step 3）、必要十分版は `Ising2D/NecSuf/RowVectorRightInverse.lean` の
`Ising2D.NecSuf.eq_rowMul2_of_rowMul2_eq` と `Ising2D.NecSuf.linear_eq_on_of_rowMul2_eq`。

特殊化の中身は、係数を `ℂ`、台を `Mat(2,ℂ)^{⊗M}`、`G := P̌_μ`、`H := P̌_μ^{-1}` とし、
`P̌_μ P̌_μ^{-1} = I`（`det_checkPmat_ne_zero`）と `(ψ̌_μ^†, ψ̌_μ) = (Ž_μ, Y̌_μ) P̌_μ` を渡すことだけである。
`Ising2D.rowMul` は `NecSuf.rowMul2` の係数を `ℂ` にしたものと定義が同じである。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimTVPlusEqTCheckVprimeOnCheckZY
import Ising2D.NecSuf.RowVectorRightInverse

namespace Ising2D

variable {M : ℕ}

/-- **`checkZY_row_eq_rowMul_checkPmat_inv`（Step 1）を `NecSuf.eq_rowMul2_of_rowMul2_eq` の特殊化として導いたもの**。 -/
theorem checkZY_row_eq_rowMul_checkPmat_inv_of_necSuf (P : IsingParam) (hM : M ≠ 0) (μ : ℤ) :
    (checkZ M μ, checkY M μ)
      = rowMul (checkPsiDag P.const M μ, checkPsi P.const M μ) (checkPmat P.const M μ)⁻¹ := by
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)
  exact NecSuf.eq_rowMul2_of_rowMul2_eq (Matrix.mul_nonsing_inv _ hdet)
    (checkPsi_row_eq_rowMul_checkPmat P.const M μ).symm

/-- **`eq_on_checkZY_of_eq_on_checkPsi` を `NecSuf.linear_eq_on_of_rowMul2_eq` の特殊化として導いたもの**。 -/
theorem eq_on_checkZY_of_eq_on_checkPsi_of_necSuf (P : IsingParam) (hM : M ≠ 0) (μ : ℤ)
    {T₁ T₂ : TensorPow M →ₗ[ℂ] TensorPow M}
    (hdag : T₁ (checkPsiDag P.const M μ) = T₂ (checkPsiDag P.const M μ))
    (hpsi : T₁ (checkPsi P.const M μ) = T₂ (checkPsi P.const M μ)) :
    T₁ (checkZ M μ) = T₂ (checkZ M μ) ∧ T₁ (checkY M μ) = T₂ (checkY M μ) := by
  have hdet : IsUnit (checkPmat P.const M μ).det :=
    isUnit_iff_ne_zero.2 (det_checkPmat_ne_zero P hM μ)
  exact NecSuf.linear_eq_on_of_rowMul2_eq (Matrix.mul_nonsing_inv _ hdet)
    (checkPsi_row_eq_rowMul_checkPmat P.const M μ).symm hdag hpsi

end Ising2D
