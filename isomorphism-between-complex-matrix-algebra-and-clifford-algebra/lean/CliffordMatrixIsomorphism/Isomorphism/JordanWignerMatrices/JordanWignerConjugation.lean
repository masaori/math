/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Jordan–Wigner 行列 Z_m・Y_m、
すべての因子が K・K' のクロネッカー積 U・U' と、生成作用素・消滅作用素の行列を U と U' で挟んだ行列の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_jordan_wigner_z_matrix                                                         jordanWignerZFactor（F_k）・jordanWignerZ（Z_m）
  def_jordan_wigner_y_matrix                                                         jordanWignerYFactor（F'_k）・jordanWignerY（Y_m）
  def_kronecker_power_of_matrix_exchanging_pauli_z_and_x                             kroneckerPowerOfExchange（U）
  def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x                     kroneckerPowerOfHalfExchange（U'）
  claim_kronecker_power_of_k_times_that_of_its_half_is_identity                      kroneckerPowerOfExchange_mul_half
  claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity                     kroneckerPowerOfHalfExchange_mul
  claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix
                                                                                     sumFactor（G_k）・conjugation_creation_add_annihilation
  claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix
                                                                                     imaginarySumFactor（G'_k）・
                                                                                     conjugation_imaginary_combination

表し方:
- B := Mat_{P_M}(ℂ) の演算は `Mat.add`・`Mat.mul (isFiniteSet_powerSet M)`・`Mat.smul`・`Mat.one`、κ_{U,U'} は
  `conjugation (isFiniteSet_powerSet M) U U'`（`Conjugation.lean`）。
- 本文の主張と定義は M ≥ 1 を前提に置くが、U・U' の主張は M ≥ 1 を使わないので、任意の M で書く。
  Z_m・Y_m の主張は m ∈ {1,…,M} を c_m を作るのに使う（`hm`）。
- 本文の「（一）」「（二）」は証明の中の `have` に置く。「各 k で（二）」の行は、すべての k で等しい因子の族の等式 `funext` を
  `kroneckerProduct M` に渡す行である（本文が引く def_kronecker_product_indexed_by_power_set の定義を開かずに済む）。
- 本文が引く主張は次の宣言を引く。
    claim_product_of_kronecker_products_is_kronecker_product_of_products   mul_kroneckerProduct
    claim_kronecker_products_of_factorwise_equal_families_are_equal        kroneckerProduct_congr
    claim_kronecker_product_of_identity_matrices_is_identity_matrix        kroneckerProduct_one
    claim_kronecker_product_is_linear_in_one_factor                        kroneckerProduct_linear_in_one_factor
    claim_matrix_product_is_associative                                    mat_mul_assoc
    claim_identity_matrix_is_right_unit_of_matrix_product                  mat_mul_one
    claim_identity_matrix_is_left_unit_of_matrix_product                   mat_one_mul
    claim_matrices_indexed_by_finite_set_form_complex_vector_space         matricesVectorSpace（スカラー倍の単位元 one_smul）

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/JordanWignerConjugation.lean`、導出版は `JordanWignerConjugationFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.CreationMatricesAsKroneckerProducts
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.Conjugation

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### Jordan–Wigner 行列 -/

/-- 本文 `def_jordan_wigner_z_matrix` の右辺の第 k 因子 F_k：σx（k < m）、σz（k = m）、I_2（k > m）。 -/
noncomputable def jordanWignerZFactor (m k : ℕ) : Mat (Idx 2) :=
  if k < m then pauliX else if k = m then pauliZ else Mat.one

/-- 本文 `def_jordan_wigner_z_matrix`：Z_m := ⊠_{k=1}^{M} F_k。 -/
noncomputable def jordanWignerZ (M m : ℕ) : Mat (PowerSet M) := kroneckerProduct M (jordanWignerZFactor m)

/-- 本文 `def_jordan_wigner_y_matrix` の右辺の第 k 因子 F'_k：σx（k < m）、σy（k = m）、I_2（k > m）。 -/
noncomputable def jordanWignerYFactor (m k : ℕ) : Mat (Idx 2) :=
  if k < m then pauliX else if k = m then pauliY else Mat.one

/-- 本文 `def_jordan_wigner_y_matrix`：Y_m := ⊠_{k=1}^{M} F'_k。 -/
noncomputable def jordanWignerY (M m : ℕ) : Mat (PowerSet M) := kroneckerProduct M (jordanWignerYFactor m)

/-! ### U と U' -/

/-- 本文 `def_kronecker_power_of_matrix_exchanging_pauli_z_and_x`：U := ⊠_{k=1}^{M} K。 -/
noncomputable def kroneckerPowerOfExchange (M : ℕ) : Mat (PowerSet M) :=
  kroneckerProduct M (fun _ => exchangeMatrix)

/-- 本文 `def_kronecker_power_of_half_of_matrix_exchanging_pauli_z_and_x`：U' := ⊠_{k=1}^{M} K'。 -/
noncomputable def kroneckerPowerOfHalfExchange (M : ℕ) : Mat (PowerSet M) :=
  kroneckerProduct M (fun _ => halfExchangeMatrix)

/-- 本文 `claim_kronecker_power_of_k_times_that_of_its_half_is_identity`：U ·_{Mat_{P_M}} U' = 1_{Mat_{P_M}}。 -/
theorem kroneckerPowerOfExchange_mul_half (M : ℕ) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M) = Mat.one := calc
  Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M)
      = kroneckerProduct M (fun _ => Mat.mul isFiniteSet_two exchangeMatrix halfExchangeMatrix) :=
        mul_kroneckerProduct M _ _
  _ = kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2))) :=
        kroneckerProduct_congr M _ _ fun _ _ _ => exchangeMatrix_mul_halfExchangeMatrix
  _ = Mat.one := kroneckerProduct_one M

/-- 本文 `claim_kronecker_power_of_half_of_k_times_that_of_k_is_identity`：U' ·_{Mat_{P_M}} U = 1_{Mat_{P_M}}。 -/
theorem kroneckerPowerOfHalfExchange_mul (M : ℕ) :
    Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfHalfExchange M) (kroneckerPowerOfExchange M) = Mat.one := calc
  Mat.mul (isFiniteSet_powerSet M) (kroneckerPowerOfHalfExchange M) (kroneckerPowerOfExchange M)
      = kroneckerProduct M (fun _ => Mat.mul isFiniteSet_two halfExchangeMatrix exchangeMatrix) :=
        mul_kroneckerProduct M _ _
  _ = kroneckerProduct M (fun _ => (Mat.one : Mat (Idx 2))) :=
        kroneckerProduct_congr M _ _ fun _ _ _ => halfExchangeMatrix_mul_exchangeMatrix
  _ = Mat.one := kroneckerProduct_one M

/-! ### 生成作用素と消滅作用素の行列を U と U' で挟む -/

/-- 本文 `claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix` の証明の族 G_k：
A_k（k ≠ m）、G_m := (1_ℂ ∗ E_{2,1}) + (1_ℂ ∗ E_{1,2})。 -/
noncomputable def sumFactor (m k : ℕ) : Mat (Idx 2) := if k = m then offDiagonalSum else creationFactor m k

/-- 本文 `claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix` の
証明の族 G'_k：A_k（k ≠ m）、G'_m := ((-_ℂ i) ∗ E_{2,1}) + (i ∗ E_{1,2})。 -/
noncomputable def imaginarySumFactor (m k : ℕ) : Mat (Idx 2) :=
  if k = m then imaginaryOffDiagonalCombination else creationFactor m k

/-- 二つの主張の（二）のうち k ≠ m の場合：K ·_{Mat_{1,2}} A_k = F_k ·_{Mat_{1,2}} K（F_k が k < m で σx、k > m で I_2 の族）。 -/
theorem exchangeMatrix_mul_creationFactor_of_ne (m k : ℕ) (hkm : k ≠ m) (F : Mat (Idx 2))
    (hF : F = if k < m then pauliX else Mat.one) :
    Mat.mul isFiniteSet_two exchangeMatrix (creationFactor m k) = Mat.mul isFiniteSet_two F exchangeMatrix := by
  rcases Nat.lt_or_gt_of_ne hkm with hlt | hgt
  · -- k < m なら G_k = σz、F_k = σx（claim_matrix_k_turns_pauli_z_into_pauli_x）
    rw [creationFactor_of_lt hlt, hF, if_pos hlt]
    exact exchangeMatrix_mul_pauliZ
  · -- k > m なら G_k = F_k = I_2 で、K · I_2 = K = I_2 · K
    rw [creationFactor_of_gt hgt, hF, if_neg (by omega)]
    calc Mat.mul isFiniteSet_two exchangeMatrix Mat.one = exchangeMatrix := mat_mul_one isFiniteSet_two _
      _ = Mat.mul isFiniteSet_two Mat.one exchangeMatrix := (mat_one_mul isFiniteSet_two _).symm

/-- 本文 `claim_conjugation_of_sum_of_creation_and_annihilation_matrices_is_jordan_wigner_z_matrix`：
κ_{U,U'}(c_m +_B c_m^T) = Z_m。 -/
theorem conjugation_creation_add_annihilation (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M)
      (Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm)) = jordanWignerZ M m := by
  let hX := isFiniteSet_powerSet M
  let U := kroneckerPowerOfExchange M
  let U' := kroneckerPowerOfHalfExchange M
  let B := matricesVectorSpace (PowerSet M)
  -- （一）c_m +_B c_m^T = ⊠_k G_k
  have h1 : Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm) = kroneckerProduct M (sumFactor m) := calc
    Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm)
        = Mat.add (Mat.smul 1 (creationMatrix M m hm)) (Mat.smul 1 (annihilationMatrix M m hm)) := by
          rw [show Mat.smul 1 (creationMatrix M m hm) = creationMatrix M m hm from B.one_smul _,
            show Mat.smul 1 (annihilationMatrix M m hm) = annihilationMatrix M m hm from B.one_smul _]
    _ = Mat.add (Mat.smul 1 (kroneckerProduct M (creationFactor m)))
          (Mat.smul 1 (kroneckerProduct M (annihilationFactor m))) := by
          rw [creationMatrix_eq_kroneckerProduct M m hm, annihilationMatrix_eq_kroneckerProduct M m hm]
    _ = kroneckerProduct M (sumFactor m) :=
        (kroneckerProduct_linear_in_one_factor M m hm.1 hm.2 1 1 (creationFactor m) (annihilationFactor m)
          (sumFactor m)
          (fun k _ _ hkm => ⟨(annihilationFactor_of_ne hkm).symm, (if_neg hkm : sumFactor m k = _).symm⟩)
          (by
            show (if m = m then offDiagonalSum else creationFactor m m) = _
            rw [if_pos rfl, creationFactor_self, annihilationFactor_self]
            rfl)).symm
  -- （二）すべての k で K ·_{Mat_{1,2}} G_k = F_k ·_{Mat_{1,2}} K
  have h2 : ∀ k : ℕ, Mat.mul isFiniteSet_two exchangeMatrix (sumFactor m k)
      = Mat.mul isFiniteSet_two (jordanWignerZFactor m k) exchangeMatrix := by
    intro k
    by_cases hkm : k = m
    · -- k = m（claim_matrix_k_turns_sum_of_off_diagonal_matrix_units_into_pauli_z）
      subst hkm
      rw [show sumFactor k k = offDiagonalSum from if_pos rfl,
        show jordanWignerZFactor k k = pauliZ by unfold jordanWignerZFactor; rw [if_neg (lt_irrefl k), if_pos rfl]]
      exact exchangeMatrix_mul_offDiagonalSum
    · rw [show sumFactor m k = creationFactor m k from if_neg hkm]
      apply exchangeMatrix_mul_creationFactor_of_ne m k hkm
      unfold jordanWignerZFactor
      by_cases hlt : k < m
      · rw [if_pos hlt, if_pos hlt]
      · rw [if_neg hlt, if_neg hlt, if_neg hkm]
  calc conjugation hX U U' (Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm))
      = Mat.mul hX (Mat.mul hX U (Mat.add (creationMatrix M m hm) (annihilationMatrix M m hm))) U' := rfl
    _ = Mat.mul hX (Mat.mul hX U (kroneckerProduct M (sumFactor m))) U' := by rw [h1]
    _ = Mat.mul hX (Mat.mul hX (kroneckerProduct M (fun _ => exchangeMatrix)) (kroneckerProduct M (sumFactor m))) U' :=
        rfl
    _ = Mat.mul hX (kroneckerProduct M (fun k => Mat.mul isFiniteSet_two exchangeMatrix (sumFactor m k))) U' := by
        rw [mul_kroneckerProduct]
    _ = Mat.mul hX (kroneckerProduct M (fun k => Mat.mul isFiniteSet_two (jordanWignerZFactor m k) exchangeMatrix))
          U' := by rw [funext h2]
    _ = Mat.mul hX (Mat.mul hX (kroneckerProduct M (jordanWignerZFactor m))
          (kroneckerProduct M (fun _ => exchangeMatrix))) U' := by rw [mul_kroneckerProduct]
    _ = Mat.mul hX (Mat.mul hX (jordanWignerZ M m) (kroneckerProduct M (fun _ => exchangeMatrix))) U' := rfl
    _ = Mat.mul hX (Mat.mul hX (jordanWignerZ M m) U) U' := rfl
    _ = Mat.mul hX (jordanWignerZ M m) (Mat.mul hX U U') := mat_mul_assoc hX _ _ _
    _ = Mat.mul hX (jordanWignerZ M m) Mat.one := by rw [kroneckerPowerOfExchange_mul_half M]
    _ = jordanWignerZ M m := mat_mul_one hX _

/-- 本文 `claim_conjugation_of_imaginary_combination_of_creation_and_annihilation_matrices_is_jordan_wigner_y_matrix`：
κ_{U,U'}(((-_ℂ i) ∗_B c_m) +_B (i ∗_B c_m^T)) = Y_m。 -/
theorem conjugation_imaginary_combination (M m : ℕ) (hm : 1 ≤ m ∧ m ≤ M) :
    conjugation (isFiniteSet_powerSet M) (kroneckerPowerOfExchange M) (kroneckerPowerOfHalfExchange M)
      (Mat.add (Mat.smul (-imaginaryUnit) (creationMatrix M m hm)) (Mat.smul imaginaryUnit (annihilationMatrix M m hm)))
      = jordanWignerY M m := by
  let hX := isFiniteSet_powerSet M
  let U := kroneckerPowerOfExchange M
  let U' := kroneckerPowerOfHalfExchange M
  let i := imaginaryUnit
  let H := Mat.add (Mat.smul (-i) (creationMatrix M m hm)) (Mat.smul i (annihilationMatrix M m hm))
  -- （一）H = ⊠_k G'_k
  have h1 : H = kroneckerProduct M (imaginarySumFactor m) := calc
    H = Mat.add (Mat.smul (-i) (kroneckerProduct M (creationFactor m)))
          (Mat.smul i (kroneckerProduct M (annihilationFactor m))) := by
          show Mat.add (Mat.smul (-i) (creationMatrix M m hm)) (Mat.smul i (annihilationMatrix M m hm)) = _
          rw [creationMatrix_eq_kroneckerProduct M m hm, annihilationMatrix_eq_kroneckerProduct M m hm]
    _ = kroneckerProduct M (imaginarySumFactor m) :=
        (kroneckerProduct_linear_in_one_factor M m hm.1 hm.2 (-i) i (creationFactor m) (annihilationFactor m)
          (imaginarySumFactor m)
          (fun k _ _ hkm => ⟨(annihilationFactor_of_ne hkm).symm, (if_neg hkm : imaginarySumFactor m k = _).symm⟩)
          (by
            show (if m = m then imaginaryOffDiagonalCombination else creationFactor m m) = _
            rw [if_pos rfl, creationFactor_self, annihilationFactor_self]
            rfl)).symm
  -- （二）すべての k で K ·_{Mat_{1,2}} G'_k = F'_k ·_{Mat_{1,2}} K
  have h2 : ∀ k : ℕ, Mat.mul isFiniteSet_two exchangeMatrix (imaginarySumFactor m k)
      = Mat.mul isFiniteSet_two (jordanWignerYFactor m k) exchangeMatrix := by
    intro k
    by_cases hkm : k = m
    · -- k = m（claim_matrix_k_turns_imaginary_combination_of_off_diagonal_matrix_units_into_pauli_y）
      subst hkm
      rw [show imaginarySumFactor k k = imaginaryOffDiagonalCombination from if_pos rfl,
        show jordanWignerYFactor k k = pauliY by unfold jordanWignerYFactor; rw [if_neg (lt_irrefl k), if_pos rfl]]
      exact exchangeMatrix_mul_imaginaryOffDiagonalCombination
    · rw [show imaginarySumFactor m k = creationFactor m k from if_neg hkm]
      apply exchangeMatrix_mul_creationFactor_of_ne m k hkm
      unfold jordanWignerYFactor
      by_cases hlt : k < m
      · rw [if_pos hlt, if_pos hlt]
      · rw [if_neg hlt, if_neg hlt, if_neg hkm]
  calc conjugation hX U U' H
      = Mat.mul hX (Mat.mul hX U H) U' := rfl
    _ = Mat.mul hX (Mat.mul hX U (kroneckerProduct M (imaginarySumFactor m))) U' := by rw [h1]
    _ = Mat.mul hX (Mat.mul hX (kroneckerProduct M (fun _ => exchangeMatrix))
          (kroneckerProduct M (imaginarySumFactor m))) U' := rfl
    _ = Mat.mul hX (kroneckerProduct M (fun k => Mat.mul isFiniteSet_two exchangeMatrix (imaginarySumFactor m k)))
          U' := by rw [mul_kroneckerProduct]
    _ = Mat.mul hX (kroneckerProduct M (fun k => Mat.mul isFiniteSet_two (jordanWignerYFactor m k) exchangeMatrix))
          U' := by rw [funext h2]
    _ = Mat.mul hX (Mat.mul hX (kroneckerProduct M (jordanWignerYFactor m))
          (kroneckerProduct M (fun _ => exchangeMatrix))) U' := by rw [mul_kroneckerProduct]
    _ = Mat.mul hX (Mat.mul hX (jordanWignerY M m) (kroneckerProduct M (fun _ => exchangeMatrix))) U' := rfl
    _ = Mat.mul hX (Mat.mul hX (jordanWignerY M m) U) U' := rfl
    _ = Mat.mul hX (jordanWignerY M m) (Mat.mul hX U U') := mat_mul_assoc hX _ _ _
    _ = Mat.mul hX (jordanWignerY M m) Mat.one := by rw [kroneckerPowerOfExchange_mul_half M]
    _ = jordanWignerY M m := mat_mul_one hX _

end CliffordMatrixIsomorphism.Isomorphism
