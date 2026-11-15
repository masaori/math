/-
章「同型の証明」の節「系：行列単位にあたる元はクリフォード代数の基底をなす」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

クリフォード代数の中の主張は、`MutuallyInverseHomomorphismsFromNecSuf.lean` と同じく準同型 Φ : Cl → Cl' で運ぶ。
Φ は線型写像なので線型結合を移し、b_m を必要十分版の b'_m へ移す（`toN_matrixUnitElementFamily`）。
行列環への準同型 Φ_具体 は Φ' ∘ Φ に等しい（`homomorphismToMatrix_eq_comp`）。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws`、a + (-a) = 0 の `add_neg_cancel`、
0 と 1 がどの元とも交換すること（ℂ の乗法の交換法則から）である。
-/
import CliffordMatrixIsomorphism.Isomorphism.BasisOfMatrixUnitElements.BasisOfMatrixUnitElements
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphismsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.BasisOfMatrixUnitElements.BasisOfMatrixUnitElements

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- ℂ の 0 はどの元とも交換する。 -/
private theorem zero_comm_complex : ∀ a : ℂ, 0 * a = a * 0 := fun a => mul_comm 0 a

/-- ℂ の 1 はどの元とも交換する。 -/
private theorem one_comm_complex : ∀ a : ℂ, 1 * a = a * 1 := fun a => mul_comm 1 a

/-- Φ(b_m) = b'_m（1 ≤ m ≤ N_M）。 -/
theorem toN_matrixUnitElementFamily {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
    (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ)
    (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p) (m : ℕ) (hm1 : 1 ≤ m) (hmN : m ≤ pairCount D.M) :
    Φ (D.matrixUnitElementFamily m) = D.toNecSuf.matrixUnitElementFamily complexCliffordLaws m := by
  rw [matrixUnitElementFamily, numberedFamily_of_le _ _ _ m hm1 hmN, toN_matrixUnitElement hΦ hΦγ]
  exact (numberedFamily_of_le (pairNumbering D.M)
    (fun p => D.toNecSuf.matrixUnitElement complexCliffordLaws p.1 p.2) _ m hm1 hmN).symm

/-- Φ(Σ λ_m ∗_A b_m) = Σ λ_m ∗_{A'} b'_m。 -/
theorem toN_linearCombination_matrixUnitElementFamily {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
    (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ)
    (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p) (c : ℕ → ℂ) :
    Φ (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) c D.matrixUnitElementFamily)
      = NecSuf.VectorSpace.linearCombination ((D.spaceN.cliffordAlgebra complexCliffordLaws).toVectorSpace)
          (pairCount D.M) c (D.toNecSuf.matrixUnitElementFamily complexCliffordLaws) := by
  calc Φ (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) c D.matrixUnitElementFamily)
      = linearCombination D.algebraN.toComplexVectorSpace (pairCount D.M) c (fun k => Φ (D.matrixUnitElementFamily k)) :=
        hΦ.isLinearMap.map_linearCombination _ _ _
    _ = linearCombination D.algebraN.toComplexVectorSpace (pairCount D.M) c
          (D.toNecSuf.matrixUnitElementFamily complexCliffordLaws) :=
        linearCombination_eq_of_terms_eq _ _ _ _ c c
          fun m hm1 hmN => by rw [D.toN_matrixUnitElementFamily hΦ hΦγ m hm1 hmN]
    _ = _ := by rw [linearCombination_eq_necSuf]; rfl

/-- 本文 `claim_entry_of_image_of_linear_combination_of_matrix_unit_elements` を必要十分版から得る。 -/
theorem homomorphismToMatrix_linearCombination_entry_of_necSuf (c : ℕ → ℂ) (j : Idx (pairCount D.M)) :
    Mat.entry (D.homomorphismToMatrix
        (linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) c D.matrixUnitElementFamily))
      (pairNumbering D.M j).1 (pairNumbering D.M j).2 = c j.1 := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  rw [D.homomorphismToMatrix_eq_comp hΦ hΦγ, D.toN_linearCombination_matrixUnitElementFamily hΦ hΦγ]
  exact D.toNecSuf.homomorphismToMatrix_linearCombination_entry complexCliffordLaws add_neg_cancel
    zero_comm_complex one_comm_complex c j

/-- 本文 `claim_family_of_matrix_unit_elements_is_linearly_independent` を必要十分版から得る。 -/
theorem matrixUnitElementFamily_linearlyIndependent_of_necSuf :
    IsLinearlyIndependentFamily D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
      D.matrixUnitElementFamily := by
  obtain ⟨Φ, hΦ, hΦγ⟩ := D.exists_toN
  intro c hc k hk1 hkN
  have h0 : Φ D.space.cliffordAlgebra.zero = D.algebraN.zero := hΦ.isLinearMap.map_zero
  have hc' := congrArg Φ hc
  rw [D.toN_linearCombination_matrixUnitElementFamily hΦ hΦγ] at hc'
  have hc'' := hc'.trans h0
  exact D.toNecSuf.matrixUnitElementFamily_linearlyIndependent complexCliffordLaws add_neg_cancel
    zero_comm_complex one_comm_complex c hc'' k hk1 hkN

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra` の式を必要十分版から得る。 -/
theorem linearCombination_matrixUnitElementFamily_eq_of_necSuf (x : D.space.Cl) :
    linearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
        (extendFamily (fun m : Idx (pairCount D.M) =>
          Mat.entry (D.homomorphismToMatrix x) (pairNumbering D.M m).1 (pairNumbering D.M m).2) 0)
        D.matrixUnitElementFamily = x := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [D.toN_linearCombination_matrixUnitElementFamily hΦ hΦγ]
  simp only [D.homomorphismToMatrix_eq_comp hΦ hΦγ x]
  exact D.toNecSuf.linearCombination_matrixUnitElementFamily_eq complexCliffordLaws add_neg_cancel
    zero_comm_complex one_comm_complex (Φ x)

/-- 本文 `claim_family_of_matrix_unit_elements_spans_clifford_algebra` を必要十分版から得る。 -/
theorem matrixUnitElementFamily_spans_of_necSuf :
    SpansByLinearCombination D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M)
      D.matrixUnitElementFamily :=
  fun x => ⟨_, D.linearCombination_matrixUnitElementFamily_eq_of_necSuf x⟩

/-- 本文 `theorem_matrix_unit_elements_form_basis_of_clifford_algebra` を必要十分版から得る。 -/
theorem matrixUnitElementFamily_isBasis_of_necSuf :
    IsBasisFamily D.space.cliffordAlgebra.toComplexVectorSpace (pairCount D.M) D.matrixUnitElementFamily :=
  ⟨D.matrixUnitElementFamily_linearlyIndependent_of_necSuf, D.matrixUnitElementFamily_spans_of_necSuf⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
