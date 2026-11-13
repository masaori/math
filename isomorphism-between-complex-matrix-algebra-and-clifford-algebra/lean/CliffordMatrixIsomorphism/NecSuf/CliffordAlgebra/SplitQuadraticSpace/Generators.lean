/-
章「クリフォード代数」のうち、節「分裂した二次空間のクリフォード代数の生成元」の必要十分版。具体版
`CliffordAlgebra/SplitQuadraticSpace/Generators.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に替えて書く。

K に置く仮定は、前のファイルと同じ `CliffordLaws K n` と a + (-a) = 0（`hneg`）だけである。
W^* を線型空間にする性質（`DualSpaceVectorSpaceLaws`）と、双対基底が基底であることに要る a · 1 = a は、
どちらも `CliffordLaws` の欄から出る（`CliffordLaws.dualSpaceVectorSpaceLaws`・`CliffordLaws.mul_one`）。
この節は、章の前半の仮定のほかに K の性質を足さない。

`SplitData.space` は前提の組 `QuadraticSpaceWithBasis` を作るが、必要十分版の組は q が二次形式であることを持たないので、
具体版の定義が引く `claim_split_quadratic_form_is_quadratic_form` はここでは引かない。
-/
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebra
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.IdealAndQuotientAlgebra.DirectSumBasis
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis

namespace CliffordMatrixIsomorphism.NecSuf.Clifford

open VectorSpace AlgebraOver

universe u uK

noncomputable section

/-- 本文 `def_clifford_algebra_of_split_quadratic_space` の前提の必要十分版。 -/
structure SplitData (K : Type uK) [Add K] [Mul K] [One K] [Zero K] (W : Type u) where
  spaceW : VectorSpace K W
  M : ℕ
  w : ℕ → W
  isBasis : IsBasisFamily spaceW M w
  f : ℕ → DualSpace spaceW
  isDualBasis : IsDualBasis spaceW M w f

namespace SplitData

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-- 本文 `def_clifford_algebra_of_split_quadratic_space` の必要十分版。 -/
def space : QuadraticSpaceWithBasis K (W × DualSpace D.spaceW) where
  space := splitSpace C.dualSpaceVectorSpaceLaws D.spaceW
  dim := D.M + D.M
  basis := concatenatedFamily D.spaceW (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f
  isBasis := concatenatedFamily_isBasisFamily D.spaceW (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) D.M D.M D.w D.f
    C.dualSpaceVectorSpaceLaws.zero_add_zero C.dualSpaceVectorSpaceLaws.mul_zero D.isBasis
    (dualBasis_isBasis C.dualSpaceVectorSpaceLaws C.uniqueness.zero_add C.mul_one D.spaceW D.M D.w D.isBasis D.f D.isDualBasis)
  form := splitQuadraticForm D.spaceW

/-- 本文 `def_creation_generator_of_split_clifford_algebra` の必要十分版。 -/
def creation (i : ℕ) : (D.space C).Cl C :=
  (D.space C).γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))

/-- 本文 `def_annihilation_generator_of_split_clifford_algebra` の必要十分版。 -/
def annihilation (i : ℕ) : (D.space C).Cl C :=
  (D.space C).γ C (embedSecond D.spaceW (D.f i))

/-- 本文 `claim_annihilation_and_creation_generators_anticommute` の必要十分版。 -/
theorem annihilation_creation_anticommute (hneg : ∀ a : K, a + -a = 0) (i j : ℕ) (hi1 : 1 ≤ i) (hiM : i ≤ D.M) (hj1 : 1 ≤ j)
    (hjM : j ≤ D.M) :
    ((D.space C).cliffordAlgebra C).add
        (((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.creation C j))
        (((D.space C).cliffordAlgebra C).mul (D.creation C j) (D.annihilation C i))
      = ((D.space C).cliffordAlgebra C).smul (kroneckerDelta i j)
          ((D.space C).cliffordAlgebra C).one := by
  let Q := D.space C
  let A := Q.cliffordAlgebra C
  calc A.add (A.mul (D.annihilation C i) (D.creation C j))
        (A.mul (D.creation C j) (D.annihilation C i))
      = A.add (A.mul (Q.γ C (embedSecond D.spaceW (D.f i)))
            (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j))))
          (A.mul (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j)))
            (Q.γ C (embedSecond D.spaceW (D.f i)))) := rfl
    _ = A.smul (polarization Q.space Q.form (embedSecond D.spaceW (D.f i))
          (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j))) A.one := Q.γ_anticommutator C hneg _ _
    _ = A.smul (polarization (splitSpace C.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW) (D.spaceW.zero, D.f i)
          (D.w j, DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW)) A.one := rfl
    _ = A.smul ((D.f i).1 (D.w j) + (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW).1 D.spaceW.zero) A.one := by
        rw [polarization_splitQuadraticForm C.dualSpaceVectorSpaceLaws D.spaceW hneg D.spaceW.zero (D.w j) (D.f i)
          (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW)]
    _ = A.smul (kroneckerDelta i j + (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW).1 D.spaceW.zero) A.one := by
        rw [D.isDualBasis i j hi1 hiM hj1 hjM]
    _ = A.smul (kroneckerDelta i j + zeroMap D.spaceW.zero) A.one := rfl
    _ = A.smul (kroneckerDelta i j + 0) A.one := rfl
    _ = A.smul (kroneckerDelta i j) A.one := by rw [C.dualSpaceVectorSpaceLaws.add_zero (kroneckerDelta i j : K)]

/-- 本文 `claim_creation_generators_anticommute` の必要十分版。 -/
theorem creation_anticommute (hneg : ∀ a : K, a + -a = 0) (i j : ℕ) :
    ((D.space C).cliffordAlgebra C).add
        (((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.creation C j))
        (((D.space C).cliffordAlgebra C).mul (D.creation C j) (D.creation C i))
      = ((D.space C).cliffordAlgebra C).zero := by
  let Q := D.space C
  let A := Q.cliffordAlgebra C
  calc A.add (A.mul (D.creation C i) (D.creation C j))
        (A.mul (D.creation C j) (D.creation C i))
      = A.add (A.mul (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i)))
            (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j))))
          (A.mul (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j)))
            (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i)))) := rfl
    _ = A.smul (polarization Q.space Q.form (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))
          (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w j))) A.one := Q.γ_anticommutator C hneg _ _
    _ = A.smul (polarization (splitSpace C.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW)
          (D.w i, DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW)
          (D.w j, DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW)) A.one := rfl
    _ = A.smul ((DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW).1 (D.w j)
          + (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW).1 (D.w i)) A.one := by
        rw [polarization_splitQuadraticForm C.dualSpaceVectorSpaceLaws D.spaceW hneg (D.w i) (D.w j)
          (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW) (DualSpace.zero C.dualSpaceVectorSpaceLaws.toDualSpaceOperationLaws D.spaceW)]
    _ = A.smul (zeroMap (D.w j) + zeroMap (D.w i)) A.one := rfl
    _ = A.smul (0 + 0) A.one := rfl
    _ = A.smul 0 A.one := by rw [C.dualSpaceVectorSpaceLaws.zero_add_zero]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero A.one

/-- 本文 `claim_annihilation_generators_anticommute` の必要十分版。 -/
theorem annihilation_anticommute (hneg : ∀ a : K, a + -a = 0) (i j : ℕ) :
    ((D.space C).cliffordAlgebra C).add
        (((D.space C).cliffordAlgebra C).mul (D.annihilation C i)
          (D.annihilation C j))
        (((D.space C).cliffordAlgebra C).mul (D.annihilation C j)
          (D.annihilation C i))
      = ((D.space C).cliffordAlgebra C).zero := by
  let Q := D.space C
  let A := Q.cliffordAlgebra C
  calc A.add (A.mul (D.annihilation C i) (D.annihilation C j))
        (A.mul (D.annihilation C j) (D.annihilation C i))
      = A.add (A.mul (Q.γ C (embedSecond D.spaceW (D.f i))) (Q.γ C (embedSecond D.spaceW (D.f j))))
          (A.mul (Q.γ C (embedSecond D.spaceW (D.f j))) (Q.γ C (embedSecond D.spaceW (D.f i)))) := rfl
    _ = A.smul (polarization Q.space Q.form (embedSecond D.spaceW (D.f i))
          (embedSecond D.spaceW (D.f j))) A.one := Q.γ_anticommutator C hneg _ _
    _ = A.smul (polarization (splitSpace C.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW) (D.spaceW.zero, D.f i)
          (D.spaceW.zero, D.f j)) A.one := rfl
    _ = A.smul ((D.f i).1 D.spaceW.zero + (D.f j).1 D.spaceW.zero) A.one := by
        rw [polarization_splitQuadraticForm C.dualSpaceVectorSpaceLaws D.spaceW hneg D.spaceW.zero D.spaceW.zero (D.f i) (D.f j)]
    _ = A.smul (0 + 0) A.one := by
        rw [(D.f i).2.map_zero C.dualSpaceVectorSpaceLaws.zero_add_zero C.dualSpaceVectorSpaceLaws.zero_mul, (D.f j).2.map_zero C.dualSpaceVectorSpaceLaws.zero_add_zero C.dualSpaceVectorSpaceLaws.zero_mul]
    _ = A.smul 0 A.one := by rw [C.dualSpaceVectorSpaceLaws.zero_add_zero]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero A.one

/-- 本文 `claim_square_of_creation_generator_is_zero` の必要十分版。 -/
theorem creation_mul_self (hneg : ∀ a : K, a + -a = 0) (i : ℕ) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.creation C i)
      = ((D.space C).cliffordAlgebra C).zero := by
  let Q := D.space C
  let A := Q.cliffordAlgebra C
  calc A.mul (D.creation C i) (D.creation C i)
      = A.mul (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i)))
          (Q.γ C (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))) := rfl
    _ = A.smul (Q.form (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))) A.one := Q.γ_mul_self C hneg _
    _ = A.smul (splitQuadraticForm D.spaceW (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))) A.one := rfl
    _ = A.smul 0 A.one := by rw [splitQuadraticForm_embedFirst C.dualSpaceVectorSpaceLaws D.spaceW (D.w i)]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero A.one

/-- 本文 `claim_square_of_annihilation_generator_is_zero` の必要十分版。 -/
theorem annihilation_mul_self (hneg : ∀ a : K, a + -a = 0) (i : ℕ) :
    ((D.space C).cliffordAlgebra C).mul (D.annihilation C i)
        (D.annihilation C i)
      = ((D.space C).cliffordAlgebra C).zero := by
  let Q := D.space C
  let A := Q.cliffordAlgebra C
  calc A.mul (D.annihilation C i) (D.annihilation C i)
      = A.mul (Q.γ C (embedSecond D.spaceW (D.f i))) (Q.γ C (embedSecond D.spaceW (D.f i))) := rfl
    _ = A.smul (Q.form (embedSecond D.spaceW (D.f i))) A.one := Q.γ_mul_self C hneg _
    _ = A.smul (splitQuadraticForm D.spaceW (embedSecond D.spaceW (D.f i))) A.one := rfl
    _ = A.smul 0 A.one := by
        rw [splitQuadraticForm_embedSecond D.spaceW C.dualSpaceVectorSpaceLaws.zero_add_zero C.dualSpaceVectorSpaceLaws.zero_mul (D.f i)]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero A.one

end SplitData

end

end CliffordMatrixIsomorphism.NecSuf.Clifford
