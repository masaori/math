/-
章「同型の証明」の節「二つの準同型が互いに逆であること」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

クリフォード代数の中の主張は、`HomomorphismFromMatrixAlgebraFromNecSuf.lean` と同じく、準同型 Φ : Cl → Cl' で運ぶ
（`eq_of_toN_eq`）。行列環への準同型 Φ_具体 は Φ' ∘ Φ に等しい（`homomorphismToMatrix_eq_comp`）ので、Φ_具体 の値の主張は
必要十分版の Φ' の主張を Φ で写した元に当てて得る。生成作用素・消滅作用素の行列は `creationMatrix_eq_necSuf`・
`annihilationMatrix_eq_necSuf`、座標の写像は `coordinate_eq_necSuf` で必要十分版のものへ移す。
主定理は、主張の五つの部分のうち準同型であることと互いに逆であることを上の導出から取り、全単射と逆写像の部分を
具体版と同じ手順でそこから示す。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と、a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismFromMatrixAlgebra.HomomorphismFromMatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatricesFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `claim_homomorphism_to_matrix_algebra_on_matrix_unit_element` を必要十分版から得る。 -/
theorem homomorphismToMatrix_matrixUnitElement_of_necSuf (S T : PowerSet D.M) :
    D.homomorphismToMatrix (D.matrixUnitElement S T) = matrixUnit S T := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  rw [D.homomorphismToMatrix_eq_comp hΦ hΦγ, toN_matrixUnitElement hΦ hΦγ, matrixUnit_eq_necSuf]
  exact D.toNecSuf.homomorphismToMatrix_matrixUnitElement complexCliffordLaws add_neg_cancel S T

/-- 本文 `claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity` を必要十分版から得る。 -/
theorem homomorphismToMatrix_homomorphismFromMatrix_of_necSuf (F : Mat (PowerSet D.M)) :
    D.homomorphismToMatrix (D.homomorphismFromMatrix F) = F := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  rw [D.homomorphismToMatrix_eq_comp hΦ hΦγ, toN_homomorphismFromMatrix hΦ hΦγ]
  exact D.toNecSuf.homomorphismToMatrix_homomorphismFromMatrix complexCliffordLaws add_neg_cancel F

/-- 本文 `claim_column_sum_of_creation_operator_matrix_entries_times_matrix_unit_elements` を必要十分版から得る。 -/
theorem sum_creationMatrix_entry_smul_matrixUnitElement_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (T : PowerSet D.M) :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M)
        (fun S => Mat.entry (creationMatrix D.M i hi) S T) (fun S => D.matrixUnitElement S T)
      = D.space.cliffordAlgebra.mul (D.creation i) (D.matrixUnitElement T T) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.isLinearMap.map_sumOverFiniteSet, hΦ.map_mul, toN_creation hΦγ, toN_matrixUnitElement hΦ hΦγ]
  simp only [toN_matrixUnitElement hΦ hΦγ]
  rw [sumOverFiniteSet_eq_necSuf, creationMatrix_eq_necSuf]
  exact D.toNecSuf.sum_creationMatrix_entry_smul_matrixUnitElement complexCliffordLaws add_neg_cancel hi T

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_creation_operator_matrix` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_creationMatrix_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismFromMatrix (creationMatrix D.M i hi) = D.creation i := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_homomorphismFromMatrix hΦ hΦγ, toN_creation hΦγ, creationMatrix_eq_necSuf]
  exact D.toNecSuf.homomorphismFromMatrix_creationMatrix complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_row_sum_of_annihilation_operator_matrix_entries_times_matrix_unit_elements` を必要十分版から得る。 -/
theorem sum_annihilationMatrix_entry_smul_matrixUnitElement_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M)
    (S : PowerSet D.M) :
    sumOverFiniteSet D.space.cliffordAlgebra.toComplexVectorSpace (isFiniteSet_powerSet D.M)
        (fun T => Mat.entry (annihilationMatrix D.M i hi) S T) (fun T => D.matrixUnitElement S T)
      = D.space.cliffordAlgebra.mul (D.matrixUnitElement S S) (D.annihilation i) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.isLinearMap.map_sumOverFiniteSet, hΦ.map_mul, toN_annihilation hΦγ, toN_matrixUnitElement hΦ hΦγ]
  simp only [toN_matrixUnitElement hΦ hΦγ]
  rw [sumOverFiniteSet_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact D.toNecSuf.sum_annihilationMatrix_entry_smul_matrixUnitElement complexCliffordLaws add_neg_cancel hi S

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_annihilation_operator_matrix` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_annihilationMatrix_of_necSuf {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    D.homomorphismFromMatrix (annihilationMatrix D.M i hi) = D.annihilation i := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_homomorphismFromMatrix hΦ hΦγ, toN_annihilation hΦγ, annihilationMatrix_eq_necSuf]
  exact D.toNecSuf.homomorphismFromMatrix_annihilationMatrix complexCliffordLaws add_neg_cancel hi

/-- 本文 `claim_clifford_generator_of_split_space_is_linear_combination_of_creation_and_annihilation_generators`
を必要十分版から得る。 -/
theorem γ_pair_eq_creation_add_annihilation_of_necSuf (x : W) (g : DualSpace D.spaceW) :
    D.space.γ (x, g)
      = D.space.cliffordAlgebra.add
          (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace D.M
            (fun k => coordinate D.spaceW D.M D.w D.isBasis k x) D.creation)
          (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace D.M (fun k => g.1 (D.w k)) D.annihilation) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  have hN := D.toNecSuf.γ_pair_eq_creation_add_annihilation complexCliffordLaws x g.toNecSuf
  rw [hΦγ, hΦ.map_add, hΦ.isLinearMap.map_linearCombination, hΦ.isLinearMap.map_linearCombination]
  simp only [toN_creation hΦγ, toN_annihilation hΦγ]
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  refine hN.trans ?_
  congr 1
  apply NecSuf.VectorSpace.linearCombination_eq_of_terms_eq
  intro k hk1 hkM
  rw [coordinate_eq_necSuf D.spaceW D.M D.w D.isBasis k hk1 hkM x]
  rfl

/-- 本文 `claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_homomorphismToMatrix_of_necSuf (a : D.space.Cl) :
    D.homomorphismFromMatrix (D.homomorphismToMatrix a) = a := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_homomorphismFromMatrix hΦ hΦγ, D.homomorphismToMatrix_eq_comp hΦ hΦγ]
  exact D.toNecSuf.homomorphismFromMatrix_homomorphismToMatrix complexCliffordLaws add_neg_cancel (Φ a)

/-- 本文 `theorem_clifford_algebra_of_split_quadratic_space_is_isomorphic_to_matrix_algebra` を必要十分版から得る。 -/
theorem cliffordAlgebra_isomorphic_matrixAlgebra_of_necSuf :
    IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.matrixAlgebra D.homomorphismToMatrix ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra D.space.cliffordAlgebra D.homomorphismFromMatrix ∧
      (∀ a : D.space.Cl, D.homomorphismFromMatrix (D.homomorphismToMatrix a) = a) ∧
      (∀ F : Mat (PowerSet D.M), D.homomorphismToMatrix (D.homomorphismFromMatrix F) = F) ∧
      Function.Bijective D.homomorphismToMatrix ∧
      (∀ (F : Mat (PowerSet D.M)) (a : D.space.Cl), D.homomorphismToMatrix a = F → a = D.homomorphismFromMatrix F) := by
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  have hinj : Function.Injective Φ := by
    intro a b hab
    calc a = Ψ (Φ a) := (D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf a).symm
      _ = Ψ (Φ b) := by rw [hab]
      _ = b := D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf b
  have hsurj : Function.Surjective Φ := fun F => ⟨Ψ F, D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf F⟩
  have hinv : ∀ (F : Mat (PowerSet D.M)) (a : D.space.Cl), Φ a = F → a = Ψ F := by
    intro F a ha
    apply hinj
    calc Φ a = F := ha
      _ = Φ (Ψ F) := (D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf F).symm
  exact ⟨D.homomorphismToMatrix_isHom_of_necSuf, D.homomorphismFromMatrix_isHom_of_necSuf,
    D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf, D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf,
    ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
