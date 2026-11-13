/-
章「クリフォード代数」のうち、節「分裂した二次空間のクリフォード代数の生成元」の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                              このファイル
  def_clifford_algebra_of_split_quadratic_space             SplitData（前提の組 M・W・w・f）・SplitData.space（V := W ⊕ W^* と q := q_W と基底 c）
  def_creation_generator_of_split_clifford_algebra          SplitData.creation（a†_i）
  def_annihilation_generator_of_split_clifford_algebra      SplitData.annihilation（a_i）
  claim_annihilation_and_creation_generators_anticommute    SplitData.annihilation_creation_anticommute
  claim_creation_generators_anticommute                     SplitData.creation_anticommute
  claim_annihilation_generators_anticommute                 SplitData.annihilation_anticommute
  claim_square_of_creation_generator_is_zero                SplitData.creation_mul_self
  claim_square_of_annihilation_generator_is_zero            SplitData.annihilation_mul_self

本文の M ∈ ℤ_{≥1} は、この節のどの主張も使わないので Lean では M : ℕ とし、1 ≤ M を仮定しない。
番号付けた族 w : {1,…,M} → W、f : {1,…,M} → W^* は `ℕ → W`、`ℕ → DualSpace SW` で表す（1,…,M の外の値は使わない）。
本文の i, j ∈ {1,…,M} は、反交換関係 a_i a†_j + a†_j a_i = δ_{i,j} ∗ 1 だけが使う（双対基底の値 f_i(w_j) = δ_{i,j} を引くため）。
ほかの四つの主張は i, j ∈ {1,…,M} を使わないので、Lean では任意の i, j : ℕ について述べる（本文の主張はその特別な場合）。
V の基底 c は、二つの基底を並べた族 `concatenatedFamily`（`claim_basis_of_direct_sum_of_two_vector_spaces`）である。

必要十分版は `NecSuf/CliffordAlgebra/SplitQuadraticSpace/Generators.lean`、導出版は `GeneratorsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.IdealAndQuotientAlgebra.DirectSumBasis
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis

namespace CliffordMatrixIsomorphism.Clifford

open ComplexVectorSpace ComplexAlgebra

universe u

/-- 本文 `def_clifford_algebra_of_split_quadratic_space` の前提：ℂ-線型空間 W、その基底 w : {1,…,M} → W、
w の双対基底 f : {1,…,M} → W^*。 -/
structure SplitData (W : Type u) where
  spaceW : ComplexVectorSpace W
  M : ℕ
  w : ℕ → W
  isBasis : IsBasisFamily spaceW M w
  f : ℕ → DualSpace spaceW
  isDualBasis : IsDualBasis spaceW M w f

namespace SplitData

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_clifford_algebra_of_split_quadratic_space`：V := W ⊕ W^*、q := q_W（二次形式。
`claim_split_quadratic_form_is_quadratic_form`）、基底 c は w に続けて f を並べた族
（`claim_basis_of_direct_sum_of_two_vector_spaces`。f が W^* の基底であることは `claim_dual_basis_is_basis_of_dual_space`）。 -/
noncomputable def space : QuadraticSpaceWithBasis (W × DualSpace D.spaceW) where
  space := splitSpace D.spaceW
  dim := D.M + D.M
  basis := concatenatedFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f
  isBasis := concatenatedFamily_isBasisFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.M D.w D.f D.isBasis
    (dualBasis_isBasis D.spaceW D.M D.w D.isBasis D.f D.isDualBasis)
  form := splitQuadraticForm D.spaceW
  isQuadraticForm := splitQuadraticForm_isQuadraticForm D.spaceW

/-- 本文 `def_creation_generator_of_split_clifford_algebra`：a†_i := γ(in_1(w_i))。 -/
noncomputable def creation (i : ℕ) : D.space.Cl := D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))

/-- 本文 `def_annihilation_generator_of_split_clifford_algebra`：a_i := γ(in_2(f_i))。 -/
noncomputable def annihilation (i : ℕ) : D.space.Cl := D.space.γ (embedSecond D.spaceW (D.f i))

/-- 本文 `claim_annihilation_and_creation_generators_anticommute`：a_i a†_j + a†_j a_i = δ_{i,j} ∗ 1。 -/
theorem annihilation_creation_anticommute (i j : ℕ) (hi1 : 1 ≤ i) (hiM : i ≤ D.M) (hj1 : 1 ≤ j)
    (hjM : j ≤ D.M) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.annihilation i) (D.creation j))
        (D.space.cliffordAlgebra.mul (D.creation j) (D.annihilation i))
      = D.space.cliffordAlgebra.smul (kroneckerDelta i j) D.space.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  calc A.add (A.mul (D.annihilation i) (D.creation j)) (A.mul (D.creation j) (D.annihilation i))
      = A.add (A.mul (D.space.γ (embedSecond D.spaceW (D.f i)))
            (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j))))
          (A.mul (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j)))
            (D.space.γ (embedSecond D.spaceW (D.f i)))) := rfl
    _ = A.smul (polarization D.space.space D.space.form (embedSecond D.spaceW (D.f i))
          (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j))) A.one := D.space.γ_anticommutator _ _
    _ = A.smul (polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW) (D.spaceW.zero, D.f i)
          (D.w j, DualSpace.zero D.spaceW)) A.one := rfl
    _ = A.smul ((D.f i).1 (D.w j) + (DualSpace.zero D.spaceW).1 D.spaceW.zero) A.one := by
        rw [polarization_splitQuadraticForm D.spaceW D.spaceW.zero (D.w j) (D.f i) (DualSpace.zero D.spaceW)]
    _ = A.smul (kroneckerDelta i j + (DualSpace.zero D.spaceW).1 D.spaceW.zero) A.one := by
        rw [D.isDualBasis i j hi1 hiM hj1 hjM]
    _ = A.smul (kroneckerDelta i j + zeroMap D.spaceW.zero) A.one := rfl
    _ = A.smul (kroneckerDelta i j + 0) A.one := rfl
    _ = A.smul (kroneckerDelta i j) A.one := by rw [_root_.add_zero (kroneckerDelta i j : ℂ)]

/-- 本文 `claim_creation_generators_anticommute`：a†_i a†_j + a†_j a†_i = 0。 -/
theorem creation_anticommute (i j : ℕ) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.creation i) (D.creation j))
        (D.space.cliffordAlgebra.mul (D.creation j) (D.creation i))
      = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  calc A.add (A.mul (D.creation i) (D.creation j)) (A.mul (D.creation j) (D.creation i))
      = A.add (A.mul (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)))
            (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j))))
          (A.mul (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j)))
            (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)))) := rfl
    _ = A.smul (polarization D.space.space D.space.form (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))
          (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w j))) A.one := D.space.γ_anticommutator _ _
    _ = A.smul (polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW) (D.w i, DualSpace.zero D.spaceW)
          (D.w j, DualSpace.zero D.spaceW)) A.one := rfl
    _ = A.smul ((DualSpace.zero D.spaceW).1 (D.w j) + (DualSpace.zero D.spaceW).1 (D.w i)) A.one := by
        rw [polarization_splitQuadraticForm D.spaceW (D.w i) (D.w j) (DualSpace.zero D.spaceW)
          (DualSpace.zero D.spaceW)]
    _ = A.smul (zeroMap (D.w j) + zeroMap (D.w i)) A.one := rfl
    _ = A.smul (0 + 0) A.one := rfl
    _ = A.smul 0 A.one := by rw [_root_.add_zero (0 : ℂ)]
    _ = A.zero := ComplexAlgebra.zero_smul_eq_zero A A.one

/-- 本文 `claim_annihilation_generators_anticommute`：a_i a_j + a_j a_i = 0。 -/
theorem annihilation_anticommute (i j : ℕ) :
    D.space.cliffordAlgebra.add (D.space.cliffordAlgebra.mul (D.annihilation i) (D.annihilation j))
        (D.space.cliffordAlgebra.mul (D.annihilation j) (D.annihilation i))
      = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  calc A.add (A.mul (D.annihilation i) (D.annihilation j)) (A.mul (D.annihilation j) (D.annihilation i))
      = A.add (A.mul (D.space.γ (embedSecond D.spaceW (D.f i))) (D.space.γ (embedSecond D.spaceW (D.f j))))
          (A.mul (D.space.γ (embedSecond D.spaceW (D.f j))) (D.space.γ (embedSecond D.spaceW (D.f i)))) := rfl
    _ = A.smul (polarization D.space.space D.space.form (embedSecond D.spaceW (D.f i))
          (embedSecond D.spaceW (D.f j))) A.one := D.space.γ_anticommutator _ _
    _ = A.smul (polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW) (D.spaceW.zero, D.f i)
          (D.spaceW.zero, D.f j)) A.one := rfl
    _ = A.smul ((D.f i).1 D.spaceW.zero + (D.f j).1 D.spaceW.zero) A.one := by
        rw [polarization_splitQuadraticForm D.spaceW D.spaceW.zero D.spaceW.zero (D.f i) (D.f j)]
    _ = A.smul (0 + 0) A.one := by rw [(D.f i).2.map_zero, (D.f j).2.map_zero]
    _ = A.smul 0 A.one := by rw [_root_.add_zero (0 : ℂ)]
    _ = A.zero := ComplexAlgebra.zero_smul_eq_zero A A.one

/-- 本文 `claim_square_of_creation_generator_is_zero`：a†_i a†_i = 0。 -/
theorem creation_mul_self (i : ℕ) :
    D.space.cliffordAlgebra.mul (D.creation i) (D.creation i) = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  calc A.mul (D.creation i) (D.creation i)
      = A.mul (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i)))
          (D.space.γ (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))) := rfl
    _ = A.smul (D.space.form (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))) A.one :=
        D.space.γ_mul_self _
    _ = A.smul (splitQuadraticForm D.spaceW (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))) A.one := rfl
    _ = A.smul 0 A.one := by rw [splitQuadraticForm_embedFirst D.spaceW (D.w i)]
    _ = A.zero := ComplexAlgebra.zero_smul_eq_zero A A.one

/-- 本文 `claim_square_of_annihilation_generator_is_zero`：a_i a_i = 0。 -/
theorem annihilation_mul_self (i : ℕ) :
    D.space.cliffordAlgebra.mul (D.annihilation i) (D.annihilation i) = D.space.cliffordAlgebra.zero := by
  let A := D.space.cliffordAlgebra
  calc A.mul (D.annihilation i) (D.annihilation i)
      = A.mul (D.space.γ (embedSecond D.spaceW (D.f i))) (D.space.γ (embedSecond D.spaceW (D.f i))) := rfl
    _ = A.smul (D.space.form (embedSecond D.spaceW (D.f i))) A.one := D.space.γ_mul_self _
    _ = A.smul (splitQuadraticForm D.spaceW (embedSecond D.spaceW (D.f i))) A.one := rfl
    _ = A.smul 0 A.one := by rw [splitQuadraticForm_embedSecond D.spaceW (D.f i)]
    _ = A.zero := ComplexAlgebra.zero_smul_eq_zero A A.one

end SplitData

end CliffordMatrixIsomorphism.Clifford
