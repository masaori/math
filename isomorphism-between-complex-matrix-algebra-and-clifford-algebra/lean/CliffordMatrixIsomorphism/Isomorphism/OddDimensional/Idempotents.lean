/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、Φ'(z) の値と、中心の元 z から作る二つの冪等元
e_σ := h ∗_{A'} (1_{A'} +_{A'} σ ∗_{A'} z) についての定義と主張の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                  このファイル
  claim_homomorphism_to_pair_of_matrices_on_central_element                     homomorphismToPairOfMatrices_centralElement
  def_idempotents_of_odd_dimensional_clifford_algebra                           idempotent（e_σ）・idempotentPlus（e_+）・
                                                                                idempotentMinus（e_-）
  claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself        idempotent_mul_self
                                                                                （σ := 1・σ := -1 に当てた idempotentPlus_mul_self・
                                                                                idempotentMinus_mul_self）
  claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero
                                                                                idempotent_mul_idempotent_neg
                                                                                （σ := 1・σ := -1 に当てた idempotentPlus_mul_idempotentMinus・
                                                                                idempotentMinus_mul_idempotentPlus）
  claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one           idempotentPlus_add_idempotentMinus
  claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element
                                                                                idempotentPlus_sub_idempotentMinus
  claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element
                                                                                idempotent_comm
  claim_homomorphism_to_pair_of_matrices_on_idempotents                         homomorphismToPairOfMatrices_idempotent

表し方:
- A' は `D.oddSpace.cliffordAlgebra`、z は `D.centralElement`（`CentralElement.lean`）、j・g・ε は `D.oddInclusionHom`・
  `D.addedGenerator`・`D.parityElement`、B と B × B は `D.matrixAlgebra`・`D.pairOfMatricesAlgebra`、Φ と Φ' は
  `D.homomorphismToMatrix`・`D.homomorphismToPairOfMatrices`（`HomomorphismToPairOfMatrices.lean`）。
- h は本文 `def_inverse_of_two_in_complex_numbers` の元で、`GeneralEvenDimensional/IsometryToSplitSpace.lean` の
  `inverseOfTwo`（h ·_ℂ (1 + 1) = 1 は `inverseOfTwo_mul`）を引く。
- 本文の σ ∈ {1_ℂ, -1_ℂ} は仮定 σ = 1 ∨ σ = -1 で書き、σ̄ := -_ℂ σ は Lean の -σ で書く。本文の「σ̄ の定義」の行と
  「-1_ℂ の定義」の行（-_ℂ 1_ℂ = -1_ℂ）は、Lean では両辺が同じ式なので `rfl` である。
- 本文の証明が「準備として D := … と置く」とする元は `let` で U（σ の側）・Ū（σ̄ の側）と置く（D は前提の組の名前なので使わない）。
  本文 `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element` の U_± は式のまま書く。
- 本文の「ℂ の四則」の行は ℂ の補題を一回当てる。
- 本文の「各成分に」の行は、二つの成分の等式を一回で書き換える（`ProductOfAlgebras.lean` と同じ）。
- 本文 `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element` と
  `claim_homomorphism_to_pair_of_matrices_on_idempotents` の「すべての σ ∈ {1_ℂ, -1_ℂ}」の範囲は証明が使わないので、
  σ は ℂ の任意の元とし、範囲を仮定に置かない。範囲を使うのは平方の主張（σ·σ = 1）と積の主張（σ·σ = 1）だけである。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わないので仮定に置かない（M = 0 でも同じ証明が通る）。

必要十分版は `NecSuf/Isomorphism/OddDimensional/Idempotents.lean`、導出版は `IdempotentsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CentralElement
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CommutingElements
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.HomomorphismToPairOfMatrices
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### Φ'(z) -/

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_central_element`：Φ'(z) = (1_B, (-1_ℂ) ∗_B 1_B)。 -/
theorem homomorphismToPairOfMatrices_centralElement :
    D.homomorphismToPairOfMatrices D.centralElement
      = (D.matrixAlgebra.one, D.matrixAlgebra.smul (-1) D.matrixAlgebra.one) := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let B := D.matrixAlgebra
  let BB := D.pairOfMatricesAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  let Φ := D.homomorphismToMatrix
  let Φ' := D.homomorphismToPairOfMatrices
  have hΦ : IsComplexAlgebraHomomorphism A B Φ := D.homomorphismToMatrix_isHom
  have hΦ' : IsComplexAlgebraHomomorphism A' BB Φ' := D.homomorphismToPairOfMatrices_isHom
  calc Φ' D.centralElement
      = Φ' (A'.mul (j ε) g) := rfl
    _ = BB.mul (Φ' (j ε)) (Φ' g) := hΦ'.map_mul _ _
    _ = BB.mul (Φ ε, Φ ε) (Φ' g) :=
        -- claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism
        congrArg (fun x => BB.mul x (Φ' g)) (D.homomorphismToPairOfMatrices_oddInclusionHom ε)
    _ = BB.mul (Φ ε, Φ ε) (Φ ε, B.smul (-1) (Φ ε)) :=
        -- claim_homomorphism_to_pair_of_matrices_on_added_generator
        congrArg (BB.mul (Φ ε, Φ ε)) D.homomorphismToPairOfMatrices_addedGenerator
    _ = (B.mul (Φ ε) (Φ ε), B.mul (Φ ε) (B.smul (-1) (Φ ε))) := rfl
    _ = (B.mul (Φ ε) (Φ ε), B.smul (-1) (B.mul (Φ ε) (Φ ε))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← B.smul_mul_right (-1) (Φ ε) (Φ ε)]
    _ = (Φ (A.mul ε ε), B.smul (-1) (Φ (A.mul ε ε))) := by
        -- Φ は乗法を保つ
        rw [hΦ.map_mul ε ε]
    _ = (Φ A.one, B.smul (-1) (Φ A.one)) := by
        -- claim_square_of_parity_element_is_one
        rw [D.parityElement_mul_self]
    _ = (B.one, B.smul (-1) B.one) := by
        -- Φ は乗法の単位元を保つ
        rw [hΦ.map_one]

/-! ### 冪等元 e_σ -/

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra`：e_σ := h ∗_{A'} (1_{A'} +_{A'} σ ∗_{A'} z)。
本文は σ ∈ {1_ℂ, -1_ℂ} に限って定めるが、式は σ ∈ ℂ のどれでも書けるので、範囲は使う主張の側に置く。 -/
def idempotent (σ : ℂ) : D.oddSpace.Cl :=
  D.oddSpace.cliffordAlgebra.smul inverseOfTwo
    (D.oddSpace.cliffordAlgebra.add D.oddSpace.cliffordAlgebra.one
      (D.oddSpace.cliffordAlgebra.smul σ D.centralElement))

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra`：e_+ := e_{1_ℂ}。 -/
def idempotentPlus : D.oddSpace.Cl := D.idempotent 1

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra`：e_- := e_{-1_ℂ}。 -/
def idempotentMinus : D.oddSpace.Cl := D.idempotent (-1)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself`：
すべての σ ∈ {1_ℂ, -1_ℂ} について e_σ ·_{A'} e_σ = e_σ。 -/
theorem idempotent_mul_self (σ : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) (D.idempotent σ) = D.idempotent σ := by
  let A' := D.oddSpace.cliffordAlgebra
  let z := D.centralElement
  let h := inverseOfTwo
  let U := A'.add A'.one (A'.smul σ z)
  -- σ ∈ {1_ℂ, -1_ℂ} なので σ ·_ℂ σ = 1_ℂ
  have hσσ : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  -- 準備：U ·_{A'} U = (1_ℂ + 1_ℂ) ∗_{A'} U
  have hU : A'.mul U U = A'.smul (1 + 1) U := calc
    A'.mul U U = A'.add (A'.mul A'.one U) (A'.mul (A'.smul σ z) U) := A'.right_distrib _ _ _
    _ = A'.add U (A'.mul (A'.smul σ z) U) := by rw [A'.one_mul U]
    _ = A'.add U (A'.add (A'.mul (A'.smul σ z) A'.one) (A'.mul (A'.smul σ z) (A'.smul σ z))) :=
        congrArg (A'.add U) (A'.left_distrib _ _ _)
    _ = A'.add U (A'.add (A'.smul σ z) (A'.mul (A'.smul σ z) (A'.smul σ z))) := by
        rw [A'.mul_one (A'.smul σ z)]
    _ = A'.add U (A'.add (A'.smul σ z) (A'.smul σ (A'.mul z (A'.smul σ z)))) := by
        -- スカラー倍と乗法の両立、左の因子
        rw [← A'.smul_mul_left σ z (A'.smul σ z)]
    _ = A'.add U (A'.add (A'.smul σ z) (A'.smul σ (A'.smul σ (A'.mul z z)))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← A'.smul_mul_right σ z z]
    _ = A'.add U (A'.add (A'.smul σ z) (A'.smul (σ * σ) (A'.mul z z))) := by
        rw [A'.smul_assoc σ σ (A'.mul z z)]
    _ = A'.add U (A'.add (A'.smul σ z) (A'.smul (σ * σ) A'.one)) := by
        -- claim_square_of_central_element_is_one
        rw [D.centralElement_mul_self]
    _ = A'.add U (A'.add (A'.smul σ z) (A'.smul 1 A'.one)) := by rw [hσσ]
    _ = A'.add U (A'.add (A'.smul σ z) A'.one) := by rw [A'.one_smul A'.one]
    _ = A'.add U U := by rw [A'.add_comm (A'.smul σ z) A'.one]
    _ = A'.add (A'.smul 1 U) (A'.smul 1 U) := by rw [A'.one_smul U]
    _ = A'.smul (1 + 1) U := (A'.add_smul 1 1 U).symm
  calc A'.mul (D.idempotent σ) (D.idempotent σ)
      = A'.mul (A'.smul h U) (A'.smul h U) := rfl
    _ = A'.smul h (A'.mul U (A'.smul h U)) := (A'.smul_mul_left h U _).symm
    _ = A'.smul h (A'.smul h (A'.mul U U)) := by rw [← A'.smul_mul_right h U U]
    _ = A'.smul (h * h) (A'.mul U U) := (A'.smul_assoc h h _).symm
    _ = A'.smul (h * h) (A'.smul (1 + 1) U) := by rw [hU]
    _ = A'.smul ((h * h) * (1 + 1)) U := (A'.smul_assoc _ _ _).symm
    _ = A'.smul (h * (h * (1 + 1))) U := by rw [_root_.mul_assoc h h (1 + 1)]
    _ = A'.smul (h * 1) U := by
        -- h ·_ℂ (1_ℂ + 1_ℂ) = 1_ℂ（def_inverse_of_two_in_complex_numbers）
        rw [inverseOfTwo_mul]
    _ = A'.smul h U := by rw [_root_.mul_one h]
    _ = D.idempotent σ := rfl

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` を σ := 1_ℂ に当てたもの：e_+ ·_{A'} e_+ = e_+。 -/
theorem idempotentPlus_mul_self :
    D.oddSpace.cliffordAlgebra.mul D.idempotentPlus D.idempotentPlus = D.idempotentPlus :=
  D.idempotent_mul_self 1 (Or.inl rfl)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` を σ := -1_ℂ に当てたもの：e_- ·_{A'} e_- = e_-。 -/
theorem idempotentMinus_mul_self :
    D.oddSpace.cliffordAlgebra.mul D.idempotentMinus D.idempotentMinus = D.idempotentMinus :=
  D.idempotent_mul_self (-1) (Or.inr rfl)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero`：
σ ∈ {1_ℂ, -1_ℂ}、σ̄ := -_ℂ σ について e_σ ·_{A'} e_{σ̄} = 0_{A'}。 -/
theorem idempotent_mul_idempotent_neg (σ : ℂ) (hσ : σ = 1 ∨ σ = -1) :
    D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) (D.idempotent (-σ)) = D.oddSpace.cliffordAlgebra.zero := by
  let A' := D.oddSpace.cliffordAlgebra
  let z := D.centralElement
  let h := inverseOfTwo
  let U := A'.add A'.one (A'.smul σ z)
  let U' := A'.add A'.one (A'.smul (-σ) z)
  -- σ ∈ {1_ℂ, -1_ℂ} なので σ ·_ℂ σ = 1_ℂ
  have hσσ : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  -- 準備：U ·_{A'} Ū = 0_{A'}
  have hU : A'.mul U U' = A'.zero := calc
    A'.mul U U' = A'.add (A'.mul A'.one U') (A'.mul (A'.smul σ z) U') := A'.right_distrib _ _ _
    _ = A'.add U' (A'.mul (A'.smul σ z) U') := by rw [A'.one_mul U']
    _ = A'.add U' (A'.add (A'.mul (A'.smul σ z) A'.one) (A'.mul (A'.smul σ z) (A'.smul (-σ) z))) :=
        congrArg (A'.add U') (A'.left_distrib _ _ _)
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.mul (A'.smul σ z) (A'.smul (-σ) z))) := by
        rw [A'.mul_one (A'.smul σ z)]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul σ (A'.mul z (A'.smul (-σ) z)))) := by
        -- スカラー倍と乗法の両立、左の因子
        rw [← A'.smul_mul_left σ z (A'.smul (-σ) z)]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul σ (A'.smul (-σ) (A'.mul z z)))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← A'.smul_mul_right (-σ) z z]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (σ * -σ) (A'.mul z z))) := by
        rw [A'.smul_assoc σ (-σ) (A'.mul z z)]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (σ * -σ) A'.one)) := by
        -- claim_square_of_central_element_is_one
        rw [D.centralElement_mul_self]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (σ * -σ) A'.one)) := rfl  -- σ̄ の定義
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (-(σ * σ)) A'.one)) := by
        -- ℂ の中で x ·_ℂ (-_ℂ y) = -_ℂ (x ·_ℂ y)
        rw [_root_.mul_neg σ σ]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (-1) A'.one)) := by rw [hσσ]
    _ = A'.add U' (A'.add (A'.smul σ z) (A'.smul (-1) A'.one)) := rfl  -- -1_ℂ の定義
    _ = A'.add U' (A'.add (A'.smul (-1) A'.one) (A'.smul σ z)) := by
        rw [A'.add_comm (A'.smul σ z) (A'.smul (-1) A'.one)]
    _ = A'.add (A'.add A'.one (A'.smul (-1) A'.one)) (A'.add (A'.smul (-σ) z) (A'.smul σ z)) :=
        -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(A') に当てる
        rearrange_sum_of_two_sums A'.toComplexVectorSpace _ _ _ _
    _ = A'.add (A'.add (A'.smul 1 A'.one) (A'.smul (-1) A'.one)) (A'.add (A'.smul (-σ) z) (A'.smul σ z)) := by
        rw [A'.one_smul A'.one]
    _ = A'.add (A'.smul (1 + -1) A'.one) (A'.smul (-σ + σ) z) := by
        -- U_vec(A') のスカラーの加法についての分配法則。二か所に
        rw [A'.add_smul 1 (-1) A'.one, A'.add_smul (-σ) σ z]
    _ = A'.add (A'.smul 0 A'.one) (A'.smul 0 z) := by
        -- ℂ の四則
        rw [add_neg_cancel (1 : ℂ), neg_add_cancel σ]
    _ = A'.add A'.zero A'.zero := by
        -- claim_zero_scalar_multiple_is_zero_vector
        rw [ComplexAlgebra.zero_smul_eq_zero A' A'.one, ComplexAlgebra.zero_smul_eq_zero A' z]
    _ = A'.zero := A'.add_zero A'.zero
  calc A'.mul (D.idempotent σ) (D.idempotent (-σ))
      = A'.mul (A'.smul h U) (A'.smul h U') := rfl
    _ = A'.smul h (A'.mul U (A'.smul h U')) := (A'.smul_mul_left h U _).symm
    _ = A'.smul h (A'.smul h (A'.mul U U')) := by rw [← A'.smul_mul_right h U U']
    _ = A'.smul h (A'.smul h A'.zero) := by rw [hU]
    _ = A'.smul h A'.zero :=
        -- claim_scalar_multiple_of_zero_vector_is_zero_vector
        congrArg (A'.smul h) (ComplexAlgebra.smul_zero_eq_zero A' h)
    _ = A'.zero := ComplexAlgebra.smul_zero_eq_zero A' h

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` を σ := 1_ℂ に当てたもの：
e_+ ·_{A'} e_- = 0_{A'}。 -/
theorem idempotentPlus_mul_idempotentMinus :
    D.oddSpace.cliffordAlgebra.mul D.idempotentPlus D.idempotentMinus = D.oddSpace.cliffordAlgebra.zero :=
  D.idempotent_mul_idempotent_neg 1 (Or.inl rfl)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` を σ := -1_ℂ に当てたもの：
e_- ·_{A'} e_+ = 0_{A'}（σ̄ = -_ℂ(-1_ℂ) = 1_ℂ）。 -/
theorem idempotentMinus_mul_idempotentPlus :
    D.oddSpace.cliffordAlgebra.mul D.idempotentMinus D.idempotentPlus = D.oddSpace.cliffordAlgebra.zero := by
  have h := D.idempotent_mul_idempotent_neg (-1) (Or.inr rfl)
  rw [neg_neg] at h
  exact h

/-- 本文 `claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one`：e_+ +_{A'} e_- = 1_{A'}。 -/
theorem idempotentPlus_add_idempotentMinus :
    D.oddSpace.cliffordAlgebra.add D.idempotentPlus D.idempotentMinus = D.oddSpace.cliffordAlgebra.one := by
  let A' := D.oddSpace.cliffordAlgebra
  let z := D.centralElement
  let h := inverseOfTwo
  calc A'.add D.idempotentPlus D.idempotentMinus
      = A'.add (A'.smul h (A'.add A'.one (A'.smul 1 z))) (A'.smul h (A'.add A'.one (A'.smul (-1) z))) := rfl
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul 1 z)) (A'.add A'.one (A'.smul (-1) z))) :=
        -- U_vec(A') のベクトルの加法についての分配法則
        (A'.smul_add h _ _).symm
    _ = A'.smul h (A'.add (A'.add A'.one A'.one) (A'.add (A'.smul 1 z) (A'.smul (-1) z))) :=
        -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(A') に当てる
        congrArg (A'.smul h) (rearrange_sum_of_two_sums A'.toComplexVectorSpace _ _ _ _)
    _ = A'.smul h (A'.add (A'.add (A'.smul 1 A'.one) (A'.smul 1 A'.one)) (A'.add (A'.smul 1 z) (A'.smul (-1) z))) := by
        rw [A'.one_smul A'.one]
    _ = A'.smul h (A'.add (A'.smul (1 + 1) A'.one) (A'.smul (1 + -1) z)) := by
        -- U_vec(A') のスカラーの加法についての分配法則。二か所に
        rw [A'.add_smul 1 1 A'.one, A'.add_smul 1 (-1) z]
    _ = A'.smul h (A'.add (A'.smul (1 + 1) A'.one) (A'.smul 0 z)) := by
        -- ℂ の四則
        rw [add_neg_cancel (1 : ℂ)]
    _ = A'.smul h (A'.add (A'.smul (1 + 1) A'.one) A'.zero) := by
        -- claim_zero_scalar_multiple_is_zero_vector
        rw [ComplexAlgebra.zero_smul_eq_zero A' z]
    _ = A'.smul h (A'.smul (1 + 1) A'.one) := by rw [A'.add_zero (A'.smul (1 + 1) A'.one)]
    _ = A'.smul (h * (1 + 1)) A'.one := (A'.smul_assoc _ _ _).symm
    _ = A'.smul 1 A'.one := by
        -- def_inverse_of_two_in_complex_numbers
        rw [inverseOfTwo_mul]
    _ = A'.one := A'.one_smul _

/-- 本文 `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element`：
e_+ +_{A'} (-1_ℂ) ∗_{A'} e_- = z。 -/
theorem idempotentPlus_sub_idempotentMinus :
    D.oddSpace.cliffordAlgebra.add D.idempotentPlus (D.oddSpace.cliffordAlgebra.smul (-1) D.idempotentMinus)
      = D.centralElement := by
  let A' := D.oddSpace.cliffordAlgebra
  let z := D.centralElement
  let h := inverseOfTwo
  calc A'.add D.idempotentPlus (A'.smul (-1) D.idempotentMinus)
      = A'.add (A'.smul h (A'.add A'.one (A'.smul 1 z)))
          (A'.smul (-1) (A'.smul h (A'.add A'.one (A'.smul (-1) z)))) := rfl
    _ = A'.add (A'.smul h (A'.add A'.one (A'.smul 1 z)))
          (A'.smul ((-1) * h) (A'.add A'.one (A'.smul (-1) z))) := by
        rw [A'.smul_assoc (-1) h (A'.add A'.one (A'.smul (-1) z))]
    _ = A'.add (A'.smul h (A'.add A'.one (A'.smul 1 z)))
          (A'.smul (h * (-1)) (A'.add A'.one (A'.smul (-1) z))) := by
        -- ℂ の四則
        rw [_root_.mul_comm (-1 : ℂ) h]
    _ = A'.add (A'.smul h (A'.add A'.one (A'.smul 1 z)))
          (A'.smul h (A'.smul (-1) (A'.add A'.one (A'.smul (-1) z)))) := by
        rw [A'.smul_assoc h (-1) (A'.add A'.one (A'.smul (-1) z))]
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul 1 z)) (A'.smul (-1) (A'.add A'.one (A'.smul (-1) z)))) :=
        -- U_vec(A') のベクトルの加法についての分配法則
        (A'.smul_add h _ _).symm
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul 1 z))
          (A'.add (A'.smul (-1) A'.one) (A'.smul (-1) (A'.smul (-1) z)))) := by
        -- U_vec(A') のベクトルの加法についての分配法則
        rw [A'.smul_add (-1) A'.one (A'.smul (-1) z)]
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul 1 z))
          (A'.add (A'.smul (-1) A'.one) (A'.smul ((-1) * (-1)) z))) := by
        rw [A'.smul_assoc (-1) (-1) z]
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul 1 z)) (A'.add (A'.smul (-1) A'.one) (A'.smul 1 z))) := by
        -- ℂ の四則
        rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    _ = A'.smul h (A'.add (A'.add A'.one (A'.smul (-1) A'.one)) (A'.add (A'.smul 1 z) (A'.smul 1 z))) :=
        -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(A') に当てる
        congrArg (A'.smul h) (rearrange_sum_of_two_sums A'.toComplexVectorSpace _ _ _ _)
    _ = A'.smul h (A'.add (A'.add (A'.smul 1 A'.one) (A'.smul (-1) A'.one)) (A'.add (A'.smul 1 z) (A'.smul 1 z))) := by
        rw [A'.one_smul A'.one]
    _ = A'.smul h (A'.add (A'.smul (1 + -1) A'.one) (A'.smul (1 + 1) z)) := by
        -- U_vec(A') のスカラーの加法についての分配法則。二か所に
        rw [A'.add_smul 1 (-1) A'.one, A'.add_smul 1 1 z]
    _ = A'.smul h (A'.add (A'.smul 0 A'.one) (A'.smul (1 + 1) z)) := by
        -- ℂ の四則
        rw [add_neg_cancel (1 : ℂ)]
    _ = A'.smul h (A'.add A'.zero (A'.smul (1 + 1) z)) := by
        -- claim_zero_scalar_multiple_is_zero_vector
        rw [ComplexAlgebra.zero_smul_eq_zero A' A'.one]
    _ = A'.smul h (A'.add (A'.smul (1 + 1) z) A'.zero) := by
        rw [A'.add_comm A'.zero (A'.smul (1 + 1) z)]
    _ = A'.smul h (A'.smul (1 + 1) z) := by rw [A'.add_zero (A'.smul (1 + 1) z)]
    _ = A'.smul (h * (1 + 1)) z := (A'.smul_assoc _ _ _).symm
    _ = A'.smul 1 z := by
        -- def_inverse_of_two_in_complex_numbers
        rw [inverseOfTwo_mul]
    _ = z := A'.one_smul _

/-- 本文 `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element`：
すべての y ∈ A' について y ·_{A'} e_σ = e_σ ·_{A'} y。
C_y が部分代数で 1_{A'} と z を含むことから、スカラー倍と加法で閉じていることを順に当てる。 -/
theorem idempotent_comm (σ : ℂ) (y : D.oddSpace.Cl) :
    D.oddSpace.cliffordAlgebra.mul y (D.idempotent σ) = D.oddSpace.cliffordAlgebra.mul (D.idempotent σ) y := by
  let A' := D.oddSpace.cliffordAlgebra
  let z := D.centralElement
  -- claim_elements_commuting_with_fixed_element_form_subalgebra
  have hC : IsSubalgebra A' (commutingElements A' y) := commutingElements_isSubalgebra A' y
  have h1 : A'.one ∈ commutingElements A' y := hC.one_mem
  -- claim_central_element_commutes_with_every_element
  have hz : z ∈ commutingElements A' y := (D.centralElement_comm y).symm
  have h2 : A'.smul σ z ∈ commutingElements A' y := hC.smul_mem σ z hz
  have h3 : A'.add A'.one (A'.smul σ z) ∈ commutingElements A' y := hC.add_mem _ _ h1 h2
  have h4 : D.idempotent σ ∈ commutingElements A' y := hC.smul_mem inverseOfTwo _ h3
  exact h4

/-! ### Φ'(e_σ) -/

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_idempotents`：
Φ'(e_σ) = ((h ·_ℂ (1_ℂ + σ)) ∗_B 1_B, (h ·_ℂ (1_ℂ + (-_ℂ σ))) ∗_B 1_B)。 -/
theorem homomorphismToPairOfMatrices_idempotent (σ : ℂ) :
    D.homomorphismToPairOfMatrices (D.idempotent σ)
      = (D.matrixAlgebra.smul (inverseOfTwo * (1 + σ)) D.matrixAlgebra.one,
          D.matrixAlgebra.smul (inverseOfTwo * (1 + -σ)) D.matrixAlgebra.one) := by
  let A' := D.oddSpace.cliffordAlgebra
  let B := D.matrixAlgebra
  let BB := D.pairOfMatricesAlgebra
  let z := D.centralElement
  let h := inverseOfTwo
  let Φ' := D.homomorphismToPairOfMatrices
  have hΦ' : IsComplexAlgebraHomomorphism A' BB Φ' := D.homomorphismToPairOfMatrices_isHom
  calc Φ' (D.idempotent σ)
      = Φ' (A'.smul h (A'.add A'.one (A'.smul σ z))) := rfl
    _ = BB.smul h (Φ' (A'.add A'.one (A'.smul σ z))) := hΦ'.map_smul _ _
    _ = BB.smul h (BB.add (Φ' A'.one) (Φ' (A'.smul σ z))) := by rw [hΦ'.map_add A'.one (A'.smul σ z)]
    _ = BB.smul h (BB.add (Φ' A'.one) (BB.smul σ (Φ' z))) := by rw [hΦ'.map_smul σ z]
    _ = BB.smul h (BB.add BB.one (BB.smul σ (Φ' z))) := by rw [hΦ'.map_one]
    _ = BB.smul h (BB.add (B.one, B.one) (BB.smul σ (Φ' z))) := rfl
    _ = BB.smul h (BB.add (B.one, B.one) (BB.smul σ (B.one, B.smul (-1) B.one))) :=
        -- claim_homomorphism_to_pair_of_matrices_on_central_element
        congrArg (fun x => BB.smul h (BB.add (B.one, B.one) (BB.smul σ x))) D.homomorphismToPairOfMatrices_centralElement
    _ = BB.smul h (BB.add (B.one, B.one) (B.smul σ B.one, B.smul σ (B.smul (-1) B.one))) := rfl
    _ = BB.smul h (B.add B.one (B.smul σ B.one), B.add B.one (B.smul σ (B.smul (-1) B.one))) := rfl
    _ = (B.smul h (B.add B.one (B.smul σ B.one)), B.smul h (B.add B.one (B.smul σ (B.smul (-1) B.one)))) := rfl
    _ = (B.smul h (B.add B.one (B.smul σ B.one)), B.smul h (B.add B.one (B.smul (σ * (-1)) B.one))) := by
        rw [B.smul_assoc σ (-1) B.one]
    _ = (B.smul h (B.add B.one (B.smul σ B.one)), B.smul h (B.add B.one (B.smul (-σ) B.one))) := by
        -- ℂ の四則
        rw [mul_neg_one σ]
    _ = (B.smul h (B.add (B.smul 1 B.one) (B.smul σ B.one)),
          B.smul h (B.add (B.smul 1 B.one) (B.smul (-σ) B.one))) := by
        -- U_vec(B) のスカラー倍の単位元。各成分に
        rw [B.one_smul B.one]
    _ = (B.smul h (B.smul (1 + σ) B.one), B.smul h (B.smul (1 + -σ) B.one)) := by
        -- U_vec(B) のスカラーの加法についての分配法則。各成分に
        rw [B.add_smul 1 σ B.one, B.add_smul 1 (-σ) B.one]
    _ = (B.smul (h * (1 + σ)) B.one, B.smul (h * (1 + -σ)) B.one) := by
        -- U_vec(B) のスカラー倍の結合法則。各成分に
        rw [B.smul_assoc h (1 + σ) B.one, B.smul_assoc h (1 + -σ) B.one]

end

end CliffordMatrixIsomorphism.Clifford.SplitData
