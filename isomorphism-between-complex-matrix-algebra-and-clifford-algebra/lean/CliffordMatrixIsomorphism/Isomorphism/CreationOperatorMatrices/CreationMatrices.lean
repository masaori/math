/-
章「同型の証明」の、生成作用素の行列 c_i・消滅作用素の行列 c_i^T の定義と、生成作用素の行列を右・左から掛けた行列の成分の
具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                              このファイル
  def_creation_operator_matrix                              creationMatrix・creationMatrix_entry_of_cond・
                                                            creationMatrix_entry_of_not_cond
  def_annihilation_operator_matrix                          annihilationMatrix・annihilationMatrix_entry
  claim_entry_of_matrix_times_creation_operator_matrix      entry_mul_creationMatrix
  claim_entry_of_creation_operator_matrix_times_matrix      entry_creationMatrix_mul

表し方:
- 番号 i ∈ {1,…,M} は ℕ の元 i と証明 hi : 1 ≤ i ∧ i ≤ M の組で表す（`CountAndSign.lean` と同じ約束）。
  本文の前提 M ∈ ℤ_{≥1} は hi から従うので、別の仮定に置かない。
- 行列の添字集合は P_M（`PowerSet M`）、有限であることは `isFiniteSet_powerSet M`（本文
  claim_binary_numbering_is_numbering_of_power_set）、積は `Mat.mul (isFiniteSet_powerSet M)`。
- T ∪ {i} は `unionSingleton T i hi`（`CountAndSign.lean`）。c_i の成分の条件「i ∉ T かつ S = T ∪ {i}」の真偽による
  場合分けは、命題の判定に Classical を使う（本文の「どちらか一方だけが成り立つ」）。
- 本文の S' は `removeIndex S i`、c_i の条件が T = S' と同値であること（本文の準備）は
  `unionSingleton_cond_iff_eq_removeIndex`。どちらも ℂ を含まないので `IndexSetOperations.lean` に置く。
- 本文の場合分けの式（二つの場合の値）は、二つの場合の含意の組（∧）で書く。
- 本文の δ_{R,T}・δ_{S',T} の値を開く行（δ の定義）は、`kroneckerDelta` の if を `if_pos`・`if_neg` で開く。

和はどれも ℂ^vec（`complexNumbersVectorSpace`、証明の中では V と書く）の中の有限集合 P_M の上の和で、
本文が引く主張は次の宣言を引く。
  claim_sum_over_finite_set_depends_only_on_terms              sumOverFiniteSet_congr
  claim_scalar_multiple_of_sum_over_finite_set                 smul_sumOverFiniteSet
  claim_zero_scalar_multiple_is_zero_vector                    zero_smul_eq_zero
  claim_sum_over_finite_set_with_kronecker_delta_picks_term    sumOverFiniteSet_kroneckerDelta

必要十分版は `NecSuf/Isomorphism/CreationOperatorMatrices/CreationMatrices.lean`、導出版は `CreationMatricesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Definitions
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.IndexSetOperations
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.Sign

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 定義 -/

open Classical in
/-- 本文 `def_creation_operator_matrix`：(c_i)_{S,T} := ς(N_i(T))（i ∉ T かつ S = T ∪ {i}）、0_ℂ（それ以外）。 -/
noncomputable def creationMatrix (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) : Mat (PowerSet M) := fun p =>
  if i ∉ p.2.1 ∧ p.1 = unionSingleton p.2 i hi then sign (countBelow p.2 i) else 0

open Classical in
/-- 本文 `def_creation_operator_matrix`：条件「i ∉ T かつ S = T ∪ {i}」が成り立つなら (c_i)_{S,T} = ς(N_i(T))。 -/
theorem creationMatrix_entry_of_cond {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S T : PowerSet M}
    (h : i ∉ T.1 ∧ S = unionSingleton T i hi) :
    Mat.entry (creationMatrix M i hi) S T = sign (countBelow T i) := by
  show (if i ∉ T.1 ∧ S = unionSingleton T i hi then sign (countBelow T i) else 0) = _
  rw [if_pos h]

open Classical in
/-- 本文 `def_creation_operator_matrix`：条件が成り立たないなら (c_i)_{S,T} = 0_ℂ。 -/
theorem creationMatrix_entry_of_not_cond {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S T : PowerSet M}
    (h : ¬(i ∉ T.1 ∧ S = unionSingleton T i hi)) :
    Mat.entry (creationMatrix M i hi) S T = 0 := by
  show (if i ∉ T.1 ∧ S = unionSingleton T i hi then sign (countBelow T i) else 0) = _
  rw [if_neg h]

/-- 本文 `def_annihilation_operator_matrix`：(c_i^T)_{S,T} := (c_i)_{T,S}。 -/
noncomputable def annihilationMatrix (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) : Mat (PowerSet M) := fun p =>
  Mat.entry (creationMatrix M i hi) p.2 p.1

/-- 本文 `def_annihilation_operator_matrix`：(c_i^T)_{S,T} = (c_i)_{T,S}。 -/
theorem annihilationMatrix_entry {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (S T : PowerSet M) :
    Mat.entry (annihilationMatrix M i hi) S T = Mat.entry (creationMatrix M i hi) T S :=
  rfl

/-! ### 右から生成作用素の行列を掛けた行列の成分 -/

/-- 本文 `claim_entry_of_matrix_times_creation_operator_matrix`：
(A · c_j)_{S,U} = A_{S,U∪{j}} ·_ℂ ς(N_j(U))（j ∉ U）、0_ℂ（j ∈ U）。 -/
theorem entry_mul_creationMatrix {M j : ℕ} (hj : 1 ≤ j ∧ j ≤ M) (A : Mat (PowerSet M))
    (S U : PowerSet M) :
    (j ∉ U.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) A (creationMatrix M j hj)) S U
        = Mat.entry A S (unionSingleton U j hj) * sign (countBelow U j))
      ∧ (j ∈ U.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) A (creationMatrix M j hj)) S U = 0) := by
  let V := complexNumbersVectorSpace
  let hX := isFiniteSet_powerSet M
  constructor
  · -- j ∉ U のとき。R := U ∪ {j}。
    intro hjU
    let R := unionSingleton U j hj
    -- 準備：(c_j)_{T,U} = δ_{R,T} ·_ℂ ς(N_j(U))
    have hc : ∀ T : PowerSet M,
        Mat.entry (creationMatrix M j hj) T U = kroneckerDelta R T * sign (countBelow U j) := by
      intro T
      by_cases hT : T = R
      · calc Mat.entry (creationMatrix M j hj) T U
            = sign (countBelow U j) := creationMatrix_entry_of_cond hj ⟨hjU, hT⟩
          _ = 1 * sign (countBelow U j) := (one_mul (sign (countBelow U j))).symm
          _ = kroneckerDelta R T * sign (countBelow U j) := by
              rw [show kroneckerDelta R T = (1 : ℂ) from if_pos hT.symm]
      · calc Mat.entry (creationMatrix M j hj) T U
            = 0 := creationMatrix_entry_of_not_cond hj (fun h => hT h.2)
          _ = 0 * sign (countBelow U j) := (zero_mul (sign (countBelow U j))).symm
          _ = kroneckerDelta R T * sign (countBelow U j) := by
              rw [show kroneckerDelta R T = (0 : ℂ) from if_neg (fun h => hT h.symm)]
    -- 準備：r_T := A_{S,T} ·_ℂ ς(N_j(U))
    let r : PowerSet M → ℂ := fun T => Mat.entry A S T * sign (countBelow U j)
    -- 準備：A_{S,T} ·_{ℂ^vec} (c_j)_{T,U} = δ_{R,T} ·_{ℂ^vec} r_T
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry A S T) (Mat.entry (creationMatrix M j hj) T U)
          = V.smul (kroneckerDelta R T) (r T) := fun T => calc
      V.smul (Mat.entry A S T) (Mat.entry (creationMatrix M j hj) T U)
          = Mat.entry A S T * Mat.entry (creationMatrix M j hj) T U := rfl
      _ = Mat.entry A S T * (kroneckerDelta R T * sign (countBelow U j)) := by rw [hc T]
      _ = (Mat.entry A S T * kroneckerDelta R T) * sign (countBelow U j) :=
          (_root_.mul_assoc (Mat.entry A S T) (kroneckerDelta R T) (sign (countBelow U j))).symm
      _ = (kroneckerDelta R T * Mat.entry A S T) * sign (countBelow U j) := by
          rw [mul_comm (Mat.entry A S T) (kroneckerDelta R T)]
      _ = kroneckerDelta R T * (Mat.entry A S T * sign (countBelow U j)) :=
          _root_.mul_assoc (kroneckerDelta R T) (Mat.entry A S T) (sign (countBelow U j))
      _ = kroneckerDelta R T * r T := rfl
      _ = V.smul (kroneckerDelta R T) (r T) := rfl
    calc Mat.entry (Mat.mul hX A (creationMatrix M j hj)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry A S T)
            (fun T => Mat.entry (creationMatrix M j hj) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => kroneckerDelta R T) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r R := sumOverFiniteSet_kroneckerDelta V hX r R
      _ = Mat.entry A S R * sign (countBelow U j) := rfl
      _ = Mat.entry A S (unionSingleton U j hj) * sign (countBelow U j) := rfl
  · -- j ∈ U のとき。c_j の条件「j ∉ U かつ T = U ∪ {j}」は成り立たない。
    intro hjU
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry A S T) (Mat.entry (creationMatrix M j hj) T U) = V.smul (0 * 1) 1 :=
      fun T => calc
      V.smul (Mat.entry A S T) (Mat.entry (creationMatrix M j hj) T U)
          = Mat.entry A S T * Mat.entry (creationMatrix M j hj) T U := rfl
      _ = Mat.entry A S T * 0 := by
          rw [creationMatrix_entry_of_not_cond hj (fun h => h.1 hjU)]
      _ = 0 := mul_zero (Mat.entry A S T)
      _ = (0 * 1) * 1 := by rw [zero_mul (1 : ℂ), zero_mul (1 : ℂ)]
      _ = V.smul (0 * 1) 1 := rfl
    calc Mat.entry (Mat.mul hX A (creationMatrix M j hj)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry A S T)
            (fun T => Mat.entry (creationMatrix M j hj) T U) := rfl
      _ = sumOverFiniteSet V hX (fun _ => 0 * 1) (fun _ => 1) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = V.smul 0 (sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1)) :=
          (smul_sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1) 0).symm
      _ = V.zero := zero_smul_eq_zero V _
      _ = 0 := rfl

/-! ### 左から生成作用素の行列を掛けた行列の成分 -/

/-- 本文 `claim_entry_of_creation_operator_matrix_times_matrix`：
(c_i · A)_{S,U} = ς(N_i(S')) ·_ℂ A_{S',U}（i ∈ S）、0_ℂ（i ∉ S）。 -/
theorem entry_creationMatrix_mul {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (A : Mat (PowerSet M))
    (S U : PowerSet M) :
    (i ∈ S.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) A) S U
        = sign (countBelow (removeIndex S i) i) * Mat.entry A (removeIndex S i) U)
      ∧ (i ∉ S.1 → Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) A) S U = 0) := by
  let V := complexNumbersVectorSpace
  let hX := isFiniteSet_powerSet M
  constructor
  · -- i ∈ S のとき。
    intro hiS
    let S' := removeIndex S i
    -- 準備：(c_i)_{S,T} = δ_{S',T} ·_ℂ ς(N_i(S'))
    have hc : ∀ T : PowerSet M,
        Mat.entry (creationMatrix M i hi) S T = kroneckerDelta S' T * sign (countBelow S' i) := by
      intro T
      by_cases hT : T = S'
      · calc Mat.entry (creationMatrix M i hi) S T
            = sign (countBelow T i) :=
              creationMatrix_entry_of_cond hi ((unionSingleton_cond_iff_eq_removeIndex hi hiS T).2 hT)
          _ = sign (countBelow S' i) := by rw [hT]
          _ = 1 * sign (countBelow S' i) := (one_mul (sign (countBelow S' i))).symm
          _ = kroneckerDelta S' T * sign (countBelow S' i) := by
              rw [show kroneckerDelta S' T = (1 : ℂ) from if_pos hT.symm]
      · calc Mat.entry (creationMatrix M i hi) S T
            = 0 := creationMatrix_entry_of_not_cond hi
                (fun h => hT ((unionSingleton_cond_iff_eq_removeIndex hi hiS T).1 h))
          _ = 0 * sign (countBelow S' i) := (zero_mul (sign (countBelow S' i))).symm
          _ = kroneckerDelta S' T * sign (countBelow S' i) := by
              rw [show kroneckerDelta S' T = (0 : ℂ) from if_neg (fun h => hT h.symm)]
    -- 準備：r_T := ς(N_i(S')) ·_ℂ A_{T,U}
    let r : PowerSet M → ℂ := fun T => sign (countBelow S' i) * Mat.entry A T U
    -- 準備：(c_i)_{S,T} ·_{ℂ^vec} A_{T,U} = δ_{S',T} ·_{ℂ^vec} r_T
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (creationMatrix M i hi) S T) (Mat.entry A T U)
          = V.smul (kroneckerDelta S' T) (r T) := fun T => calc
      V.smul (Mat.entry (creationMatrix M i hi) S T) (Mat.entry A T U)
          = Mat.entry (creationMatrix M i hi) S T * Mat.entry A T U := rfl
      _ = (kroneckerDelta S' T * sign (countBelow S' i)) * Mat.entry A T U := by rw [hc T]
      _ = kroneckerDelta S' T * (sign (countBelow S' i) * Mat.entry A T U) :=
          _root_.mul_assoc (kroneckerDelta S' T) (sign (countBelow S' i)) (Mat.entry A T U)
      _ = kroneckerDelta S' T * r T := rfl
      _ = V.smul (kroneckerDelta S' T) (r T) := rfl
    calc Mat.entry (Mat.mul hX (creationMatrix M i hi) A) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix M i hi) S T)
            (fun T => Mat.entry A T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => kroneckerDelta S' T) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r S' := sumOverFiniteSet_kroneckerDelta V hX r S'
      _ = sign (countBelow S' i) * Mat.entry A S' U := rfl
  · -- i ∉ S のとき。S = T ∪ {i} なら i ∈ S なので、c_i の条件は成り立たない。
    intro hiS
    have hcond : ∀ T : PowerSet M, ¬(i ∉ T.1 ∧ S = unionSingleton T i hi) := by
      rintro T ⟨_, hS⟩
      apply hiS
      rw [hS]
      exact self_mem_unionSingleton T i hi
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (creationMatrix M i hi) S T) (Mat.entry A T U) = V.smul (0 * 1) 1 :=
      fun T => calc
      V.smul (Mat.entry (creationMatrix M i hi) S T) (Mat.entry A T U)
          = Mat.entry (creationMatrix M i hi) S T * Mat.entry A T U := rfl
      _ = 0 * Mat.entry A T U := by rw [creationMatrix_entry_of_not_cond hi (hcond T)]
      _ = 0 := zero_mul (Mat.entry A T U)
      _ = (0 * 1) * 1 := by rw [zero_mul (1 : ℂ), zero_mul (1 : ℂ)]
      _ = V.smul (0 * 1) 1 := rfl
    calc Mat.entry (Mat.mul hX (creationMatrix M i hi) A) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix M i hi) S T)
            (fun T => Mat.entry A T U) := rfl
      _ = sumOverFiniteSet V hX (fun _ => 0 * 1) (fun _ => 1) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = V.smul 0 (sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1)) :=
          (smul_sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1) 0).symm
      _ = V.zero := zero_smul_eq_zero V _
      _ = 0 := rfl

end CliffordMatrixIsomorphism.Isomorphism
