/-
`Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean` の具体版の主張が、必要十分版の前半（名前空間
`NecSuf.AlgebraOver`）を K := ℂ、n := -1_ℂ、h := inverseOfTwo、A := Cl(V,q)・A' := Cl(V',q')・B := Mat_{P_M}(ℂ) を
ℂ の上の代数として読んだもの（`toNecSuf`）、e_± := D.idempotentPlus・D.idempotentMinus に特殊化して得られることを示す導出版。
具体版のファイルは必要十分版を引かない。

  具体版                                                         必要十分版の特殊化
  homomorphismFromPairOfMatrices                                 homomorphismFromPairOfMatrices_eq_necSuf（同じ式。rfl）
  homomorphismFromPairOfMatrices_isHom                           homomorphismFromPairOfMatrices_isHom_of_necSuf
  homomorphismToPairOfMatrices_idempotentPlus・…Minus             homomorphismToPairOfMatrices_idempotentPlus_of_necSuf・
                                                                 homomorphismToPairOfMatrices_idempotentMinus_of_necSuf
  homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices    homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf
  homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices    homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf
  oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras             oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras_of_necSuf

運び方:
- 必要十分版の前半は A・A'・B を任意の代数に替えて書いてあるので、具体版の Cl(V',q') と必要十分版の前提の組 `D.toNecSuf` の
  Cl(V',q') が別の集合であることに当たらない（`IdempotentsFromNecSuf.lean` と同じ）。具体版の A・A'・B を `toNecSuf` で
  K := ℂ の代数として読み、前半の主張にそのまま当てる。
- 前半が仮定に置く e_± の性質・Φ'(z)・Φ'(j(y))・Φ'(g)・Φ ∘ Ψ = id・Ψ ∘ Φ = id・ε ε = 1・γ'((v, t)) の分解・γ' が A' を
  生成することと、j・Ψ・Φ' が準同型であることは、引いた主張の導出版（`IdempotentsFromNecSuf.lean`・
  `HomomorphismToPairOfMatricesFromNecSuf.lean`・`CentralElementFromNecSuf.lean`・`ParityElementFromNecSuf.lean`・
  `OddExtensionFromNecSuf.lean`・`MutuallyInverseHomomorphismsFromNecSuf.lean`・`HomomorphismFromMatrixAlgebraFromNecSuf.lean`・
  `CliffordAlgebraFromNecSuf.lean`）から渡す。
- 系の定理は、準同型であることと互いに逆であることを上の導出から取り、全単射と逆写像の部分を具体版と同じ手順で示す
  （`MutuallyInverseHomomorphismsFromNecSuf.lean` の主定理と同じ）。
ℂ から渡す性質は、0 + 0 = 0、a · 0 = 0、1 + (-1) = 0、-(-1) = 1、a · (-1) = -a、h · (1 + 1) = 1 の `inverseOfTwo_mul` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.HomomorphismFromPairOfMatrices
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.IdempotentsFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphismsFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.HomomorphismFromPairOfMatrices

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra`：具体版の Ψ' は、必要十分版の Ψ' を
K := ℂ、j := D.oddInclusionHom、Ψ := D.homomorphismFromMatrix、e_± := D.idempotentPlus・D.idempotentMinus に当てたものと同じ式である。 -/
theorem homomorphismFromPairOfMatrices_eq_necSuf (p : Mat (PowerSet D.M) × Mat (PowerSet D.M)) :
    D.homomorphismFromPairOfMatrices p
      = NecSuf.AlgebraOver.pairMapThroughIdempotents D.oddSpace.cliffordAlgebra.toNecSuf D.oddInclusionHom
          D.homomorphismFromMatrix D.idempotentPlus D.idempotentMinus p := rfl

/-- 本文 `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism` を必要十分版から得る。 -/
theorem homomorphismFromPairOfMatrices_isHom_of_necSuf :
    IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra D.homomorphismFromPairOfMatrices :=
  (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
    (NecSuf.AlgebraOver.pairMapThroughIdempotents_isHom (_root_.add_zero 0) D.space.cliffordAlgebra.toNecSuf
      D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromMatrix_isHom_of_necSuf)
      ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.oddInclusionHom_isHom_of_necSuf)
      (D.idempotent_comm_of_necSuf 1) (D.idempotent_comm_of_necSuf (-1))
      D.idempotentPlus_mul_self_of_necSuf D.idempotentMinus_mul_self_of_necSuf
      D.idempotentPlus_mul_idempotentMinus_of_necSuf D.idempotentMinus_mul_idempotentPlus_of_necSuf
      D.idempotentPlus_add_idempotentMinus_of_necSuf)

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半
（Φ'(e_+) = (1_B, 0_B)）を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_idempotentPlus_of_necSuf :
    D.homomorphismToPairOfMatrices D.idempotentPlus = (D.matrixAlgebra.one, D.matrixAlgebra.zero) :=
  NecSuf.AlgebraOver.map_idempotentOfSquareRootOfOne_one (_root_.add_zero 0) mul_zero (add_neg_cancel 1)
    D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_centralElement_of_necSuf (fun a => mul_neg_one a) inverseOfTwo inverseOfTwo_mul

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半
（Φ'(e_-) = (0_B, 1_B)）を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_idempotentMinus_of_necSuf :
    D.homomorphismToPairOfMatrices D.idempotentMinus = (D.matrixAlgebra.zero, D.matrixAlgebra.one) :=
  NecSuf.AlgebraOver.map_idempotentOfSquareRootOfOne_n (_root_.add_zero 0) mul_zero
    D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    (neg_neg 1) (add_neg_cancel 1)
    D.homomorphismToPairOfMatrices_centralElement_of_necSuf (fun a => mul_neg_one a) inverseOfTwo inverseOfTwo_mul

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf (F G : Mat (PowerSet D.M)) :
    D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G) :=
  NecSuf.AlgebraOver.map_pairMapThroughIdempotents (_root_.add_zero 0) D.oddSpace.cliffordAlgebra.toNecSuf
    D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf D.homomorphismToMatrix_homomorphismFromMatrix_of_necSuf
    D.homomorphismToPairOfMatrices_idempotentPlus_of_necSuf D.homomorphismToPairOfMatrices_idempotentMinus_of_necSuf F G

/-- 本文 `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity` を必要十分版から得る。 -/
theorem homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf (a : D.oddSpace.Cl) :
    D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a :=
  NecSuf.AlgebraOver.pairMapThroughIdempotents_map D.space.cliffordAlgebra.toNecSuf D.oddSpace.cliffordAlgebra.toNecSuf
    D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.oddInclusionHom_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromMatrix_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismFromPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf D.homomorphismFromMatrix_homomorphismToMatrix_of_necSuf
    D.homomorphismToPairOfMatrices_addedGenerator_of_necSuf D.idempotentPlus_add_idempotentMinus_of_necSuf
    D.idempotentPlus_sub_idempotentMinus_of_necSuf rfl D.parityElement_mul_self_of_necSuf D.space.γ D.oddSpace.γ
    ((generatesAlgebra_iff_necSuf _ _).1 D.oddSpace.γ_generates_of_necSuf) D.oddSpace_γ_pair_of_necSuf a

/-- 本文 `theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras` を
必要十分版から得る。 -/
theorem oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras_of_necSuf :
    IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra D.homomorphismToPairOfMatrices ∧
      IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra
        D.homomorphismFromPairOfMatrices ∧
      (∀ a : D.oddSpace.Cl, D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a) ∧
      (∀ F G : Mat (PowerSet D.M), D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G)) ∧
      Function.Bijective D.homomorphismToPairOfMatrices ∧
      (∀ (F G : Mat (PowerSet D.M)) (a : D.oddSpace.Cl),
        D.homomorphismToPairOfMatrices a = (F, G) → a = D.homomorphismFromPairOfMatrices (F, G)) := by
  let Φ' := D.homomorphismToPairOfMatrices
  let Ψ' := D.homomorphismFromPairOfMatrices
  have hinj : Function.Injective Φ' := by
    intro a a' haa'
    calc a = Ψ' (Φ' a) := (D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf a).symm
      _ = Ψ' (Φ' a') := by rw [haa']
      _ = a' := D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf a'
  have hsurj : Function.Surjective Φ' := fun p =>
    ⟨Ψ' (p.1, p.2), D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf p.1 p.2⟩
  have hinv : ∀ (F G : Mat (PowerSet D.M)) (a : D.oddSpace.Cl), Φ' a = (F, G) → a = Ψ' (F, G) := by
    intro F G a ha
    apply hinj
    calc Φ' a = (F, G) := ha
      _ = Φ' (Ψ' (F, G)) := (D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf F G).symm
  exact ⟨D.homomorphismToPairOfMatrices_isHom_of_necSuf, D.homomorphismFromPairOfMatrices_isHom_of_necSuf,
    D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices_of_necSuf,
    D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices_of_necSuf, ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
