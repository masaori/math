/-
章「同型の証明」の節「行列環からクリフォード代数への準同型」の具体版が、必要十分版のこの節の主張の
K := ℂ、n := -1_ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

クリフォード代数の中の主張は、`LocalIdentitiesFromNecSuf.lean` と同じく、Φ ∘ γ = γ' ∘（点を写す写像）を満たす
準同型 Φ : Cl → Cl' で運ぶ（`eq_of_toN_eq`）。Φ は ℰ_{S,T} を ℰ'_{S,T} へ移し（`toN_matrixUnitElement`）、
Ψ(F) を Ψ'(F) へ移す（`toN_homomorphismFromMatrix`。Φ が線型写像なので二重の和を値の和へ移す）。
行列の側は、具体版の Mat_{P_M}(ℂ) と必要十分版の Mat_{P_M}(ℂ) が同じ集合で、行列単位は定義どおりに同じ（`matrixUnit_eq_necSuf`）、
ℂ-代数の構造は `matrixAlgebra_toNecSuf` で一致する。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と、a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismFromMatrixAlgebra.HomomorphismFromMatrixAlgebra
import CliffordMatrixIsomorphism.Isomorphism.GlobalIdentities.GlobalIdentitiesFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebraFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnitsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.HomomorphismFromMatrixAlgebra.HomomorphismFromMatrixAlgebra

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.Isomorphism
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### Φ による ℰ_{S,T} と Ψ(F) の像 -/

section

variable {D} {Φ : D.space.Cl → D.spaceN.Cl complexCliffordLaws}
  (hΦ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.algebraN Φ)
  (hΦγ : ∀ p, Φ (D.space.γ p) = D.mapToN p)

include hΦ hΦγ in
/-- 本文 `def_matrix_unit_element_of_split_clifford_algebra` の具体版の元と必要十分版の元の対応：Φ(ℰ_{S,T}) = ℰ'_{S,T}。 -/
theorem toN_matrixUnitElement (S T : PowerSet D.M) :
    Φ (D.matrixUnitElement S T) = D.toNecSuf.matrixUnitElement complexCliffordLaws S T := by
  rw [matrixUnitElement, hΦ.map_mul, hΦ.map_mul, toN_orderedCreationProduct hΦ hΦγ, toN_vacuumElement hΦ hΦγ,
    toN_reverseOrderedAnnihilationProduct hΦ hΦγ]
  rfl

include hΦ hΦγ in
/-- 本文 `def_homomorphism_from_matrix_algebra_to_clifford_algebra` の具体版の写像と必要十分版の写像の対応：Φ(Ψ(F)) = Ψ'(F)。
Φ は線型写像なので、二重の和を値の和へ移す。 -/
theorem toN_homomorphismFromMatrix (F : Mat (PowerSet D.M)) :
    Φ (D.homomorphismFromMatrix F) = D.toNecSuf.homomorphismFromMatrix complexCliffordLaws F := by
  let hX := isFiniteSet_powerSet D.M
  calc Φ (D.homomorphismFromMatrix F)
      = sumOverFiniteSet D.algebraN.toComplexVectorSpace hX (fun _ => 1)
          (fun S => sumOverFiniteSet D.algebraN.toComplexVectorSpace hX (fun T => Mat.entry F S T)
            (fun T => Φ (D.matrixUnitElement S T))) :=
        hΦ.isLinearMap.map_double_sumOverFiniteSet hX hX _ _
    _ = sumOverFiniteSet D.algebraN.toComplexVectorSpace hX (fun _ => 1)
          (fun S => sumOverFiniteSet D.algebraN.toComplexVectorSpace hX (fun T => Mat.entry F S T)
            (fun T => D.toNecSuf.matrixUnitElement complexCliffordLaws S T)) := by
        simp only [toN_matrixUnitElement hΦ hΦγ]
    _ = D.toNecSuf.homomorphismFromMatrix complexCliffordLaws F := by
        simp only [sumOverFiniteSet_eq_necSuf]
        rfl

end

/-! ### 主張 -/

/-- 本文 `claim_product_of_matrix_unit_elements_of_split_clifford_algebra` を必要十分版から得る。 -/
theorem matrixUnitElement_mul_of_necSuf (S T U R : PowerSet D.M) :
    D.space.cliffordAlgebra.mul (D.matrixUnitElement S T) (D.matrixUnitElement U R)
      = D.space.cliffordAlgebra.smul (kroneckerDelta T U) (D.matrixUnitElement S R) := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, hΦ.map_smul, toN_matrixUnitElement hΦ hΦγ, toN_matrixUnitElement hΦ hΦγ,
    toN_matrixUnitElement hΦ hΦγ]
  exact D.toNecSuf.matrixUnitElement_mul complexCliffordLaws add_neg_cancel S T U R

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_isLinearMap_of_necSuf :
    IsComplexLinearMap (matricesVectorSpace (PowerSet D.M)) D.space.cliffordAlgebra.toComplexVectorSpace
      D.homomorphismFromMatrix := by
  have hN := D.toNecSuf.homomorphismFromMatrix_isLinearMap complexCliffordLaws
  constructor
  · intro F G
    apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.isLinearMap.map_add, toN_homomorphismFromMatrix hΦ hΦγ, toN_homomorphismFromMatrix hΦ hΦγ,
      toN_homomorphismFromMatrix hΦ hΦγ]
    exact hN.map_add F G
  · intro ρ F
    apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.isLinearMap.map_smul, toN_homomorphismFromMatrix hΦ hΦγ, toN_homomorphismFromMatrix hΦ hΦγ]
    exact hN.map_smul ρ F

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_matrixUnit_of_necSuf (S T : PowerSet D.M) :
    D.homomorphismFromMatrix (matrixUnit S T) = D.matrixUnitElement S T := by
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [toN_homomorphismFromMatrix hΦ hΦγ, toN_matrixUnitElement hΦ hΦγ, matrixUnit_eq_necSuf]
  exact D.toNecSuf.homomorphismFromMatrix_matrixUnit complexCliffordLaws S T

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_mul_matrixUnit_of_necSuf (S T U R : PowerSet D.M) :
    D.homomorphismFromMatrix (D.matrixAlgebra.mul (matrixUnit S T) (matrixUnit U R))
      = D.space.cliffordAlgebra.mul (D.homomorphismFromMatrix (matrixUnit S T))
          (D.homomorphismFromMatrix (matrixUnit U R)) := by
  have hN := D.toNecSuf.homomorphismFromMatrix_mul_matrixUnit complexCliffordLaws add_neg_cancel S T U R
  rw [← D.matrixAlgebra_toNecSuf] at hN
  apply D.eq_of_toN_eq
  intro Φ hΦ hΦγ
  rw [hΦ.map_mul, toN_homomorphismFromMatrix hΦ hΦγ, toN_homomorphismFromMatrix hΦ hΦγ,
    toN_homomorphismFromMatrix hΦ hΦγ]
  exact hN

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem homomorphismFromMatrix_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.matrixAlgebra D.space.cliffordAlgebra D.homomorphismFromMatrix := by
  have hN := D.toNecSuf.homomorphismFromMatrix_isHom complexCliffordLaws add_neg_cancel
  rw [← D.matrixAlgebra_toNecSuf] at hN
  have hlin := D.homomorphismFromMatrix_isLinearMap_of_necSuf
  have hmul : ∀ F G : Mat (PowerSet D.M),
      D.homomorphismFromMatrix (D.matrixAlgebra.mul F G)
        = D.space.cliffordAlgebra.mul (D.homomorphismFromMatrix F) (D.homomorphismFromMatrix G) := by
    intro F G
    apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_mul, toN_homomorphismFromMatrix hΦ hΦγ, toN_homomorphismFromMatrix hΦ hΦγ,
      toN_homomorphismFromMatrix hΦ hΦγ]
    exact hN.map_mul F G
  have hone : D.homomorphismFromMatrix D.matrixAlgebra.one = D.space.cliffordAlgebra.one := by
    apply D.eq_of_toN_eq
    intro Φ hΦ hΦγ
    rw [hΦ.map_one, toN_homomorphismFromMatrix hΦ hΦγ]
    exact hN.map_one
  exact ⟨⟨hlin.map_add, hmul, hone⟩, hlin⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
