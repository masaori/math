/-
`Isomorphism/OddDimensional/Idempotents.lean` の具体版の主張が、必要十分版の前半（名前空間 `NecSuf.AlgebraOver`）を
K := ℂ、n := -1_ℂ、h := inverseOfTwo、A := Cl(V',q') を ℂ の上の代数として読んだもの（`toNecSuf`）、z := D.centralElement に
特殊化して得られることを示す導出版。具体版のファイルは必要十分版を引かない。

  具体版                                        必要十分版の特殊化
  homomorphismToPairOfMatrices_centralElement   homomorphismToPairOfMatrices_centralElement_of_necSuf
  idempotent・idempotentPlus・idempotentMinus    idempotent_eq_necSuf（具体版の e_σ は必要十分版の e_σ と同じ式。rfl）
  idempotent_mul_self                           idempotent_mul_self_of_necSuf
  idempotentPlus_mul_self・idempotentMinus_mul_self
                                                idempotentPlus_mul_self_of_necSuf・idempotentMinus_mul_self_of_necSuf
  idempotent_mul_idempotent_neg                 idempotent_mul_idempotent_neg_of_necSuf
  idempotentPlus_mul_idempotentMinus・idempotentMinus_mul_idempotentPlus
                                                idempotentPlus_mul_idempotentMinus_of_necSuf・idempotentMinus_mul_idempotentPlus_of_necSuf
  idempotentPlus_add_idempotentMinus            idempotentPlus_add_idempotentMinus_of_necSuf
  idempotentPlus_sub_idempotentMinus            idempotentPlus_sub_idempotentMinus_of_necSuf
  idempotent_comm                               idempotent_comm_of_necSuf
  homomorphismToPairOfMatrices_idempotent       homomorphismToPairOfMatrices_idempotent_of_necSuf

運び方:
- 必要十分版の前半は A' を任意の代数に替えて書いてあるので、具体版の Cl(V',q') と必要十分版の前提の組 `D.toNecSuf` の
  Cl(V',q') が別の集合であることに当たらない。具体版の A'・B を `toNecSuf` で K := ℂ の代数として読み、前半の主張にそのまま当てる。
- 前半が仮定に置く A' の中の事実（z · z = 1、z が全ての元と交換すること）と Φ・Φ' の事実（準同型であること、Φ'(j(ε))・Φ'(g) の値、
  ε · ε = 1）は、引いた主張の導出版（`CentralElementFromNecSuf.lean`・`HomomorphismToPairOfMatricesFromNecSuf.lean`・
  `ParityElementFromNecSuf.lean`・`HomomorphismToMatrixAlgebraFromNecSuf.lean`）から渡す。
ℂ から渡す性質は、乗法の結合法則と a · 1 = a、h · (1 + 1) = 1 の `inverseOfTwo_mul`、0 + 0 = 0、a · 0 = 0、
a · (-b) = -(a · b)、1 + (-1) = 0、-a + a = 0、(-1)·(-1) = 1、(-1)·h = h·(-1)、a · (-1) = -a である。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.Idempotents
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CentralElementFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.HomomorphismToPairOfMatricesFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.Idempotents

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_central_element` を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_centralElement_of_necSuf :
    D.homomorphismToPairOfMatrices D.centralElement
      = (D.matrixAlgebra.one, D.matrixAlgebra.smul (-1) D.matrixAlgebra.one) :=
  NecSuf.AlgebraOver.map_mul_of_diagonal_and_signed_values D.space.cliffordAlgebra.toNecSuf
    D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToMatrix_isHom_of_necSuf)
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.parityElement (D.oddInclusionHom D.parityElement) D.addedGenerator D.parityElement_mul_self_of_necSuf
    (D.homomorphismToPairOfMatrices_oddInclusionHom_of_necSuf D.parityElement)
    D.homomorphismToPairOfMatrices_addedGenerator_of_necSuf

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra`：具体版の e_σ は、必要十分版の e_σ を
K := ℂ、h := inverseOfTwo、z := D.centralElement に当てたものと同じ式である。 -/
theorem idempotent_eq_necSuf (σ : ℂ) :
    D.idempotent σ
      = NecSuf.AlgebraOver.idempotentOfSquareRootOfOne D.oddSpace.cliffordAlgebra.toNecSuf inverseOfTwo
          D.centralElement σ := rfl

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` を必要十分版から得る。 -/
theorem idempotent_mul_self_of_necSuf (σ : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) (D.idempotent σ) = D.idempotent σ :=
  NecSuf.AlgebraOver.idempotentOfSquareRootOfOne_mul_self D.oddSpace.cliffordAlgebra.toNecSuf
    D.centralElement_mul_self_of_necSuf _root_.mul_assoc _root_.mul_one inverseOfTwo inverseOfTwo_mul σ
    (by rcases hσ with rfl | rfl <;> norm_num)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself`（σ := 1）を必要十分版から得る。 -/
theorem idempotentPlus_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.idempotentPlus D.idempotentPlus = D.idempotentPlus :=
  D.idempotent_mul_self_of_necSuf 1 (Or.inl rfl)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself`（σ := -1）を必要十分版から得る。 -/
theorem idempotentMinus_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.idempotentMinus D.idempotentMinus = D.idempotentMinus :=
  D.idempotent_mul_self_of_necSuf (-1) (Or.inr rfl)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` を必要十分版から得る。 -/
theorem idempotent_mul_idempotent_neg_of_necSuf (σ : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) (D.idempotent (-σ)) = D.oddSpace.cliffordAlgebra.zero :=
  NecSuf.AlgebraOver.idempotentOfSquareRootOfOne_mul_neg D.oddSpace.cliffordAlgebra.toNecSuf
    D.centralElement_mul_self_of_necSuf (_root_.add_zero 0) mul_zero (fun a b => mul_neg a b)
    (n := -1) rfl (add_neg_cancel 1) neg_add_cancel inverseOfTwo σ (by rcases hσ with rfl | rfl <;> norm_num)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero`（σ := 1）を必要十分版から得る。 -/
theorem idempotentPlus_mul_idempotentMinus_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.idempotentPlus D.idempotentMinus = D.oddSpace.cliffordAlgebra.zero :=
  D.idempotent_mul_idempotent_neg_of_necSuf 1 (Or.inl rfl)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero`（σ := -1）を必要十分版から得る。 -/
theorem idempotentMinus_mul_idempotentPlus_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.idempotentMinus D.idempotentPlus = D.oddSpace.cliffordAlgebra.zero := by
  have h := D.idempotent_mul_idempotent_neg_of_necSuf (-1) (Or.inr rfl)
  rw [neg_neg] at h
  exact h

/-- 本文 `claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one` を必要十分版から得る。 -/
theorem idempotentPlus_add_idempotentMinus_of_necSuf :
    D.oddSpace.cliffordAlgebra.add D.idempotentPlus D.idempotentMinus = D.oddSpace.cliffordAlgebra.one :=
  NecSuf.AlgebraOver.idempotentOfSquareRootOfOne_add D.oddSpace.cliffordAlgebra.toNecSuf D.centralElement
    (_root_.add_zero 0) (add_neg_cancel (1 : ℂ)) inverseOfTwo inverseOfTwo_mul

/-- 本文 `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element` を必要十分版から得る。 -/
theorem idempotentPlus_sub_idempotentMinus_of_necSuf :
    D.oddSpace.cliffordAlgebra.add D.idempotentPlus (D.oddSpace.cliffordAlgebra.smul (-1) D.idempotentMinus)
      = D.centralElement :=
  NecSuf.AlgebraOver.idempotentOfSquareRootOfOne_sub D.oddSpace.cliffordAlgebra.toNecSuf D.centralElement
    (_root_.add_zero 0) (add_neg_cancel (1 : ℂ)) (by norm_num) inverseOfTwo (_root_.mul_comm (-1) inverseOfTwo)
    inverseOfTwo_mul

/-- 本文 `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element` を必要十分版から得る。 -/
theorem idempotent_comm_of_necSuf (σ : ℂ) (y : D.oddSpace.Cl) :
    D.oddSpace.cliffordAlgebra.mul y (D.idempotent σ) = D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) y :=
  NecSuf.AlgebraOver.idempotentOfSquareRootOfOne_comm D.oddSpace.cliffordAlgebra.toNecSuf inverseOfTwo σ y
    (D.centralElement_comm_of_necSuf y)

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_idempotents` を必要十分版から得る。 -/
theorem homomorphismToPairOfMatrices_idempotent_of_necSuf (σ : ℂ) :
    D.homomorphismToPairOfMatrices (D.idempotent σ)
      = (D.matrixAlgebra.smul (inverseOfTwo * (1 + σ)) D.matrixAlgebra.one,
          D.matrixAlgebra.smul (inverseOfTwo * (1 + -σ)) D.matrixAlgebra.one) :=
  NecSuf.AlgebraOver.map_idempotentOfSquareRootOfOne D.oddSpace.cliffordAlgebra.toNecSuf D.matrixAlgebra.toNecSuf
    ((isComplexAlgebraHomomorphism_iff_necSuf _ _ _).1 D.homomorphismToPairOfMatrices_isHom_of_necSuf)
    D.homomorphismToPairOfMatrices_centralElement_of_necSuf (fun a => mul_neg_one a) inverseOfTwo σ

end

end CliffordMatrixIsomorphism.Clifford.SplitData
