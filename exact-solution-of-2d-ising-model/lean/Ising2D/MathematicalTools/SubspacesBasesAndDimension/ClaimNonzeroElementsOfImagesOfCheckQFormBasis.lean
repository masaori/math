/-
# `im Q̌_ε` から 0 でない元を一つずつ取った族は基底（具体版）

対応する人手証明: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` の
`nonzero_elements_of_images_of_check_Q_form_basis`。

記号の読み替え: 人手の `ε ∈ {0,1}^{𝓜̌}` は、`ClaimCheckJointEigenspace.lean` と同じく `ε(μ) = 1` となる `μ` の集合
`T : Finset (CheckIdx M)`、人手の `Q̌_ε` は `F.Qproj T`、人手の `ℂ^{2^{M_col}}` は `Matrix (Conf M) (Fin 1) ℂ`
（`SubspacesBasesAndDimension.lean` の冒頭の読み替え）。人手の `N := 2^{M_col}` は `Fintype.card (Finset (CheckIdx M))`。

| 人手の段 | Lean |
| --- | --- |
| Step 1 の `ε ≠ ε'` の 4 行の鎖 | `Qproj_mul_image_of_ne` |
| Step 1 の `Q̌_ε q_ε = q_ε` の鎖（`def_matrix_power` の冪を経て (1) の `Q̌_ε^2 = Q̌_ε`） | `Qproj_mul_image_self`（Lean の (1) は `Qproj_mul_self` の積の形なので冪の 3 行は要らない） |
| Step 2（線型独立。`t ≠ t_0` の 3 行の鎖、`d_{t_0} q_{ε'}` の 7 行の鎖、逆元の 5 行の鎖） | `nonzero_elements_of_images_of_check_Q_form_basis` の `hind` |
| Step 3（`linearly_independent_family_of_n_vectors_is_basis` と `def_basis_indexed_by_finite_set`） | 同じ定理の最後の 2 行 |

必要十分版は `Ising2D/NecSuf/NonzeroElementsOfImagesOfProjectionsFormBasis.lean`、導出は同じフォルダの
`SubspacesBasesAndDimensionFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.SubspacesBasesAndDimension.SubspacesBasesAndDimension
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimCheckJointEigenspace

namespace Ising2D

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- Step 1 の前半: `ε ≠ ε'` なら `Q̌_{ε'} q_ε = O`。 -/
theorem Qproj_mul_image_of_ne {T T' : Finset (CheckIdx M)} (h : T ≠ T') {q x : Matrix (Conf M) (Fin 1) ℂ}
    (hq : q = F.Qproj T * x) : F.Qproj T' * q = 0 := by
  rw [hq,                                                          -- `x_ε` の取り方
    ← Matrix.mul_assoc,                                            -- `mat_mult_associative` を右辺から左辺へ
    F.Qproj_mul_Qproj_of_ne h.symm,                                -- `check_joint_eigenspace_decomposition` (1)
    Matrix.zero_mul]                                               -- `zero_matrix_is_left_zero_of_mat_mult`

/-- Step 1 の後半: `Q̌_ε q_ε = q_ε`。 -/
theorem Qproj_mul_image_self (T : Finset (CheckIdx M)) {q x : Matrix (Conf M) (Fin 1) ℂ}
    (hq : q = F.Qproj T * x) : F.Qproj T * q = q := by
  rw [hq,                                                          -- `x_ε` の取り方
    ← Matrix.mul_assoc,                                            -- `mat_mult_associative` を右辺から左辺へ
    F.Qproj_mul_self T]                                            -- `check_joint_eigenspace_decomposition` (1) の `Q̌_ε^2 = Q̌_ε`

/-- 人手の `N = 2^{M_col}`: 数ベクトルの添字の個数と `{0,1}^{𝓜̌}` の元の個数は等しい。 -/
theorem card_conf_eq_card_finset_checkIdx :
    Fintype.card (Conf M) = Fintype.card (Finset (CheckIdx M)) := by
  rw [Fintype.card_finset, CheckIdx.card, Fintype.card_fun, Fintype.card_fin, Fintype.card_fin]

/-- **`nonzero_elements_of_images_of_check_Q_form_basis`**。 -/
theorem nonzero_elements_of_images_of_check_Q_form_basis
    (q : Finset (CheckIdx M) → Matrix (Conf M) (Fin 1) ℂ) (hq : ∀ T, ∃ x, q T = F.Qproj T * x)
    (hq0 : ∀ T, q T ≠ 0) (π : Fin (Fintype.card (Finset (CheckIdx M))) ≃ Finset (CheckIdx M)) :
    MatIsBasis Set.univ (q ∘ π) ∧ MatIsBasisIndexed Set.univ q := by
  choose x hx using hq
  -- Step 2（線型独立）
  have hind : MatLinIndep (q ∘ π) := by
    intro d hd t₀
    have hchain : d t₀ • q (π t₀) = 0 := by
      have h := congrArg (fun y : Matrix (Conf M) (Fin 1) ℂ => F.Qproj (π t₀) * y) hd
      simp only [Matrix.mul_zero] at h                             -- `zero_matrix_is_right_zero_of_mat_mult`
      unfold matLinComb at h
      rw [Matrix.mul_sum,                                          -- `finite_sum_of_matrices_distributes_in_right_factor`
        Finset.sum_eq_single t₀] at h                              -- `finite_sum_of_matrices_with_single_nonzero_term`
      · rw [Function.comp_apply, Matrix.mul_smul,                  -- `scalar_multiple_factors_out_of_right_factor`
          F.Qproj_mul_image_self (π t₀) (hx (π t₀))] at h           -- Step 1 の後半
        exact h
      · intro t _ ht
        have hne' : π t ≠ π t₀ := fun h' => ht (π.injective h')
        rw [Function.comp_apply, Matrix.mul_smul, F.Qproj_mul_image_of_ne hne' (hx (π t)), smul_zero]
          -- Step 1 の前半・`scalar_multiple_of_zero_matrix`
      · intro h; exact absurd (Finset.mem_univ _) h
    by_contra hd0
    apply hq0 (π t₀)
    calc q (π t₀) = (1 : ℂ) • q (π t₀) := (one_smul ℂ _).symm     -- `scalar_multiple_by_one`
      _ = ((d t₀)⁻¹ * d t₀) • q (π t₀) := by rw [inv_mul_cancel₀ hd0]   -- `β d_{t_0} = 1_ℂ`
      _ = (d t₀)⁻¹ • (d t₀ • q (π t₀)) := mul_smul _ _ _          -- `scalar_multiple_is_associative`
      _ = 0 := by rw [hchain, smul_zero]                           -- `scalar_multiple_of_zero_matrix`
  -- Step 3（`linearly_independent_family_of_n_vectors_is_basis`・`def_basis_indexed_by_finite_set`）
  have hb := linearly_independent_family_of_n_vectors_is_basis (card_conf_eq_card_finset_checkIdx (M := M)) (q ∘ π) hind
  exact ⟨hb, π, hb⟩

end CheckFermiSetup

end Ising2D
