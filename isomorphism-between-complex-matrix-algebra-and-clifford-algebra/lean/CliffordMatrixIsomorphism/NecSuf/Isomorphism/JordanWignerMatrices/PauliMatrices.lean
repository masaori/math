/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、{1,2} で添字づけた行列（Pauli 行列、K と K'）と、
その間の等式の必要十分版。具体版 `Isomorphism/JordanWignerMatrices/PauliMatrices.lean` と同じ def と calc の行で、
係数 ℂ を型の変数 K に、虚数単位 i と h := (1 + 1)^{-1} を K の元の変数 i・h に替えて書く。
-_ℂ z は K の `Neg` の記号 `-z` である。K には演算の記号（`Add`・`Mul`・`Zero`・`One`・`Neg`）だけを与え、公理は仮定として渡す。
具体版が「ℂ の四則」とする行は、下の表の性質を `rw` で一つずつ当てて閉じる。

  本文のラベル                                              このファイル                              使う K の性質
  def_pauli_matrix_x・…_y・…_z                              pauliX・pauliY・pauliZ・…_entries         なし（σy は i を一つ与えるだけ）
  def_matrix_exchanging_pauli_z_and_x                       exchangeMatrix・exchangeMatrix_entries    なし
  def_half_of_matrix_exchanging_pauli_z_and_x               halfExchangeMatrix・…_entries             なし（h を一つ与えるだけ）
  claim_entries_of_combination_of_off_diagonal_matrix_units entries_offDiagonalCombination            a · 0 = 0、a · 1 = a、a + 0 = a、
                                                                                                      0 + a = a
  claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity
                                                            exchangeMatrix_mul_halfExchangeMatrix     L、(1 + 1) · h = 1、a + (-a) = 0、
                                                                                                      (-a) · b = -(a · b)、-(-a) = a
  claim_half_times_matrix_exchanging_pauli_matrices_is_identity
                                                            halfExchangeMatrix_mul_exchangeMatrix     L、(1 + 1) · h = 1、a · 1 = a、
                                                                                                      a + (-a) = 0、(-a) · b = -(a · b)、
                                                                                                      a · (-b) = -(a · b)、-(-a) = a
  claim_matrix_k_turns_pauli_z_into_pauli_x                 exchangeMatrix_mul_pauliZ                 L、a · 0 = 0、a · 1 = a、0 · a = 0、
                                                                                                      (-a) · b = -(a · b)、-(-a) = a
  claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z
                                                            exchangeMatrix_mul_offDiagonalSum         同上
  claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y
                                                            exchangeMatrix_mul_imaginaryOffDiagonalCombination
                                                                                                      同上と a · (-b) = -(a · b)

L : `ValuedMapsLaws K` は {1,2} の行列の積 `Mat.mul L isFiniteSet_two` を定めるのに要る。行の中で L から使うのは、
1 · a = a（`L.one_mul`）、a + 0 = a（`L.add_zero`）、0 + a = a（`zero_add_of_valuedMapsLaws`）、右分配法則（準備 h + h = 1）である。

分かったこと:
- 2 の可逆性が要るのは K と K' の積の二つの主張だけで、使うのは (1 + 1) · h = 1 の片側だけである（h · (1 + 1) = 1 は使わない）。
- i · i = -1 は、このファイルのどの主張も使わない。σy と G' の等式（K G' = σy K）は i が K のどの元でも成り立つ。
- 乗法の交換法則は、このファイルのどの主張も使わない。具体版の「ℂ の四則」の行で要るのは、0・1・-1 との積の規則
  （a · 0 = 0、0 · a = 0、a · 1 = a、1 · a = a、(-a) · b = -(a · b)、a · (-b) = -(a · b)）と -(-a) = a、a + (-a) = 0 だけである。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.TwoElementSetMembers

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (idxOne idxTwo idxOne_ne_idxTwo isFiniteSet_two)
open CliffordMatrixIsomorphism.Isomorphism (idx_two_cases)

universe uK

variable {K : Type uK}

/-! ### 四つの成分で定める {1,2} の行列 -/

/-- 四つの成分を与えて、Mat_{1,2}(K) の元を定める（具体版の `matrixOfEntries`）。 -/
def matrixOfEntries (a11 a12 a21 a22 : K) : Mat K (Idx 2) := fun p =>
  if p.1 = idxOne then (if p.2 = idxOne then a11 else a12) else (if p.2 = idxOne then a21 else a22)

theorem matrixOfEntries_entries (a11 a12 a21 a22 : K) :
    Mat.entry (matrixOfEntries a11 a12 a21 a22) idxOne idxOne = a11
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxOne idxTwo = a12
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxTwo idxOne = a21
      ∧ Mat.entry (matrixOfEntries a11 a12 a21 a22) idxTwo idxTwo = a22 := by
  have h21 : idxTwo ≠ idxOne := fun h => idxOne_ne_idxTwo h.symm
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    simp only [Mat.entry, matrixOfEntries, if_neg h21, if_true]

/-- 本文 `def_matrices_indexed_by_finite_set` の必要十分版：四つの成分がすべて等しければ等しい。 -/
theorem Mat.ext_two {A B : Mat K (Idx 2)}
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

/-- 本文 `def_kronecker_delta` の必要十分版：δ_{1,1} = δ_{2,2} = 1、δ_{1,2} = δ_{2,1} = 0。 -/
theorem kroneckerDelta_two_values [Zero K] [One K] :
    (kroneckerDelta idxOne idxOne : K) = 1 ∧ (kroneckerDelta idxOne idxTwo : K) = 0
      ∧ (kroneckerDelta idxTwo idxOne : K) = 0 ∧ (kroneckerDelta idxTwo idxTwo : K) = 1 := by
  have h21 : idxTwo ≠ idxOne := fun h => idxOne_ne_idxTwo h.symm
  refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [kroneckerDelta, if_neg h21, if_neg idxOne_ne_idxTwo, if_true]

/-! ### 定義 -/

section Definitions

variable [Zero K] [One K] [Neg K]

/-- 本文 `def_pauli_matrix_x` の必要十分版。 -/
def pauliX : Mat K (Idx 2) := matrixOfEntries 0 1 1 0

/-- 本文 `def_pauli_matrix_y` の必要十分版（i は K の元の変数）。 -/
def pauliY (i : K) : Mat K (Idx 2) := matrixOfEntries 0 (-i) i 0

/-- 本文 `def_pauli_matrix_z` の必要十分版。 -/
def pauliZ : Mat K (Idx 2) := matrixOfEntries 1 0 0 (-1)

/-- 本文 `def_matrix_exchanging_pauli_z_and_x` の必要十分版。 -/
def exchangeMatrix : Mat K (Idx 2) := matrixOfEntries 1 1 1 (-1)

/-- 本文 `def_half_of_matrix_exchanging_pauli_z_and_x` の必要十分版（h は K の元の変数）。 -/
def halfExchangeMatrix (h : K) : Mat K (Idx 2) := matrixOfEntries h h h (-h)

omit [Neg K] in
theorem pauliX_entries :
    Mat.entry (pauliX : Mat K (Idx 2)) idxOne idxOne = 0 ∧ Mat.entry (pauliX : Mat K (Idx 2)) idxOne idxTwo = 1
      ∧ Mat.entry (pauliX : Mat K (Idx 2)) idxTwo idxOne = 1 ∧ Mat.entry (pauliX : Mat K (Idx 2)) idxTwo idxTwo = 0 :=
  matrixOfEntries_entries 0 1 1 0

theorem pauliZ_entries :
    Mat.entry (pauliZ : Mat K (Idx 2)) idxOne idxOne = 1 ∧ Mat.entry (pauliZ : Mat K (Idx 2)) idxOne idxTwo = 0
      ∧ Mat.entry (pauliZ : Mat K (Idx 2)) idxTwo idxOne = 0 ∧ Mat.entry (pauliZ : Mat K (Idx 2)) idxTwo idxTwo = -1 :=
  matrixOfEntries_entries 1 0 0 (-1)

end Definitions

/-! ### 二つの非対角の行列単位の線型結合 -/

/-- 本文 `claim_entries_of_combination_of_off_diagonal_matrix_units` の必要十分版。 -/
theorem entries_offDiagonalCombination [Add K] [Mul K] [Zero K] [One K]
    (hmul0 : ∀ a : K, a * 0 = 0) (hmul1 : ∀ a : K, a * 1 = a) (hadd0 : ∀ a : K, a + 0 = a)
    (h0add : ∀ a : K, 0 + a = a) (l l' : K) :
    let D := Mat.add (Mat.smul l (matrixUnit idxTwo idxOne)) (Mat.smul l' (matrixUnit idxOne idxTwo))
    Mat.entry D idxOne idxOne = 0 ∧ Mat.entry D idxOne idxTwo = l'
      ∧ Mat.entry D idxTwo idxOne = l ∧ Mat.entry D idxTwo idxTwo = 0 := by
  intro D
  obtain ⟨d11, d12, d21, d22⟩ := (kroneckerDelta_two_values : _ ∧ _ ∧ _ ∧ (kroneckerDelta idxTwo idxTwo : K) = 1)
  have hD : ∀ a b : Idx 2, Mat.entry D a b
      = l * (kroneckerDelta idxTwo a * kroneckerDelta idxOne b)
        + l' * (kroneckerDelta idxOne a * kroneckerDelta idxTwo b) := fun a b => calc
    Mat.entry D a b
        = l * Mat.entry (matrixUnit idxTwo idxOne : Mat K (Idx 2)) a b
          + l' * Mat.entry (matrixUnit idxOne idxTwo : Mat K (Idx 2)) a b := rfl
    _ = l * (kroneckerDelta idxTwo a * kroneckerDelta idxOne b)
          + l' * (kroneckerDelta idxOne a * kroneckerDelta idxTwo b) := rfl
  refine ⟨?_, ?_, ?_, ?_⟩
  · calc Mat.entry D idxOne idxOne
        = l * (kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne idxOne)
          + l' * (kroneckerDelta idxOne idxOne * kroneckerDelta idxTwo idxOne) := hD _ _
      _ = l * (0 * 1) + l' * (1 * 0) := by rw [d11, d21]
      _ = 0 := by rw [hmul1 (0 : K), hmul0 (1 : K), hmul0 l, hmul0 l', hadd0 0]
  · calc Mat.entry D idxOne idxTwo
        = l * (kroneckerDelta idxTwo idxOne * kroneckerDelta idxOne idxTwo)
          + l' * (kroneckerDelta idxOne idxOne * kroneckerDelta idxTwo idxTwo) := hD _ _
      _ = l * (0 * 0) + l' * (1 * 1) := by rw [d11, d12, d21, d22]
      _ = l' := by rw [hmul0 (0 : K), hmul1 (1 : K), hmul0 l, hmul1 l', h0add l']
  · calc Mat.entry D idxTwo idxOne
        = l * (kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxOne)
          + l' * (kroneckerDelta idxOne idxTwo * kroneckerDelta idxTwo idxOne) := hD _ _
      _ = l * (1 * 1) + l' * (0 * 0) := by rw [d11, d12, d21, d22]
      _ = l := by rw [hmul0 (0 : K), hmul1 (1 : K), hmul1 l, hmul0 l', hadd0 l]
  · calc Mat.entry D idxTwo idxTwo
        = l * (kroneckerDelta idxTwo idxTwo * kroneckerDelta idxOne idxTwo)
          + l' * (kroneckerDelta idxOne idxTwo * kroneckerDelta idxTwo idxTwo) := hD _ _
      _ = l * (1 * 0) + l' * (0 * 1) := by rw [d12, d22]
      _ = 0 := by rw [hmul0 (1 : K), hmul1 (0 : K), hmul0 l, hmul0 l', hadd0 0]

/-! ### K と K' の積 -/

section Products

variable [Add K] [Mul K] [One K] [Zero K] [Neg K]

omit [Neg K] in
/-- 二つの主張の準備の必要十分版：(1 + 1) · h = 1 なら h + h = 1。 -/
theorem inverseOfTwo_add_self (L : ValuedMapsLaws K) (h : K) (hh : (1 + 1) * h = 1) : h + h = 1 := calc
  h + h = 1 * h + 1 * h := by rw [L.one_mul h]
  _ = (1 + 1) * h := (L.right_distrib 1 1 h).symm
  _ = 1 := hh

/-- 本文 `claim_matrix_exchanging_pauli_matrices_times_its_half_is_identity` の必要十分版。 -/
theorem exchangeMatrix_mul_halfExchangeMatrix (L : ValuedMapsLaws K) (h : K) (hh : (1 + 1) * h = 1)
    (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) :
    Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h) = Mat.one := by
  obtain ⟨d11, d12, d21, d22⟩ := (kroneckerDelta_two_values : _ ∧ _ ∧ _ ∧ (kroneckerDelta idxTwo idxTwo : K) = 1)
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h)) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry (halfExchangeMatrix h) idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry (halfExchangeMatrix h) idxTwo idxOne :=
          entry_mul_two L _ _ _ _
      _ = 1 * h + 1 * h := rfl
      _ = h + h := by rw [L.one_mul h]
      _ = 1 := inverseOfTwo_add_self L h hh
      _ = kroneckerDelta idxOne idxOne := d11.symm
      _ = Mat.entry Mat.one idxOne idxOne := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h)) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry (halfExchangeMatrix h) idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry (halfExchangeMatrix h) idxTwo idxTwo :=
          entry_mul_two L _ _ _ _
      _ = 1 * h + 1 * (-h) := rfl
      _ = 0 := by rw [L.one_mul h, L.one_mul (-h), hneg h]
      _ = kroneckerDelta idxOne idxTwo := d12.symm
      _ = Mat.entry Mat.one idxOne idxTwo := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h)) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry (halfExchangeMatrix h) idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry (halfExchangeMatrix h) idxTwo idxOne :=
          entry_mul_two L _ _ _ _
      _ = 1 * h + (-1) * h := rfl
      _ = 0 := by rw [hneg_mul 1 h, L.one_mul h, hneg h]
      _ = kroneckerDelta idxTwo idxOne := d21.symm
      _ = Mat.entry Mat.one idxTwo idxOne := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix (halfExchangeMatrix h)) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry (halfExchangeMatrix h) idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry (halfExchangeMatrix h) idxTwo idxTwo :=
          entry_mul_two L _ _ _ _
      _ = 1 * h + (-1) * (-h) := rfl
      _ = h + h := by rw [hneg_mul 1 (-h), L.one_mul (-h), hneg_neg h, L.one_mul h]
      _ = 1 := inverseOfTwo_add_self L h hh
      _ = kroneckerDelta idxTwo idxTwo := d22.symm
      _ = Mat.entry Mat.one idxTwo idxTwo := rfl

/-- 本文 `claim_half_times_matrix_exchanging_pauli_matrices_is_identity` の必要十分版。 -/
theorem halfExchangeMatrix_mul_exchangeMatrix (L : ValuedMapsLaws K) (h : K) (hh : (1 + 1) * h = 1)
    (hmul1 : ∀ a : K, a * 1 = a) (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hmul_neg : ∀ a b : K, a * (-b) = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) :
    Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix = Mat.one := by
  obtain ⟨d11, d12, d21, d22⟩ := (kroneckerDelta_two_values : _ ∧ _ ∧ _ ∧ (kroneckerDelta idxTwo idxTwo : K) = 1)
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix) idxOne idxOne
        = Mat.entry (halfExchangeMatrix h) idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry (halfExchangeMatrix h) idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne :=
          entry_mul_two L _ _ _ _
      _ = h * 1 + h * 1 := rfl
      _ = h + h := by rw [hmul1 h]
      _ = 1 := inverseOfTwo_add_self L h hh
      _ = kroneckerDelta idxOne idxOne := d11.symm
      _ = Mat.entry Mat.one idxOne idxOne := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix) idxOne idxTwo
        = Mat.entry (halfExchangeMatrix h) idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry (halfExchangeMatrix h) idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo :=
          entry_mul_two L _ _ _ _
      _ = h * 1 + h * (-1) := rfl
      _ = 0 := by rw [hmul_neg h 1, hmul1 h, hneg h]
      _ = kroneckerDelta idxOne idxTwo := d12.symm
      _ = Mat.entry Mat.one idxOne idxTwo := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix) idxTwo idxOne
        = Mat.entry (halfExchangeMatrix h) idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry (halfExchangeMatrix h) idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne :=
          entry_mul_two L _ _ _ _
      _ = h * 1 + (-h) * 1 := rfl
      _ = 0 := by rw [hmul1 h, hmul1 (-h), hneg h]
      _ = kroneckerDelta idxTwo idxOne := d21.symm
      _ = Mat.entry Mat.one idxTwo idxOne := rfl
  · calc Mat.entry (Mat.mul L isFiniteSet_two (halfExchangeMatrix h) exchangeMatrix) idxTwo idxTwo
        = Mat.entry (halfExchangeMatrix h) idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry (halfExchangeMatrix h) idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo :=
          entry_mul_two L _ _ _ _
      _ = h * 1 + (-h) * (-1) := rfl
      _ = h + h := by rw [hneg_mul h (-1), hmul_neg h 1, hneg_neg (h * 1), hmul1 h]
      _ = 1 := inverseOfTwo_add_self L h hh
      _ = kroneckerDelta idxTwo idxTwo := d22.symm
      _ = Mat.entry Mat.one idxTwo idxTwo := rfl

/-! ### K で挟んだ Pauli 行列 -/

/-- 本文 `claim_matrix_k_turns_pauli_z_into_pauli_x` の必要十分版。 -/
theorem exchangeMatrix_mul_pauliZ (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0) (hmul1 : ∀ a : K, a * 1 = a)
    (h0mul : ∀ a : K, 0 * a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) :
    Mat.mul L isFiniteSet_two exchangeMatrix pauliZ = Mat.mul L isFiniteSet_two pauliX exchangeMatrix := by
  have h0add := zero_add_of_valuedMapsLaws L
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix pauliZ) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry pauliZ idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry pauliZ idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 1 + 1 * 0 := rfl
      _ = 1 := by rw [hmul1 1, hmul0 1, L.add_zero 1]
      _ = 0 * 1 + 1 * 1 := by rw [hmul1 0, hmul1 1, h0add 1]
      _ = Mat.entry pauliX idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliX idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliX exchangeMatrix) idxOne idxOne := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix pauliZ) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry pauliZ idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry pauliZ idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * 0 + 1 * (-1) := rfl
      _ = -1 := by rw [hmul0 1, L.one_mul (-1), h0add (-1)]
      _ = 0 * 1 + 1 * (-1) := by rw [hmul1 0, L.one_mul (-1), h0add (-1)]
      _ = Mat.entry pauliX idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliX idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliX exchangeMatrix) idxOne idxTwo := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix pauliZ) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry pauliZ idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry pauliZ idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 1 + (-1) * 0 := rfl
      _ = 1 := by rw [hmul1 1, hmul0 (-1), L.add_zero 1]
      _ = 1 * 1 + 0 * 1 := by rw [hmul1 1, hmul1 0, L.add_zero 1]
      _ = Mat.entry pauliX idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliX idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliX exchangeMatrix) idxTwo idxOne := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix pauliZ) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry pauliZ idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry pauliZ idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * 0 + (-1) * (-1) := rfl
      _ = 1 := by rw [hmul0 1, hneg_mul 1 (-1), L.one_mul (-1), hneg_neg 1, h0add 1]
      _ = 1 * 1 + 0 * (-1) := by rw [hmul1 1, h0mul (-1), L.add_zero 1]
      _ = Mat.entry pauliX idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliX idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliX exchangeMatrix) idxTwo idxTwo := (entry_mul_two L _ _ _ _).symm

/-- 本文 `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z` の G の必要十分版。 -/
def offDiagonalSum : Mat K (Idx 2) :=
  Mat.add (Mat.smul 1 (matrixUnit idxTwo idxOne)) (Mat.smul 1 (matrixUnit idxOne idxTwo))

/-- 本文 `claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z` の必要十分版。 -/
theorem exchangeMatrix_mul_offDiagonalSum (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0)
    (hmul1 : ∀ a : K, a * 1 = a) (h0mul : ∀ a : K, 0 * a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) :
    Mat.mul L isFiniteSet_two exchangeMatrix offDiagonalSum = Mat.mul L isFiniteSet_two pauliZ exchangeMatrix := by
  have h0add := zero_add_of_valuedMapsLaws L
  obtain ⟨g11, g12, g21, g22⟩ := entries_offDiagonalCombination hmul0 hmul1 L.add_zero h0add (1 : K) 1
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix offDiagonalSum) idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry offDiagonalSum idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry offDiagonalSum idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 0 + 1 * 1 := by
          rw [show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxOne idxOne = 0 from g11,
            show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxTwo idxOne = 1 from g21]; rfl
      _ = 1 := by rw [hmul0 1, hmul1 1, h0add 1]
      _ = 1 * 1 + 0 * 1 := by rw [hmul1 1, hmul1 0, L.add_zero 1]
      _ = Mat.entry pauliZ idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliZ idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliZ exchangeMatrix) idxOne idxOne := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix offDiagonalSum) idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry offDiagonalSum idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry offDiagonalSum idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * 1 + 1 * 0 := by
          rw [show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxOne idxTwo = 1 from g12,
            show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxTwo idxTwo = 0 from g22]; rfl
      _ = 1 := by rw [hmul1 1, hmul0 1, L.add_zero 1]
      _ = 1 * 1 + 0 * (-1) := by rw [hmul1 1, h0mul (-1), L.add_zero 1]
      _ = Mat.entry pauliZ idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliZ idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliZ exchangeMatrix) idxOne idxTwo := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix offDiagonalSum) idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry offDiagonalSum idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry offDiagonalSum idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 0 + (-1) * 1 := by
          rw [show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxOne idxOne = 0 from g11,
            show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxTwo idxOne = 1 from g21]; rfl
      _ = -1 := by rw [hmul0 1, hmul1 (-1), h0add (-1)]
      _ = 0 * 1 + (-1) * 1 := by rw [hmul1 0, hmul1 (-1), h0add (-1)]
      _ = Mat.entry pauliZ idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry pauliZ idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliZ exchangeMatrix) idxTwo idxOne := (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix offDiagonalSum) idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry offDiagonalSum idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry offDiagonalSum idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * 1 + (-1) * 0 := by
          rw [show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxOne idxTwo = 1 from g12,
            show Mat.entry (offDiagonalSum : Mat K (Idx 2)) idxTwo idxTwo = 0 from g22]; rfl
      _ = 1 := by rw [hmul1 1, hmul0 (-1), L.add_zero 1]
      _ = 0 * 1 + (-1) * (-1) := by rw [hmul1 0, hneg_mul 1 (-1), L.one_mul (-1), hneg_neg 1, h0add 1]
      _ = Mat.entry pauliZ idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry pauliZ idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two pauliZ exchangeMatrix) idxTwo idxTwo := (entry_mul_two L _ _ _ _).symm

/-- 本文 `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y` の G' の必要十分版。 -/
def imaginaryOffDiagonalCombination (i : K) : Mat K (Idx 2) :=
  Mat.add (Mat.smul (-i) (matrixUnit idxTwo idxOne)) (Mat.smul i (matrixUnit idxOne idxTwo))

/-- 本文 `claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y` の必要十分版。 -/
theorem exchangeMatrix_mul_imaginaryOffDiagonalCombination (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0)
    (hmul1 : ∀ a : K, a * 1 = a) (h0mul : ∀ a : K, 0 * a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hmul_neg : ∀ a b : K, a * (-b) = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) :
    Mat.mul L isFiniteSet_two exchangeMatrix (imaginaryOffDiagonalCombination i)
      = Mat.mul L isFiniteSet_two (pauliY i) exchangeMatrix := by
  have h0add := zero_add_of_valuedMapsLaws L
  let G' := imaginaryOffDiagonalCombination i
  obtain ⟨g11, g12, g21, g22⟩ := entries_offDiagonalCombination hmul0 hmul1 L.add_zero h0add (-i) i
  apply Mat.ext_two
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix G') idxOne idxOne
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry G' idxOne idxOne
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry G' idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 0 + 1 * (-i) := by
          rw [show Mat.entry G' idxOne idxOne = 0 from g11, show Mat.entry G' idxTwo idxOne = -i from g21]; rfl
      _ = -i := by rw [hmul0 1, L.one_mul (-i), h0add (-i)]
      _ = 0 * 1 + (-i) * 1 := by rw [hmul1 0, hmul1 (-i), h0add (-i)]
      _ = Mat.entry (pauliY i) idxOne idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry (pauliY i) idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two (pauliY i) exchangeMatrix) idxOne idxOne :=
          (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix G') idxOne idxTwo
        = Mat.entry exchangeMatrix idxOne idxOne * Mat.entry G' idxOne idxTwo
          + Mat.entry exchangeMatrix idxOne idxTwo * Mat.entry G' idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * i + 1 * 0 := by
          rw [show Mat.entry G' idxOne idxTwo = i from g12, show Mat.entry G' idxTwo idxTwo = 0 from g22]; rfl
      _ = i := by rw [L.one_mul i, hmul0 1, L.add_zero i]
      _ = 0 * 1 + (-i) * (-1) := by
          rw [hmul1 0, hneg_mul i (-1), hmul_neg i 1, hneg_neg (i * 1), hmul1 i, h0add i]
      _ = Mat.entry (pauliY i) idxOne idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry (pauliY i) idxOne idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two (pauliY i) exchangeMatrix) idxOne idxTwo :=
          (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix G') idxTwo idxOne
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry G' idxOne idxOne
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry G' idxTwo idxOne := entry_mul_two L _ _ _ _
      _ = 1 * 0 + (-1) * (-i) := by
          rw [show Mat.entry G' idxOne idxOne = 0 from g11, show Mat.entry G' idxTwo idxOne = -i from g21]; rfl
      _ = i := by rw [hmul0 1, hneg_mul 1 (-i), L.one_mul (-i), hneg_neg i, h0add i]
      _ = i * 1 + 0 * 1 := by rw [hmul1 i, hmul1 0, L.add_zero i]
      _ = Mat.entry (pauliY i) idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxOne
          + Mat.entry (pauliY i) idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxOne := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two (pauliY i) exchangeMatrix) idxTwo idxOne :=
          (entry_mul_two L _ _ _ _).symm
  · calc Mat.entry (Mat.mul L isFiniteSet_two exchangeMatrix G') idxTwo idxTwo
        = Mat.entry exchangeMatrix idxTwo idxOne * Mat.entry G' idxOne idxTwo
          + Mat.entry exchangeMatrix idxTwo idxTwo * Mat.entry G' idxTwo idxTwo := entry_mul_two L _ _ _ _
      _ = 1 * i + (-1) * 0 := by
          rw [show Mat.entry G' idxOne idxTwo = i from g12, show Mat.entry G' idxTwo idxTwo = 0 from g22]; rfl
      _ = i := by rw [L.one_mul i, hmul0 (-1), L.add_zero i]
      _ = i * 1 + 0 * (-1) := by rw [hmul1 i, h0mul (-1), L.add_zero i]
      _ = Mat.entry (pauliY i) idxTwo idxOne * Mat.entry exchangeMatrix idxOne idxTwo
          + Mat.entry (pauliY i) idxTwo idxTwo * Mat.entry exchangeMatrix idxTwo idxTwo := rfl
      _ = Mat.entry (Mat.mul L isFiniteSet_two (pauliY i) exchangeMatrix) idxTwo idxTwo :=
          (entry_mul_two L _ _ _ _).symm

end Products

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
