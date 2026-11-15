/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、{1,2} で添字づけた行列
（Pauli 行列、σz と σx を入れ替える行列 K と K'）と、その間の等式の具体版。人手証明と 1 対 1 に対応させる
（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_pauli_matrix_x                                                                 pauliX・pauliX_entries
  def_pauli_matrix_y                                                                 pauliY・pauliY_entries
  def_pauli_matrix_z                                                                 pauliZ・pauliZ_entries
  def_matrix_exchanging_pauli_z_and_x                                                exchangeMatrix・exchangeMatrix_entries
  def_half_of_matrix_exchanging_pauli_z_and_x                                        halfExchangeMatrix・halfExchangeMatrix_entries
  claim_entries_of_combination_of_off_diagonal_matrix_units                          entries_offDiagonalCombination
  claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity                  exchangeMatrix_mul_halfExchangeMatrix
  claim_half_times_matrix_exchanging_pauli_matrices_is_identity                      halfExchangeMatrix_mul_exchangeMatrix
  claim_matrix_k_turns_pauli_z_into_pauli_x                                          exchangeMatrix_mul_pauliZ
  claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z                 exchangeMatrix_mul_offDiagonalSum
  claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y
                                                                                     exchangeMatrix_mul_imaginaryOffDiagonalCombination

表し方:
- {1,2} は `Idx 2`、その二元は `idxOne`・`idxTwo`、Mat_{1,2}(ℂ) の積は `Mat.mul isFiniteSet_two`（`KroneckerProduct.lean` の冒頭）。
- 本文は五つの行列を四つの成分で定めるので、四つの成分を与えて {1,2} の行列を作る写像 `matrixOfEntries` に名前を付けて置き、
  各行列をその値として定める。各成分の値は `…_entries`（四つの等式の組）に書く。
- 本文の「四つの成分がすべて等しいので、二つの行列は等しい（def_matrices_indexed_by_finite_set）」は `Mat.ext_two`
  （{1,2} の元が 1 か 2 であること `idx_two_cases` と `Mat.ext` による）。
- 行列単位 E_{2,1}・E_{1,2} は `matrixUnit idxTwo idxOne`・`matrixUnit idxOne idxTwo`、i は `imaginaryUnit`、h は `inverseOfTwo`
  （本文 `def_inverse_of_two_in_complex_numbers`。h · (1 + 1) = 1 と (1 + 1) · h = 1 は `IsometryToSplitSpace.lean`）。
- -_ℂ z は ℂ の `-z` である。本文が「ℂ の四則」とする行は ℂ の補題（`ring`・`simp`）で閉じる。
- 「成分の代入」の行は定義を開くだけなので `rfl` である。

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/PauliMatrices.lean`、導出版は `PauliMatricesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.TwoElementSetMembers

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 四つの成分で定める {1,2} の行列 -/

/-- 四つの成分 a_{1,1}・a_{1,2}・a_{2,1}・a_{2,2} を与えて、Mat_{1,2}(ℂ) の元を定める。 -/
def matrixOfEntries (a11 a12 a21 a22 : ℂ) : Mat (Idx 2) := fun p =>
  if p.1 = idxOne then (if p.2 = idxOne then a11 else a12) else (if p.2 = idxOne then a21 else a22)

theorem matrixOfEntries_entries (a11 a12 a21 a22 : ℂ) :
    Mat.entry (matrixOfEntries a11 a12 a21 a22) idxOne idxOne = a11
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxOne idxTwo = a12
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxTwo idxOne = a21
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxTwo idxTwo = a22 := by
  have h21 : idxTwo ≠ idxOne := fun h => idxOne_ne_idxTwo h.symm
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    simp only [Mat.entry, matrixOfEntries, if_neg h21, if_true]

/-- 本文 `def_matrices_indexed_by_finite_set`：Mat_{1,2}(ℂ) の二つの元は、四つの成分がすべて等しければ等しい。 -/
theorem Mat.ext_two {A B : Mat (Idx 2)}
    (h11 : Mat.entry A idxOne idxOne = Mat.entry B idxOne idxOne)
    (h12 : Mat.entry A idxOne idxTwo = Mat.entry B idxOne idxTwo)
    (h21 : Mat.entry A idxTwo idxOne = Mat.entry B idxTwo idxOne)
    (h22 : Mat.entry A idxTwo idxTwo = Mat.entry B idxTwo idxTwo) : A = B :=
  Mat.ext fun a b => by
    rcases idx_two_cases a with rfl | rfl <;> rcases idx_two_cases b with rfl | rfl
    · exact h11
    · exact h12
    · exact h21
    · exact h22

/-- 本文 `def_kronecker_delta`：δ_{1,1} = δ_{2,2} = 1_ℂ、δ_{1,2} = δ_{2,1} = 0_ℂ（{1,2} の元について）。 -/
theorem kroneckerDelta_two_values :
    (kroneckerDelta idxOne idxOne : ℂ) = 1 ∧ (kroneckerDelta idxOne idxTwo : ℂ) = 0
      ∧ (kroneckerDelta idxTwo idxOne : ℂ) = 0 ∧ (kroneckerDelta idxTwo idxTwo : ℂ) = 1 := by
  have h21 : idxTwo ≠ idxOne := fun h => idxOne_ne_idxTwo h.symm
  refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [kroneckerDelta, if_neg h21, if_neg idxOne_ne_idxTwo, if_true]

/-! ### 定義 -/

/-- 本文 `def_pauli_matrix_x`：(σx)_{1,1} := 0_ℂ、(σx)_{1,2} := 1_ℂ、(σx)_{2,1} := 1_ℂ、(σx)_{2,2} := 0_ℂ。 -/
def pauliX : Mat (Idx 2) := matrixOfEntries 0 1 1 0

/-- 本文 `def_pauli_matrix_y`：(σy)_{1,1} := 0_ℂ、(σy)_{1,2} := -_ℂ i、(σy)_{2,1} := i、(σy)_{2,2} := 0_ℂ。 -/
noncomputable def pauliY : Mat (Idx 2) := matrixOfEntries 0 (-imaginaryUnit) imaginaryUnit 0

/-- 本文 `def_pauli_matrix_z`：(σz)_{1,1} := 1_ℂ、(σz)_{1,2} := 0_ℂ、(σz)_{2,1} := 0_ℂ、(σz)_{2,2} := -_ℂ 1_ℂ。 -/
def pauliZ : Mat (Idx 2) := matrixOfEntries 1 0 0 (-1)

/-- 本文 `def_matrix_exchanging_pauli_z_and_x`：K_{1,1} := 1_ℂ、K_{1,2} := 1_ℂ、K_{2,1} := 1_ℂ、K_{2,2} := -_ℂ 1_ℂ。 -/
def exchangeMatrix : Mat (Idx 2) := matrixOfEntries 1 1 1 (-1)

/-- 本文 `def_half_of_matrix_exchanging_pauli_z_and_x`：K'_{1,1} := h、K'_{1,2} := h、K'_{2,1} := h、K'_{2,2} := -_ℂ h。 -/
noncomputable def halfExchangeMatrix : Mat (Idx 2) :=
  matrixOfEntries inverseOfTwo inverseOfTwo inverseOfTwo (-inverseOfTwo)

/-- 本文 `def_pauli_matrix_x` の四つの成分。 -/
theorem pauliX_entries :
    Mat.entry pauliX idxOne idxOne = 0 ∧ Mat.entry pauliX idxOne idxTwo = 1
      ∧ Mat.entry pauliX idxTwo idxOne = 1 ∧ Mat.entry pauliX idxTwo idxTwo = 0 :=
  matrixOfEntries_entries 0 1 1 0

/-- 本文 `def_pauli_matrix_y` の四つの成分。 -/
theorem pauliY_entries :
    Mat.entry pauliY idxOne idxOne = 0 ∧ Mat.entry pauliY idxOne idxTwo = -imaginaryUnit
      ∧ Mat.entry pauliY idxTwo idxOne = imaginaryUnit ∧ Mat.entry pauliY idxTwo idxTwo = 0 :=
  matrixOfEntries_entries 0 (-imaginaryUnit) imaginaryUnit 0

/-- 本文 `def_pauli_matrix_z` の四つの成分。 -/
theorem pauliZ_entries :
    Mat.entry pauliZ idxOne idxOne = 1 ∧ Mat.entry pauliZ idxOne idxTwo = 0
      ∧ Mat.entry pauliZ idxTwo idxOne = 0 ∧ Mat.entry pauliZ idxTwo idxTwo = -1 :=
  matrixOfEntries_entries 1 0 0 (-1)

/-- 本文 `def_matrix_exchanging_pauli_z_and_x` の四つの成分。 -/
theorem exchangeMatrix_entries :
    Mat.entry exchangeMatrix idxOne idxOne = 1 ∧ Mat.entry exchangeMatrix idxOne idxTwo = 1
      ∧ Mat.entry exchangeMatrix idxTwo idxOne = 1 ∧ Mat.entry exchangeMatrix idxTwo idxTwo = -1 :=
  matrixOfEntries_entries 1 1 1 (-1)

/-- 本文 `def_half_of_matrix_exchanging_pauli_z_and_x` の四つの成分。 -/
theorem halfExchangeMatrix_entries :
    Mat.entry halfExchangeMatrix idxOne idxOne = inverseOfTwo
      ∧ Mat.entry halfExchangeMatrix idxOne idxTwo = inverseOfTwo
      ∧ Mat.entry halfExchangeMatrix idxTwo idxOne = inverseOfTwo
      ∧ Mat.entry halfExchangeMatrix idxTwo idxTwo = -inverseOfTwo :=
  matrixOfEntries_entries inverseOfTwo inverseOfTwo inverseOfTwo (-inverseOfTwo)

/-! ### 二つの非対角の行列単位の線型結合 -/

/-- 本文 `claim_entries_of_combination_of_off_diagonal_matrix_units`：
D := (λ ∗ E_{2,1}) + (λ' ∗ E_{1,2}) なら D_{1,1} = 0_ℂ、D_{1,2} = λ'、D_{2,1} = λ、D_{2,2} = 0_ℂ。 -/
theorem entries_offDiagonalCombination (l l' : ℂ) :
    let D := Mat.add (Mat.smul l (matrixUnit idxTwo idxOne)) (Mat.smul l' (matrixUnit idxOne idxTwo))
    Mat.entry D idxOne idxOne = 0 ∧ Mat.entry D idxOne idxTwo = l'
      ∧ Mat.entry D idxTwo idxOne = l ∧ Mat.entry D idxTwo idxTwo = 0 := by
  intro D
  obtain ⟨d11, d12, d21, d22⟩ := kroneckerDelta_two_values
  -- D_{a,b} = (λ ·_ℂ (δ_{2,a} ·_ℂ δ_{1,b})) +_ℂ (λ' ·_ℂ (δ_{1,a} ·_ℂ δ_{2,b}))
  have hD : ∀ a b : Idx 2, Mat.entry D a b
      = l * (kroneckerDelta idxTwo a * kroneckerDelta idxOne b)
        + l' * (kroneckerDelta idxOne a * kroneckerDelta idxTwo b) := fun a b => calc
    Mat.entry D a b
        = l * Mat.entry (matrixUnit idxTwo idxOne) a b + l' * Mat.entry (matrixUnit idxOne idxTwo) a b := rfl
    _ = l * (kroneckerDelta idxTwo a * kroneckerDelta idxOne b)
          + l' * (kroneckerDelta idxOne a * kroneckerDelta idxTwo b) := rfl
  refine ⟨?_, ?_, ?_, ?_⟩
  · calc Mat.entry D idxOne idxOne
        = l * (kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne idxOne)
          + l' * (kroneckerDelta idxOne idxOne * kroneckerDelta idxTwo idxOne) := hD _ _
      _ = l * (0 * 1) + l' * (1 * 0) := by rw [d11, d21]
      _ = 0 := by ring
  · calc Mat.entry D idxOne idxTwo
        = l * (kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne idxTwo)
          + l' * (kroneckerDelta idxOne idxOne * kroneckerDelta idxTwo idxTwo) := hD _ _
      _ = l * (0 * 0) + l' * (1 * 1) := by rw [d11, d12, d21, d22]
      _ = l' := by ring
  · calc Mat.entry D idxTwo idxOne
        = l * (kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxOne)
          + l' * (kroneckerDelta idxOne idxTwo * kroneckerDelta idxTwo idxOne) := hD _ _
      _ = l * (1 * 1) + l' * (0 * 0) := by rw [d11, d12, d21, d22]
      _ = l := by ring
  · calc Mat.entry D idxTwo idxTwo
        = l * (kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxTwo)
          + l' * (kroneckerDelta idxOne idxTwo * kroneckerDelta idxTwo idxTwo) := hD _ _
      _ = l * (1 * 0) + l' * (0 * 1) := by rw [d12, d22]
      _ = 0 := by ring

/-! ### K と K' の積 -/

/-- 本文の二つの主張の準備：h +_ℂ h = 1_ℂ。 -/
theorem inverseOfTwo_add_self : inverseOfTwo + inverseOfTwo = 1 := calc
  inverseOfTwo + inverseOfTwo = 1 * inverseOfTwo + 1 * inverseOfTwo := by rw [one_mul]
  _ = (1 + 1) * inverseOfTwo := (add_mul 1 1 inverseOfTwo).symm
  _ = 1 := mul_inverseOfTwo

/-- 本文 `claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity`：K ·_{Mat_{1,2}} K' = 1_{Mat_{1,2}}。 -/
theorem exchangeMatrix_mul_halfExchangeMatrix :
    Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix = Mat.one := by
  let h := inverseOfTwo
  obtain ⟨d11, d12, d21, d22⟩ := kroneckerDelta_two_values
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry halfExchangeMatrix idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry halfExchangeMatrix idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * h + 1 * h := rfl
      _ = h + h := by ring
      _ = 1 := inverseOfTwo_add_self
      _ = kroneckerDelta idxOne idxOne := d11.symm
      _ = Mat.entry Mat.one idxOne idxOne := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry halfExchangeMatrix idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry halfExchangeMatrix idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * h + 1 * (-h) := rfl
      _ = 0 := by ring
      _ = kroneckerDelta idxOne idxTwo := d12.symm
      _ = Mat.entry Mat.one idxOne idxTwo := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry halfExchangeMatrix idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry halfExchangeMatrix idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * h + (-1) * h := rfl
      _ = 0 := by ring
      _ = kroneckerDelta idxTwo idxOne := d21.symm
      _ = Mat.entry Mat.one idxTwo idxOne := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry halfExchangeMatrix idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry halfExchangeMatrix idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * h + (-1) * (-h) := rfl
      _ = h + h := by ring
      _ = 1 := inverseOfTwo_add_self
      _ = kroneckerDelta idxTwo idxTwo := d22.symm
      _ = Mat.entry Mat.one idxTwo idxTwo := rfl

/-- 本文 `claim_half_times_matrix_exchanging_pauli_matrices_is_identity`：K' ·_{Mat_{1,2}} K = 1_{Mat_{1,2}}。 -/
theorem halfExchangeMatrix_mul_exchangeMatrix :
    Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix = Mat.one := by
  let h := inverseOfTwo
  obtain ⟨d11, d12, d21, d22⟩ := kroneckerDelta_two_values
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix) idxOne idxOne
        = Mat.entry halfExchangeMatrix idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry halfExchangeMatrix idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := entry_mul_two _ _ _ _
      _ = h * 1 + h * 1 := rfl
      _ = h + h := by ring
      _ = 1 := inverseOfTwo_add_self
      _ = kroneckerDelta idxOne idxOne := d11.symm
      _ = Mat.entry Mat.one idxOne idxOne := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix) idxOne idxTwo
        = Mat.entry halfExchangeMatrix idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry halfExchangeMatrix idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = h * 1 + h * (-1) := rfl
      _ = 0 := by ring
      _ = kroneckerDelta idxOne idxTwo := d12.symm
      _ = Mat.entry Mat.one idxOne idxTwo := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix) idxTwo idxOne
        = Mat.entry halfExchangeMatrix idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry halfExchangeMatrix idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := entry_mul_two _ _ _ _
      _ = h * 1 + (-h) * 1 := rfl
      _ = 0 := by ring
      _ = kroneckerDelta idxTwo idxOne := d21.symm
      _ = Mat.entry Mat.one idxTwo idxOne := rfl
  · calc Mat.entry (Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix) idxTwo idxTwo
        = Mat.entry halfExchangeMatrix idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry halfExchangeMatrix idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = h * 1 + (-h) * (-1) := rfl
      _ = h + h := by ring
      _ = 1 := inverseOfTwo_add_self
      _ = kroneckerDelta idxTwo idxTwo := d22.symm
      _ = Mat.entry Mat.one idxTwo idxTwo := rfl

/-! ### K で挟んだ Pauli 行列 -/

/-- 本文 `claim_matrix_k_turns_pauli_z_into_pauli_x`：K ·_{Mat_{1,2}} σz = σx ·_{Mat_{1,2}} K。 -/
theorem exchangeMatrix_mul_pauliZ :
    Mat.mul isFiniteSet_two exchangeMatrix pauliZ = Mat.mul isFiniteSet_two pauliX exchangeMatrix := by
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix pauliZ) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry pauliZ idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry pauliZ idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 1 + 1 * 0 := rfl
      _ = 1 := by ring
      _ = 0 * 1 + 1 * 1 := by ring
      _ = Mat.entry pauliX idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliX idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliX exchangeMatrix) idxOne idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix pauliZ) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry pauliZ idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry pauliZ idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * 0 + 1 * (-1) := rfl
      _ = -1 := by ring
      _ = 0 * 1 + 1 * (-1) := by ring
      _ = Mat.entry pauliX idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliX idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliX exchangeMatrix) idxOne idxTwo := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix pauliZ) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry pauliZ idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry pauliZ idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 1 + (-1) * 0 := rfl
      _ = 1 := by ring
      _ = 1 * 1 + 0 * 1 := by ring
      _ = Mat.entry pauliX idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliX idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliX exchangeMatrix) idxTwo idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix pauliZ) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry pauliZ idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry pauliZ idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * 0 + (-1) * (-1) := rfl
      _ = 1 := by ring
      _ = 1 * 1 + 0 * (-1) := by ring
      _ = Mat.entry pauliX idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliX idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliX exchangeMatrix) idxTwo idxTwo := (entry_mul_two _ _ _ _).symm

/-- 本文 `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z` の G := (1 ∗ E_{2,1}) + (1 ∗ E_{1,2})。 -/
noncomputable def offDiagonalSum : Mat (Idx 2) :=
  Mat.add (Mat.smul 1 (matrixUnit idxTwo idxOne)) (Mat.smul 1 (matrixUnit idxOne idxTwo))

/-- 本文 `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z`：K ·_{Mat_{1,2}} G = σz ·_{Mat_{1,2}} K。 -/
theorem exchangeMatrix_mul_offDiagonalSum :
    Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum = Mat.mul isFiniteSet_two pauliZ exchangeMatrix := by
  -- 準備：claim_entries_of_combination_of_off_diagonal_matrix_units を λ = λ' = 1_ℂ で当てた G の成分
  obtain ⟨g11, g12, g21, g22⟩ := entries_offDiagonalCombination 1 1
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry offDiagonalSum idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry offDiagonalSum idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 0 + 1 * 1 := by
          rw [show Mat.entry offDiagonalSum idxOne idxOne = 0 from g11,
            show Mat.entry offDiagonalSum idxTwo idxOne = 1 from g21]; rfl
      _ = 1 := by ring
      _ = 1 * 1 + 0 * 1 := by ring
      _ = Mat.entry pauliZ idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliZ idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliZ exchangeMatrix) idxOne idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry offDiagonalSum idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry offDiagonalSum idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * 1 + 1 * 0 := by
          rw [show Mat.entry offDiagonalSum idxOne idxTwo = 1 from g12,
            show Mat.entry offDiagonalSum idxTwo idxTwo = 0 from g22]; rfl
      _ = 1 := by ring
      _ = 1 * 1 + 0 * (-1) := by ring
      _ = Mat.entry pauliZ idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliZ idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliZ exchangeMatrix) idxOne idxTwo := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry offDiagonalSum idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry offDiagonalSum idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 0 + (-1) * 1 := by
          rw [show Mat.entry offDiagonalSum idxOne idxOne = 0 from g11,
            show Mat.entry offDiagonalSum idxTwo idxOne = 1 from g21]; rfl
      _ = -1 := by ring
      _ = 0 * 1 + (-1) * 1 := by ring
      _ = Mat.entry pauliZ idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliZ idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliZ exchangeMatrix) idxTwo idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix offDiagonalSum) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry offDiagonalSum idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry offDiagonalSum idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * 1 + (-1) * 0 := by
          rw [show Mat.entry offDiagonalSum idxOne idxTwo = 1 from g12,
            show Mat.entry offDiagonalSum idxTwo idxTwo = 0 from g22]; rfl
      _ = 1 := by ring
      _ = 0 * 1 + (-1) * (-1) := by ring
      _ = Mat.entry pauliZ idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliZ idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliZ exchangeMatrix) idxTwo idxTwo := (entry_mul_two _ _ _ _).symm

/-- 本文 `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y` の
G' := ((-_ℂ i) ∗ E_{2,1}) + (i ∗ E_{1,2})。 -/
noncomputable def imaginaryOffDiagonalCombination : Mat (Idx 2) :=
  Mat.add (Mat.smul (-imaginaryUnit) (matrixUnit idxTwo idxOne)) (Mat.smul imaginaryUnit (matrixUnit idxOne idxTwo))

/-- 本文 `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y`：
K ·_{Mat_{1,2}} G' = σy ·_{Mat_{1,2}} K。 -/
theorem exchangeMatrix_mul_imaginaryOffDiagonalCombination :
    Mat.mul isFiniteSet_two exchangeMatrix imaginaryOffDiagonalCombination
      = Mat.mul isFiniteSet_two pauliY exchangeMatrix := by
  let i := imaginaryUnit
  let G' := imaginaryOffDiagonalCombination
  -- 準備：claim_entries_of_combination_of_off_diagonal_matrix_units を λ = -_ℂ i、λ' = i で当てた G' の成分
  obtain ⟨g11, g12, g21, g22⟩ := entries_offDiagonalCombination (-imaginaryUnit) imaginaryUnit
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix G') idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry G' idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry G' idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 0 + 1 * (-i) := by
          rw [show Mat.entry G' idxOne idxOne = 0 from g11, show Mat.entry G' idxTwo idxOne = -i from g21]; rfl
      _ = -i := by ring
      _ = 0 * 1 + (-i) * 1 := by ring
      _ = Mat.entry pauliY idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliY idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliY exchangeMatrix) idxOne idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix G') idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry G' idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry G' idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * i + 1 * 0 := by
          rw [show Mat.entry G' idxOne idxTwo = i from g12, show Mat.entry G' idxTwo idxTwo = 0 from g22]; rfl
      _ = i := by ring
      _ = 0 * 1 + (-i) * (-1) := by ring
      _ = Mat.entry pauliY idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliY idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliY exchangeMatrix) idxOne idxTwo := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix G') idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry G' idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry G' idxTwo idxOne := entry_mul_two _ _ _ _
      _ = 1 * 0 + (-1) * (-i) := by
          rw [show Mat.entry G' idxOne idxOne = 0 from g11, show Mat.entry G' idxTwo idxOne = -i from g21]; rfl
      _ = i := by ring
      _ = i * 1 + 0 * 1 := by ring
      _ = Mat.entry pauliY idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliY idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliY exchangeMatrix) idxTwo idxOne := (entry_mul_two _ _ _ _).symm
  · calc Mat.entry (Mat.mul isFiniteSet_two exchangeMatrix G') idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry G' idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry G' idxTwo idxTwo := entry_mul_two _ _ _ _
      _ = 1 * i + (-1) * 0 := by
          rw [show Mat.entry G' idxOne idxTwo = i from g12, show Mat.entry G' idxTwo idxTwo = 0 from g22]; rfl
      _ = i := by ring
      _ = i * 1 + 0 * (-1) := by ring
      _ = Mat.entry pauliY idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliY idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul isFiniteSet_two pauliY exchangeMatrix) idxTwo idxTwo := (entry_mul_two _ _ _ _).symm

end CliffordMatrixIsomorphism.Isomorphism
