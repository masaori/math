/-
# `Mat(2^M, ℂ)` の単位行列・スカラー倍・差の数ベクトルへの作用（**具体版**）

対応する人手証明のラベル: `identity_matrix_is_left_unit_of_mat_mult`・`scalar_multiple_factors_out_of_left_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_claim_identity_matrix_is_left_unit_of_mat_mult`・
`linear_space_general_claim_scalar_multiple_factors_out_of_left_factor`）の右の因子が数ベクトルの場合と、
`matrix_difference_zero_iff_equal`（`p = 1`。数ベクトル）・`matrix_difference_mul_vector`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の `finite_matrix_claim_difference_is_zero_iff_equal`・
`finite_matrix_claim_difference_distributes_over_vector_product`）の、行列が `Mat(2^M, ℂ)`・数ベクトルが `ℂ^{2^M}` の場合（`m, n → 2^M`）。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので `2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatrixVectorIdentityScalarDifference.lean`。具体版をその系として導くのは
`ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列と `ℂ^{2^M}` の数ベクトルは成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` と `Conf M → ℂ` は
多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。`ν^{-1}`（Lean の `σ : Fin n → Conf M`、`exists_inverse_of_kronecker_numbering`）で番号へ移した成分
`A (σ i) (σ k)`・`v (σ k)` が人手の `A_{ik}`・`v_k` である（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。主張は次の順に示す。

* 数ベクトルの等号を、番号で読んだ全ての成分の等号にする（`confVec_eq_iff_entries_by_kronecker_numbering`、`def_complex_number_vectors`）。
* 行列と数ベクトルの積・スカラー倍・差・零ベクトルの成分を、番号の上の本文の式へ移す（`tensorPow_mulVec_apply_eq_mat_mult`（`mat_mult`）・
  `tensorPow_one_apply_eq_identity_matrix`（`def_identity_matrix`）・`tensorPow_smul_apply`・`confVec_smul_apply`（`def_matrix_scalar_multiple`）・
  `tensorPow_sub_apply`・`confVec_sub_apply`（`def_matrix_difference`）・`confVec_zero_apply`（`def_zero_matrix`））。
  これで両辺の成分は、番号で読んだ成分の行列 `Aν`（`Fin n` の添字）と数ベクトル `vν`（`Fin n → ℂ`）の同じ式になる。
* 番号で読んだ成分の行列・数ベクトルについて人手の主張（`ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean` の
  `identity_matrix_mulVec`・`smul_mulVec_eq`・`vec_sub_eq_zero_iff`・`sub_mulVec_eq`）を引く。人手の主張は任意の `m, n` について述べてあり、
  ここはその `2^M` の場合である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

open Matrix

/-- **`def_complex_number_vectors`**（`ℂ^{2^M}`）: Lean の数ベクトル `Conf M → ℂ` の二つが等しいことは、`ν^{-1}` で番号へ移した全ての成分
`u (ν^{-1}(k))`・`w (ν^{-1}(k))` が等しいことと同じである（Lean だけの段の補題。`tensorPow_entries_by_kronecker_numbering` の数ベクトルの場合）。 -/
theorem confVec_eq_iff_entries_by_kronecker_numbering (M : ℕ) :
    ∀ (n : ℕ), (∀ I : Conf M, ∃ k : Fin n, kroneckerNumbering I = finIndexToZZ n k) →
      ∀ (σ : Fin n → Conf M), (∀ k, kroneckerNumbering (σ k) = finIndexToZZ n k) →
        ∀ u w : Conf M → ℂ, u = w ↔ ∀ k : Fin n, u (σ k) = w (σ k) := by
  intro n hord σ hσ u w
  -- `σ` の全射は `ν` の単射から（`kronecker_numbering_injective`）
  have hsurj : ∀ I : Conf M, ∃ k : Fin n, σ k = I := fun I => by
    obtain ⟨k, hk⟩ := hord I
    exact ⟨k, kronecker_numbering_injective _ _ (by rw [hσ, hk])⟩
  refine ⟨fun h k => by rw [h], fun h => ?_⟩
  funext I                                                  -- 写像の等号は点ごと（`set_and_algebra_notation`）
  obtain ⟨k, rfl⟩ := hsurj I
  exact h k

/-- **`identity_matrix_is_left_unit_of_mat_mult`**（`Mat(2^M, ℂ)`、右の因子が数ベクトル）: `I v = v`（`v ∈ ℂ^{2^M}`）。 -/
theorem identity_matrix_mulVec_tensorPow {M : ℕ} (v : Conf M → ℂ) : (1 : TensorPow M) *ᵥ v = v := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の数ベクトル `v_j`（`ℂ^{2^M}` の元）
  set vν : Fin n → ℂ := fun j => v (σ j) with hvν
  refine (confVec_eq_iff_entries_by_kronecker_numbering M n hord σ hσ _ _).2 fun i => ?_
  calc ((1 : TensorPow M) *ᵥ v) (σ i)
      = ∑ j : Fin n, (1 : TensorPow M) (σ i) (σ j) * v (σ j) :=
        tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ _ _ i        -- `mat_mult` の `p = 1`
    _ = ∑ j : Fin n, (1 : Matrix (Fin n) (Fin n) ℂ) i j * vν j := by
        simp only [tensorPow_one_apply_eq_identity_matrix M n σ hσ, identity_matrix_apply, hvν]
                                                                       -- `def_identity_matrix`
    _ = ((1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ vν) i := (mulVec_apply_sum _ _ _).symm  -- `mat_mult` の `p = 1`
    _ = vν i := by rw [identity_matrix_mulVec]                         -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = v (σ i) := rfl                                                 -- 番号で読んだ成分の数ベクトル `vν` の定義

/-- **`scalar_multiple_factors_out_of_left_factor`**（`Mat(2^M, ℂ)`、右の因子が数ベクトル）: `(λB)v = λ(Bv)`。 -/
theorem smul_mulVec_tensorPow {M : ℕ} (lam : ℂ) (B : TensorPow M) (v : Conf M → ℂ) :
    (lam • B) *ᵥ v = lam • (B *ᵥ v) := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `B_{jl}` と数ベクトル `v_j`
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  set vν : Fin n → ℂ := fun j => v (σ j) with hvν
  refine (confVec_eq_iff_entries_by_kronecker_numbering M n hord σ hσ _ _).2 fun i => ?_
  calc ((lam • B) *ᵥ v) (σ i)
      = ∑ j : Fin n, (lam • B) (σ i) (σ j) * v (σ j) :=
        tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ _ _ i        -- `mat_mult` の `p = 1`
    _ = ∑ j : Fin n, (lam • Bν) i j * vν j := by
        simp only [tensorPow_smul_apply, matrix_smul_apply, hBν, hvν, Matrix.of_apply]
                                                                       -- `def_matrix_scalar_multiple`、`Bν`・`vν` の定義
    _ = ((lam • Bν) *ᵥ vν) i := (mulVec_apply_sum _ _ _).symm          -- `mat_mult` の `p = 1`
    _ = (lam • (Bν *ᵥ vν)) i := by rw [smul_mulVec_eq]                 -- `scalar_multiple_factors_out_of_left_factor`
    _ = lam * (Bν *ᵥ vν) i := vec_smul_apply _ _ _                     -- `def_matrix_scalar_multiple`（`n = 1`）
    _ = lam * ∑ j : Fin n, Bν i j * vν j := by rw [mulVec_apply_sum]   -- `mat_mult` の `p = 1`
    _ = lam * ∑ j : Fin n, B (σ i) (σ j) * v (σ j) := by
        simp only [hBν, hvν, Matrix.of_apply]                          -- `Bν`・`vν` の定義
    _ = lam * (B *ᵥ v) (σ i) := by
        rw [tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ B v i]    -- `mat_mult` の `p = 1`
    _ = (lam • (B *ᵥ v)) (σ i) := (confVec_smul_apply _ _ _).symm      -- `def_matrix_scalar_multiple`（`n = 1`）

/-- **`matrix_difference_zero_iff_equal`**（`ℂ^{2^M}`、`p = 1`。数ベクトル）: `u - w = 0 ⟺ u = w`。 -/
theorem vec_sub_eq_zero_iff_tensorPow {M : ℕ} (u w : Conf M → ℂ) : u - w = 0 ↔ u = w := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の数ベクトル `u_j`・`w_j`
  set uν : Fin n → ℂ := fun j => u (σ j) with huν
  set wν : Fin n → ℂ := fun j => w (σ j) with hwν
  have hent := confVec_eq_iff_entries_by_kronecker_numbering M n hord σ hσ
  calc u - w = 0
      ↔ ∀ k : Fin n, (u - w) (σ k) = (0 : Conf M → ℂ) (σ k) := hent _ _  -- 数ベクトルの等号は成分ごと（`def_complex_number_vectors`）
    _ ↔ ∀ k : Fin n, (uν - wν) k = (0 : Fin n → ℂ) k := by
        simp only [confVec_sub_apply, confVec_zero_apply, vec_sub_apply, vec_zero_apply, huν, hwν]
                                                                       -- `def_matrix_difference`・`def_zero_matrix`、`uν`・`wν` の定義
    _ ↔ uν - wν = 0 := funext_iff.symm                                 -- 数ベクトルの等号は成分ごと
    _ ↔ uν = wν := vec_sub_eq_zero_iff uν wν                           -- `matrix_difference_zero_iff_equal`（`p = 1`）
    _ ↔ ∀ k : Fin n, uν k = wν k := funext_iff                         -- 数ベクトルの等号は成分ごと
    _ ↔ ∀ k : Fin n, u (σ k) = w (σ k) := by simp only [huν, hwν]      -- 番号で読んだ成分の数ベクトル `uν`・`wν` の定義
    _ ↔ u = w := (hent _ _).symm                                       -- 数ベクトルの等号は成分ごと（`def_complex_number_vectors`）

/-- **`matrix_difference_mul_vector`**（`Mat(2^M, ℂ)`）: `Av - Bv = (A - B)v`。 -/
theorem sub_mulVec_tensorPow {M : ℕ} (A B : TensorPow M) (v : Conf M → ℂ) :
    A *ᵥ v - B *ᵥ v = (A - B) *ᵥ v := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 番号で読んだ成分の行列 `A_{jl}`・`B_{jl}` と数ベクトル `v_j`
  set Aν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => A (σ j) (σ l) with hAν
  set Bν : Matrix (Fin n) (Fin n) ℂ := Matrix.of fun j l => B (σ j) (σ l) with hBν
  set vν : Fin n → ℂ := fun j => v (σ j) with hvν
  refine (confVec_eq_iff_entries_by_kronecker_numbering M n hord σ hσ _ _).2 fun i => ?_
  calc (A *ᵥ v - B *ᵥ v) (σ i)
      = (A *ᵥ v) (σ i) - (B *ᵥ v) (σ i) := confVec_sub_apply _ _ _    -- `def_matrix_difference`（`p = 1`）
    _ = ∑ j : Fin n, A (σ i) (σ j) * v (σ j) - ∑ j : Fin n, B (σ i) (σ j) * v (σ j) := by
        rw [tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ A v i,
          tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ B v i]       -- `mat_mult` の `p = 1`
    _ = ∑ j : Fin n, Aν i j * vν j - ∑ j : Fin n, Bν i j * vν j := by
        simp only [hAν, hBν, hvν, Matrix.of_apply]                     -- `Aν`・`Bν`・`vν` の定義
    _ = (Aν *ᵥ vν) i - (Bν *ᵥ vν) i := by rw [mulVec_apply_sum, mulVec_apply_sum]  -- `mat_mult` の `p = 1`
    _ = (Aν *ᵥ vν - Bν *ᵥ vν) i := (vec_sub_apply _ _ _).symm          -- `def_matrix_difference`（`p = 1`）
    _ = ((Aν - Bν) *ᵥ vν) i := by rw [sub_mulVec_eq]                   -- `matrix_difference_mul_vector`
    _ = ∑ j : Fin n, (Aν - Bν) i j * vν j := mulVec_apply_sum _ _ _    -- `mat_mult` の `p = 1`
    _ = ∑ j : Fin n, (A - B) (σ i) (σ j) * v (σ j) := by
        simp only [tensorPow_sub_apply, matrix_sub_apply, hAν, hBν, hvν, Matrix.of_apply]
                                                                       -- `def_matrix_difference`、`Aν`・`Bν`・`vν` の定義
    _ = ((A - B) *ᵥ v) (σ i) :=
        (tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ _ _ i).symm  -- `mat_mult` の `p = 1`

end Ising2D
