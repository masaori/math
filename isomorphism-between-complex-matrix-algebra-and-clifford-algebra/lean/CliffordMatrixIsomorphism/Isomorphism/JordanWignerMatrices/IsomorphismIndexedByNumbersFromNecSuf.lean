/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、Ω̂ が直交基底の元の像を送る先と系の定理の具体版を、
各段の導出版から組み立てた導出版。

運び方: 前半の導出版（`ConjugatedIsomorphismFromNecSuf.lean` の冒頭）と同じく、具体版の Cl(Y,Q) と必要十分版のそれは別の集合なので、
必要十分版の主張を直に特殊化しない。具体版と同じ calc の行を、各行が引く主張の導出版
（`conjugatedHomomorphismToMatrix_first_of_necSuf`・`…_second_of_necSuf`・`conjugatedHomomorphisms_mutually_inverse_of_family_of_necSuf`・
`firstSiteHighestReindexMatrix_jordanWignerZ_of_necSuf`・`…Y_of_necSuf`・`reindexMatrix_isComplexAlgebraHomomorphism_of_necSuf`・
`inverseReindexMatrix_isComplexAlgebraHomomorphism_of_necSuf`・`IsComplexAlgebraHomomorphism.comp_of_necSuf`・
`inverseReindexMatrix_reindexMatrix_of_necSuf`・`reindexMatrix_inverseReindexMatrix_of_necSuf`・`orthonormalBasis_spec_of_necSuf`）で書き直す。
Ω̂・Ω̂' は具体版の定義をそのまま使う。

  具体版                                                         導出版
  numberedHomomorphismToMatrix_first・…_second                   …_of_necSuf
  numberedHomomorphisms_mutually_inverse_of_family・
  numberedHomomorphisms_mutually_inverse                         …_of_necSuf
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IsomorphismIndexedByNumbers
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IndexedByNumbersFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphismFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixReindexing.MatrixReindexingFromNecSuf

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### Ω̂ が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix` を、
各段の導出版から具体版と同じ手順で組み立てたもの。 -/
theorem numberedHomomorphismToMatrix_first_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e m)) = numberedJordanWignerZ D.M m := calc
  D.numberedHomomorphismToMatrix QY e he (QY.γ (e m))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m))) := rfl
  -- claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerZ D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_first_of_necSuf QY e he m hm]
  -- claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers
  _ = numberedJordanWignerZ D.M m := firstSiteHighestReindexMatrix_jordanWignerZ_of_necSuf D.M m

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix` を、
各段の導出版から具体版と同じ手順で組み立てたもの。 -/
theorem numberedHomomorphismToMatrix_second_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = numberedJordanWignerY D.M m := calc
  D.numberedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))) := rfl
  -- claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerY D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_second_of_necSuf QY e he m hm]
  -- claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers
  _ = numberedJordanWignerY D.M m := firstSiteHighestReindexMatrix_jordanWignerY_of_necSuf D.M m

/-! ### 系の定理 -/

/-- 系の定理の本体（`numberedHomomorphisms_mutually_inverse_of_family`）を、各段の導出版から組み立てたもの。 -/
theorem numberedHomomorphisms_mutually_inverse_of_family_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M)
        (D.numberedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra
        (D.numberedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.numberedHomomorphismFromMatrix QY e he (D.numberedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ G : Mat (Idx (twoPower D.M)),
        D.numberedHomomorphismToMatrix QY e he (D.numberedHomomorphismFromMatrix QY e he G) = G) ∧
      Function.Bijective (D.numberedHomomorphismToMatrix QY e he) ∧
      (∀ (G : Mat (Idx (twoPower D.M))) (a : QY.Cl),
        D.numberedHomomorphismToMatrix QY e he a = G → a = D.numberedHomomorphismFromMatrix QY e he G) := by
  let ν := firstSiteHighestReindexMatrix D.M
  let μ := firstSiteHighestInverseReindexMatrix D.M
  let Ω := D.conjugatedHomomorphismToMatrix QY e he
  let Ω' := D.conjugatedHomomorphismFromMatrix QY e he
  let Ω₁ := D.numberedHomomorphismToMatrix QY e he
  let Ω₁' := D.numberedHomomorphismFromMatrix QY e he
  -- Ω と Ω' は ℂ-代数の準同型で、互いに逆である
  -- （theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms）
  obtain ⟨hΩ, hΩ', hΩ'Ω, hΩΩ', -, -⟩ := D.conjugatedHomomorphisms_mutually_inverse_of_family_of_necSuf QY e he
  -- ν_{r_M} と μ_{r_M} は ℂ-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism、
  -- claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism）
  have hν : IsComplexAlgebraHomomorphism D.matrixAlgebra (numberedMatrixAlgebra D.M) ν :=
    reindexMatrix_isComplexAlgebraHomomorphism_of_necSuf (isFiniteSet_powerSet D.M) (firstSiteHighestNumbering_isNumbering D.M)
  have hμ : IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) D.matrixAlgebra μ :=
    inverseReindexMatrix_isComplexAlgebraHomomorphism_of_necSuf (isFiniteSet_powerSet D.M)
      (firstSiteHighestNumbering_isNumbering D.M)
  -- 合成 Ω̂ と Ω̂' は ℂ-代数の準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hΩ₁ : IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M) Ω₁ :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := Ω) (ψ := ν) hΩ hν
  have hΩ₁' : IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra Ω₁' :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := μ) (ψ := Ω') hμ hΩ'
  have hΩ₁'Ω₁ : ∀ a : QY.Cl, Ω₁' (Ω₁ a) = a := fun a => calc
    Ω₁' (Ω₁ a)
        -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
        = Ω₁' (ν (Ω a)) := rfl
    -- def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers
    _ = Ω' (μ (ν (Ω a))) := rfl
    -- claim_inverse_reindexing_after_reindexing_of_matrices_is_identity
    _ = Ω' (Ω a) := by
        rw [show μ (ν (Ω a)) = Ω a from
          inverseReindexMatrix_reindexMatrix_of_necSuf (firstSiteHighestNumbering_isNumbering D.M) (Ω a)]
    -- theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
    _ = a := hΩ'Ω a
  have hΩ₁Ω₁' : ∀ G : Mat (Idx (twoPower D.M)), Ω₁ (Ω₁' G) = G := fun G => calc
    Ω₁ (Ω₁' G)
        -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
        = ν (Ω (Ω₁' G)) := rfl
    -- def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers
    _ = ν (Ω (Ω' (μ G))) := rfl
    -- theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
    _ = ν (μ G) := by rw [show Ω (Ω' (μ G)) = μ G from hΩΩ' (μ G)]
    -- claim_reindexing_after_inverse_reindexing_of_matrices_is_identity
    _ = G := reindexMatrix_inverseReindexMatrix_of_necSuf (firstSiteHighestNumbering_isNumbering D.M) G
  -- 単射であること
  have hinj : Function.Injective Ω₁ := by
    intro a a' haa'
    calc a = Ω₁' (Ω₁ a) := (hΩ₁'Ω₁ a).symm
      _ = Ω₁' (Ω₁ a') := by rw [haa']
      _ = a' := hΩ₁'Ω₁ a'
  -- 全射であること
  have hsurj : Function.Surjective Ω₁ := fun G => ⟨Ω₁' G, hΩ₁Ω₁' G⟩
  -- Ω̂^{-1}(G) = Ω̂'(G)
  have hinv : ∀ (G : Mat (Idx (twoPower D.M))) (a : QY.Cl), Ω₁ a = G → a = Ω₁' G := by
    intro G a ha
    apply hinj
    calc Ω₁ a = G := ha
      _ = Ω₁ (Ω₁' G) := (hΩ₁Ω₁' G).symm
  exact ⟨hΩ₁, hΩ₁', hΩ₁'Ω₁, hΩ₁Ω₁', ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms`
を、各段の導出版から組み立てたもの（e := `orthonormalBasis`）。 -/
theorem numberedHomomorphisms_mutually_inverse_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis QY hdim hQ
    let he := D.orthonormalBasis_spec QY hdim hQ
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M)
        (D.numberedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra
        (D.numberedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.numberedHomomorphismFromMatrix QY e he (D.numberedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ G : Mat (Idx (twoPower D.M)),
        D.numberedHomomorphismToMatrix QY e he (D.numberedHomomorphismFromMatrix QY e he G) = G) ∧
      Function.Bijective (D.numberedHomomorphismToMatrix QY e he) ∧
      (∀ (G : Mat (Idx (twoPower D.M))) (a : QY.Cl),
        D.numberedHomomorphismToMatrix QY e he a = G → a = D.numberedHomomorphismFromMatrix QY e he G) :=
  D.numberedHomomorphisms_mutually_inverse_of_family_of_necSuf QY _ (D.orthonormalBasis_spec_of_necSuf QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
