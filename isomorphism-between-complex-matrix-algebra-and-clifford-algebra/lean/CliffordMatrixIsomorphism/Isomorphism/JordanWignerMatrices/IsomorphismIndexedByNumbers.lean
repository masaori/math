/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、Ω・Ω' を番号の行列環
Mat_{1,…,2^M}(ℂ) へ移した写像 Ω̂ := ν_{r_M} ∘ Ω・Ω̂' := Ω' ∘ μ_{r_M} と、Ω̂ が値が 1 の直交基底の元の像を送る先と、系の定理の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers      numberedHomomorphismToMatrix（Ω̂）
  def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers      numberedHomomorphismFromMatrix（Ω̂'）
  claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
                                                                                     numberedHomomorphismToMatrix_first
  claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
                                                                                     numberedHomomorphismToMatrix_second
  theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms
                                                                                     numberedHomomorphisms_mutually_inverse_of_family・
                                                                                     numberedHomomorphisms_mutually_inverse

表し方:
- 前提の組は前半の `ConjugatedIsomorphism.lean` と同じく `D : SplitData W`、`QY`、e と e の三つの条件 `he` で受ける。
  Ω̂・Ω̂' と二つの主張は e と `he` を引数にとり、系の定理では e := `orthonormalBasis` とする（`numberedHomomorphisms_mutually_inverse`）。
- B̂ := Mat_{1,…,2^M}(ℂ) は `numberedMatrixAlgebra D.M`（`IndexedByNumbers.lean`）、ν_{r_M}・μ_{r_M} は `firstSiteHighestReindexMatrix D.M`・
  `firstSiteHighestInverseReindexMatrix D.M`、Ω・Ω' は `conjugatedHomomorphismToMatrix`・`conjugatedHomomorphismFromMatrix`。
- 系の定理の「Ω̂ は全単射であり、その逆写像は Ω̂'」は、前半の系の定理と同じく `Function.Bijective` と
  「Ω̂(a) = G を満たす a は Ω̂'(G) である」で書く。
- 本文の系の定理の証明の「ν_{r_M} と μ_{r_M} は ℂ-代数の準同型」は、def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit
  が述べる「(2^M, r_M) は P_M の番号付け」（`firstSiteHighestNumbering_isNumbering`）を二つの主張に渡す。

本文が引く主張は次の宣言を引く。
  claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix     conjugatedHomomorphismToMatrix_first
  claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix    conjugatedHomomorphismToMatrix_second
  claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers           firstSiteHighestReindexMatrix_jordanWignerZ
  claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers           firstSiteHighestReindexMatrix_jordanWignerY
  theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
                                                                                     conjugatedHomomorphisms_mutually_inverse_of_family
  claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism                 reindexMatrix_isComplexAlgebraHomomorphism
  claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism         inverseReindexMatrix_isComplexAlgebraHomomorphism
  claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism                IsComplexAlgebraHomomorphism.comp
  claim_inverse_reindexing_after_reindexing_of_matrices_is_identity                 inverseReindexMatrix_reindexMatrix
  claim_reindexing_after_inverse_reindexing_of_matrices_is_identity                 reindexMatrix_inverseReindexMatrix

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/IsomorphismIndexedByNumbers.lean`、導出版は `IsomorphismIndexedByNumbersFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphism
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IndexedByNumbers

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### Ω・Ω' を番号の行列環へ移した写像 Ω̂・Ω̂' -/

/-- 本文 `def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers`：Ω̂ := ν_{r_M} ∘ Ω。 -/
def numberedHomomorphismToMatrix (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) : Mat (Idx (twoPower D.M)) :=
  firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he a)

/-- 本文 `def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers`：Ω̂' := Ω' ∘ μ_{r_M}。 -/
def numberedHomomorphismFromMatrix (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (G : Mat (Idx (twoPower D.M))) : QY.Cl :=
  D.conjugatedHomomorphismFromMatrix QY e he (firstSiteHighestInverseReindexMatrix D.M G)

/-! ### Ω̂ が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix`：
Ω̂(γ_Y(e_m)) = Z^{(2^M)}_m。 -/
theorem numberedHomomorphismToMatrix_first (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e m)) = numberedJordanWignerZ D.M m := calc
  D.numberedHomomorphismToMatrix QY e he (QY.γ (e m))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m))) := rfl
  -- claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerZ D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_first QY e he m hm]
  -- claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers
  _ = numberedJordanWignerZ D.M m := firstSiteHighestReindexMatrix_jordanWignerZ D.M m

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix`：
Ω̂(γ_Y(e_{M+m})) = Y^{(2^M)}_m。 -/
theorem numberedHomomorphismToMatrix_second (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = numberedJordanWignerY D.M m := calc
  D.numberedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))) := rfl
  -- claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerY D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_second QY e he m hm]
  -- claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers
  _ = numberedJordanWignerY D.M m := firstSiteHighestReindexMatrix_jordanWignerY D.M m

/-! ### 系の定理 -/

/-- 系の定理の本体：e が三つの条件を満たす任意の族のとき、Ω̂ と Ω̂' は互いに逆な ℂ-代数の準同型である。
本文の定理は e := `orthonormalBasis` の場合（`numberedHomomorphisms_mutually_inverse`）。 -/
theorem numberedHomomorphisms_mutually_inverse_of_family (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
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
  obtain ⟨hΩ, hΩ', hΩ'Ω, hΩΩ', -, -⟩ := D.conjugatedHomomorphisms_mutually_inverse_of_family QY e he
  -- ν_{r_M} と μ_{r_M} は ℂ-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism、
  -- claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism）
  have hν : IsComplexAlgebraHomomorphism D.matrixAlgebra (numberedMatrixAlgebra D.M) ν :=
    reindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet D.M) (firstSiteHighestNumbering_isNumbering D.M)
  have hμ : IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) D.matrixAlgebra μ :=
    inverseReindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet D.M)
      (firstSiteHighestNumbering_isNumbering D.M)
  -- 合成 Ω̂ と Ω̂' は ℂ-代数の準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hΩ₁ : IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M) Ω₁ :=
    IsComplexAlgebraHomomorphism.comp (φ := Ω) (ψ := ν) hΩ hν
  have hΩ₁' : IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra Ω₁' :=
    IsComplexAlgebraHomomorphism.comp (φ := μ) (ψ := Ω') hμ hΩ'
  have hΩ₁'Ω₁ : ∀ a : QY.Cl, Ω₁' (Ω₁ a) = a := fun a => calc
    Ω₁' (Ω₁ a)
        -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
        = Ω₁' (ν (Ω a)) := rfl
    -- def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers
    _ = Ω' (μ (ν (Ω a))) := rfl
    -- claim_inverse_reindexing_after_reindexing_of_matrices_is_identity
    _ = Ω' (Ω a) := by
        rw [show μ (ν (Ω a)) = Ω a from
          inverseReindexMatrix_reindexMatrix (firstSiteHighestNumbering_isNumbering D.M) (Ω a)]
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
    _ = G := reindexMatrix_inverseReindexMatrix (firstSiteHighestNumbering_isNumbering D.M) G
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

/-- 本文 `theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms`：
e := `orthonormalBasis` のとき、Ω̂ := ν_{r_M} ∘ Ω と Ω̂' := Ω' ∘ μ_{r_M} は ℂ-代数の準同型で、互いに逆であり、
Ω̂ は全単射でその逆写像は Ω̂' である。 -/
theorem numberedHomomorphisms_mutually_inverse (QY : Clifford.QuadraticSpaceWithBasis Y)
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
  D.numberedHomomorphisms_mutually_inverse_of_family QY _ (D.orthonormalBasis_spec QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
