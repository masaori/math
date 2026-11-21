/-
# 互いに直交する冪等写像の像から 0 でない元を一つずつ取った族は基底（**必要十分版**）

人手: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts` の
`nonzero_elements_of_images_of_check_Q_form_basis`。具体版は
`Ising2D/MathematicalTools/SubspacesBasesAndDimension/ClaimNonzeroElementsOfImagesOfCheckQFormBasis.lean`、
導出は同じフォルダの `SubspacesBasesAndDimensionFromNecSuf.lean`。

人手の `Q̌_ε`（`ε ∈ {0,1}^{𝓜̌}`）を、有限集合 `ι` で添字付けた `V` の自己準同型 `Pr e`（`Module.End K V`、積は合成）に、
人手の `ℂ^{2^{M_col}}` を、`#ι` 個の元の族 `ev` で張られる `K` 加群 `V` に置き換える。段は具体版と同じ
（Step 1: `Pr e' (q e) = 0 (e ≠ e')`、`Pr e (q e) = q e`。Step 2: 線型独立。Step 3: `linearly_independent_family_of_n_vectors_is_basis`）。

## 何が効いているか / 効いていないか

- 使う `Pr` の性質は人手の `check_joint_eigenspace_decomposition` (1) の二つ（`e ≠ e'` で `Pr e' Pr e = 0`、`Pr e ^ 2 = Pr e`）だけで、
  (2) の `Σ_e Pr e = I`（直和の分解）は**使わない**。基底になることの「張る」側は、元の個数が全体を張る族の元の個数に等しいことから出る。
- 係数は `DivisionRing`（`d q = 0`、`q ≠ 0` から `d = 0` を出す段で逆元を使う。Step 3 の
  `linearly_independent_family_of_n_vectors_is_basis` も同じ）。乗法の可換性は使わない。
- `V` が行列の空間であること、`ι` が `{0,1}^{M_col}` であること、`Pr e` が射影因子の積であることは使わない。
-/
import Ising2D.NecSuf.SubspacesBasesAndDimension
import Mathlib.Algebra.Module.LinearMap.End

namespace Ising2D.NecSuf

open Finset

variable {K : Type*} {V : Type*} [DivisionRing K] [AddCommGroup V] [Module K V]
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Step 1 の前半: `e ≠ e'` なら `Pr e' (q e) = 0`。 -/
theorem projection_apply_of_ne (Pr : ι → Module.End K V) (hne : ∀ e e', e ≠ e' → Pr e' * Pr e = 0)
    {e e' : ι} (h : e ≠ e') {q x : V} (hq : q = Pr e x) : Pr e' q = 0 := by
  rw [hq,                                                          -- `x_ε` の取り方
    ← Module.End.mul_apply,                                        -- `mat_mult_associative` を右辺から左辺へ
    hne e e' h]                                                    -- `check_joint_eigenspace_decomposition` (1)
  rfl                                                              -- `zero_matrix_is_left_zero_of_mat_mult`

/-- Step 1 の後半: `Pr e (q e) = q e`。 -/
theorem projection_apply_self (Pr : ι → Module.End K V) (hsq : ∀ e, Pr e ^ 2 = Pr e)
    (e : ι) {q x : V} (hq : q = Pr e x) : Pr e q = q := by
  rw [hq,                                                          -- `x_ε` の取り方
    ← Module.End.mul_apply,                                        -- `mat_mult_associative` を右辺から左辺へ
    ← pow_two,                                                     -- `def_exp` (1) の冪を右辺から左辺へ
    hsq e]                                                         -- `check_joint_eigenspace_decomposition` (1) の `Q̌_ε^2 = Q̌_ε`

/-- **`nonzero_elements_of_images_of_check_Q_form_basis`** の必要十分版。 -/
theorem nonzero_elements_of_images_of_projections_form_basis
    (Pr : ι → Module.End K V) (hne : ∀ e e', e ≠ e' → Pr e' * Pr e = 0) (hsq : ∀ e, Pr e ^ 2 = Pr e)
    (q : ι → V) (hq : ∀ e, ∃ x, q e = Pr e x) (hq0 : ∀ e, q e ≠ 0)
    (ev : Fin (Fintype.card ι) → V) (hev : ∀ A, FamIsLinComb K A ev) (π : Fin (Fintype.card ι) ≃ ι) :
    FamIsBasis K Set.univ (q ∘ π) ∧ FamIsBasisIndexed K Set.univ q := by
  choose x hx using hq
  -- Step 2: 線型独立
  have hind : FamLinIndep K (q ∘ π) := by
    intro d hd t₀
    have hchain : d t₀ • q (π t₀) = 0 := by
      have h := congrArg (Pr (π t₀)) hd
      rw [map_zero] at h                                           -- `zero_matrix_is_right_zero_of_mat_mult`
      unfold famLinComb at h
      rw [map_sum,                                                 -- `finite_sum_of_matrices_distributes_in_right_factor`
        Finset.sum_eq_single t₀] at h                              -- `finite_sum_of_matrices_with_single_nonzero_term`
      · rw [map_smul, Function.comp_apply,                         -- `scalar_multiple_factors_out_of_right_factor`
          projection_apply_self Pr hsq (π t₀) (hx (π t₀))] at h     -- Step 1 の後半
        exact h
      · intro t _ ht
        have hne' : π t ≠ π t₀ := fun h' => ht (π.injective h')
        rw [Function.comp_apply, map_smul, projection_apply_of_ne Pr hne hne' (hx (π t)), smul_zero]
          -- Step 1 の前半・`scalar_multiple_of_zero_matrix`
      · intro h; exact absurd (Finset.mem_univ _) h
    by_contra hd0
    apply hq0 (π t₀)
    calc q (π t₀) = (1 : K) • q (π t₀) := (one_smul K _).symm      -- `scalar_multiple_by_one`
      _ = ((d t₀)⁻¹ * d t₀) • q (π t₀) := by rw [inv_mul_cancel₀ hd0]
      _ = (d t₀)⁻¹ • (d t₀ • q (π t₀)) := mul_smul _ _ _          -- `scalar_multiple_is_associative`
      _ = 0 := by rw [hchain, smul_zero]                           -- `scalar_multiple_of_zero_matrix`
  -- Step 3: `linearly_independent_family_of_n_vectors_is_basis` と `def_basis_indexed_by_finite_set`
  have hb := linearly_independent_family_of_n_vectors_is_basis ev hev (q ∘ π) hind
  exact ⟨hb, π, hb⟩

end Ising2D.NecSuf
