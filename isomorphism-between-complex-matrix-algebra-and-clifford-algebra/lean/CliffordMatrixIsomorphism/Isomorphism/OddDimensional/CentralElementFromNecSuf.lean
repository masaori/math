/-
`Isomorphism/OddDimensional/CentralElement.lean` の具体版の主張が、必要十分版の K := ℂ、n := -1_ℂ への特殊化から
得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

  具体版                                        必要十分版の特殊化
  addedGenerator_comm_image_parityFactor        addedGenerator_comm_image_parityFactor_of_necSuf
  addedGenerator_comm_image_parityElement       addedGenerator_comm_image_parityElement_of_necSuf
  centralElement                                （定義。具体版の z をそのまま使う）
  centralElement_mul_self                       centralElement_mul_self_of_necSuf
  centralElement_comm_image_γ                   centralElement_comm_image_γ_of_necSuf
  centralElement_comm_addedGenerator            centralElement_comm_addedGenerator_of_necSuf
  oddSpace_γ_pair                               oddSpace_γ_pair_of_necSuf
  centralElement_comm                           centralElement_comm_of_necSuf

運び方:
- どの主張も A' = Cl(V',q') の中の等式で、具体版の Cl(V',q') と必要十分版の前提の組 `D.toNecSuf` の Cl(V',q') は別の集合である。
  そこで、二つの間の互いに逆な準同型 T' : Cl(V',q') → Cl_N(V',q') と S'（`OddExtensionFromNecSuf.lean` の `oddTransport`。
  V' の点を (v, t) ↦ (v を写した点, t) で写す）を使い、具体版の主張の両辺の T' による像が必要十分版の主張の両辺になることを示して、
  必要十分版の主張を当て、S' ∘ T' = 恒等写像で戻す（`eq_of_toCl_eq`）。
- T' は、j(a) を j_N(T(a))（T は Cl(V,q) の間の準同型 `splitTransport.toCl`）へ、g を g_N へ、j(χ_i)・j(ε)・z を
  j_N(χ'_i)・j_N(ε')・z_N へ送る（`oddToCl_oddInclusionHom`・`oddToCl_addedGenerator`・`oddToCl_image_parityFactor`・
  `oddToCl_image_parityElement`・`oddToCl_centralElement`）。T(χ_i) = χ'_i・T(ε) = ε' は `ParityElementFromNecSuf.lean` にある。
ℂ から渡す性質は、章「クリフォード代数」の仮定の組 `complexCliffordLaws` と a + (-a) = 0 の `add_neg_cancel` だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CentralElement
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtensionFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElementFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CommutingElementsFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CentralElement

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### T' が j(χ_i)・j(ε)・z を必要十分版の元へ送ること -/

/-- T'(j(χ_i)) = j_N(χ'_i)。 -/
theorem oddToCl_image_parityFactor (i : ℕ) :
    D.oddTransport.toCl (D.oddInclusionHom (D.parityFactor i))
      = D.toNecSuf.oddInclusionHom complexCliffordLaws add_neg_cancel (D.toNecSuf.parityFactor complexCliffordLaws i) := by
  rw [D.oddToCl_oddInclusionHom, toN_parityFactor D.splitTransport.toCl_isHom D.splitTransport.toCl_γ]

/-- T'(j(ε)) = j_N(ε')。 -/
theorem oddToCl_image_parityElement :
    D.oddTransport.toCl (D.oddInclusionHom D.parityElement)
      = D.toNecSuf.oddInclusionHom complexCliffordLaws add_neg_cancel (D.toNecSuf.parityElement complexCliffordLaws) := by
  rw [D.oddToCl_oddInclusionHom, toN_parityElement D.splitTransport.toCl_isHom D.splitTransport.toCl_γ]

/-- T'(z) = z_N。 -/
theorem oddToCl_centralElement :
    D.oddTransport.toCl D.centralElement = D.toNecSuf.centralElement complexCliffordLaws add_neg_cancel := by
  rw [centralElement, D.oddTransport.toCl_isHom.map_mul, D.oddToCl_image_parityElement, D.oddToCl_addedGenerator]
  rfl

/-! ### 主張 -/

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_factor` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem addedGenerator_comm_image_parityFactor_of_necSuf (i : ℕ) :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.parityFactor i))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.parityFactor i)) D.addedGenerator := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_mul, D.oddToCl_addedGenerator, D.oddToCl_image_parityFactor]
  exact D.toNecSuf.addedGenerator_comm_image_parityFactor complexCliffordLaws add_neg_cancel i

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_element` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem addedGenerator_comm_image_parityElement_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom D.parityElement)
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom D.parityElement) D.addedGenerator := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_mul, D.oddToCl_addedGenerator, D.oddToCl_image_parityElement]
  exact D.toNecSuf.addedGenerator_comm_image_parityElement complexCliffordLaws add_neg_cancel

/-- 本文 `claim_square_of_central_element_is_one` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem centralElement_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.centralElement D.centralElement = D.oddSpace.cliffordAlgebra.one := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_one, D.oddToCl_centralElement]
  exact D.toNecSuf.centralElement_mul_self complexCliffordLaws add_neg_cancel

/-- 本文 `claim_central_element_commutes_with_image_of_split_space` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem centralElement_comm_image_γ_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement (D.oddInclusionHom (D.space.γ v))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.centralElement := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_mul, D.oddToCl_centralElement, D.oddToCl_oddInclusionHom, D.splitTransport.toCl_γ]
  exact D.toNecSuf.centralElement_comm_image_γ complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v)

/-- 本文 `claim_central_element_commutes_with_added_generator` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem centralElement_comm_addedGenerator_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.centralElement
      = D.oddSpace.cliffordAlgebra.mul D.centralElement D.addedGenerator := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_mul, D.oddToCl_centralElement, D.oddToCl_addedGenerator]
  exact D.toNecSuf.centralElement_comm_addedGenerator complexCliffordLaws add_neg_cancel

/-- 本文 `claim_image_of_odd_extension_element_is_sum_of_images` を、必要十分版の主張を T' で引き戻して得たもの。 -/
theorem oddSpace_γ_pair_of_necSuf (v : W × DualSpace D.spaceW) (t : ℂ) :
    D.oddSpace.γ (v, t)
      = D.oddSpace.cliffordAlgebra.add (D.oddInclusionHom (D.space.γ v))
          (D.oddSpace.cliffordAlgebra.smul t D.addedGenerator) := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_add, hT.map_smul, D.oddTransport.toCl_γ, D.oddToCl_oddInclusionHom, D.splitTransport.toCl_γ,
    D.oddToCl_addedGenerator]
  exact D.toNecSuf.oddSpace_γ_pair complexCliffordLaws add_neg_cancel (splitPointToNecSuf D.spaceW v) t

/-- 本文 `claim_central_element_commutes_with_every_element` を、必要十分版の主張を T' で引き戻して得たもの
（必要十分版の主張を a := T'(a) に当てる）。 -/
theorem centralElement_comm_of_necSuf (a : D.oddSpace.Cl) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement a = D.oddSpace.cliffordAlgebra.mul a D.centralElement := by
  have hT := D.oddTransport.toCl_isHom
  apply D.oddTransport.eq_of_toCl_eq
  rw [hT.map_mul, hT.map_mul, D.oddToCl_centralElement]
  exact D.toNecSuf.centralElement_comm complexCliffordLaws add_neg_cancel (D.oddTransport.toCl a)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
