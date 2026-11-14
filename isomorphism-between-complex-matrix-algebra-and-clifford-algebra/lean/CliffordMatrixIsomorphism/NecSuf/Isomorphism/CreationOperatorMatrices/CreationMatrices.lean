/-
章「同型の証明」の、生成作用素の行列・消滅作用素の行列の定義と、生成作用素の行列を右・左から掛けた行列の成分の必要十分版。
具体版 `Isomorphism/CreationOperatorMatrices/CreationMatrices.lean` と同じ def と同じ calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替える（ς は `NecSuf/Isomorphism/CreationOperatorMatrices/Sign.lean` の `sign n`）。
K には演算の記号 +・·・0・1 だけを与え、使う性質は仮定として渡す。

  本文のラベル                                              このファイル                        使う K の性質
  def_creation_operator_matrix                              creationMatrix・…_of_cond・         なし（n を一つ与えるだけ）
                                                            …_of_not_cond
  def_annihilation_operator_matrix                          annihilationMatrix・                なし
                                                            annihilationMatrix_entry
  claim_entry_of_matrix_times_creation_operator_matrix      entry_mul_creationMatrix            L・a · 1 = a・a · 0 = 0・0 · a = 0
  claim_entry_of_creation_operator_matrix_times_matrix      entry_creationMatrix_mul            L・a · 0 = 0・0 · a = 0

L : `ValuedMapsLaws K` は積 `Mat.mul L hX` を定めるのに要る（和をとる線型空間 K^vec を作る八つ）。行の中で L から使うのは、
乗法の結合法則、1 · a = a、和の主張に渡す 0 + 0 = 0（`L.add_zero 0`）だけである。

削れなかった仮定:
- a · 0 = 0（二つの主張）: 0_K との積の行（A_{S,T} · 0 = 0）と、和のスカラー倍の主張 `smul_sumOverFiniteSet` の仮定。
- 0 · a = 0（二つの主張）: 0_K との積の行（0 · ς = 0、0 · A_{T,U} = 0、0 = (0 · 1) · 1）。
- a · 1 = a（右から掛ける主張）: 具体版の A_{S,T} ·_ℂ δ_{R,T} = δ_{R,T} ·_ℂ A_{S,T}（ℂ の乗法の交換法則）の行。
  δ の値は 0 か 1 なので、この行に要る交換は a · 1 = 1 · a と a · 0 = 0 · a だけであり、1 · a = a（L）・a · 0 = 0・0 · a = 0
  と合わせて a · 1 = a から得る（`mul_kroneckerDelta_comm`）。乗法の交換法則そのものは要らない。
  左から掛ける主張は (δ · ς) · A = δ · (ς · A) と並べるだけで、交換を使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Definitions
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.CreationOperatorMatrices.Sign
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.IndexSetOperations

namespace CliffordMatrixIsomorphism.NecSuf.Isomorphism

open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)
open CliffordMatrixIsomorphism.Isomorphism
  (countBelow unionSingleton removeIndex unionSingleton_cond_iff_eq_removeIndex self_mem_unionSingleton)

universe uK

variable {K : Type uK} [Mul K] [One K] [Zero K]

/-! ### 定義 -/

open Classical in
/-- 本文 `def_creation_operator_matrix` の必要十分版：(c_i)_{S,T} := ς(N_i(T))（i ∉ T かつ S = T ∪ {i}）、0（それ以外）。 -/
noncomputable def creationMatrix (n : K) (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) : Mat K (PowerSet M) := fun p =>
  if i ∉ p.2.1 ∧ p.1 = unionSingleton p.2 i hi then sign n (countBelow p.2 i) else 0

open Classical in
/-- 本文 `def_creation_operator_matrix` の必要十分版：条件が成り立つなら (c_i)_{S,T} = ς(N_i(T))。 -/
theorem creationMatrix_entry_of_cond (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S T : PowerSet M}
    (h : i ∉ T.1 ∧ S = unionSingleton T i hi) :
    Mat.entry (creationMatrix n M i hi) S T = sign n (countBelow T i) := by
  show (if i ∉ T.1 ∧ S = unionSingleton T i hi then sign n (countBelow T i) else 0) = _
  rw [if_pos h]

open Classical in
/-- 本文 `def_creation_operator_matrix` の必要十分版：条件が成り立たないなら (c_i)_{S,T} = 0。 -/
theorem creationMatrix_entry_of_not_cond (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) {S T : PowerSet M}
    (h : ¬(i ∉ T.1 ∧ S = unionSingleton T i hi)) :
    Mat.entry (creationMatrix n M i hi) S T = 0 := by
  show (if i ∉ T.1 ∧ S = unionSingleton T i hi then sign n (countBelow T i) else 0) = _
  rw [if_neg h]

/-- 本文 `def_annihilation_operator_matrix` の必要十分版：(c_i^T)_{S,T} := (c_i)_{T,S}。 -/
noncomputable def annihilationMatrix (n : K) (M i : ℕ) (hi : 1 ≤ i ∧ i ≤ M) : Mat K (PowerSet M) := fun p =>
  Mat.entry (creationMatrix n M i hi) p.2 p.1

/-- 本文 `def_annihilation_operator_matrix` の必要十分版：(c_i^T)_{S,T} = (c_i)_{T,S}。 -/
theorem annihilationMatrix_entry (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (S T : PowerSet M) :
    Mat.entry (annihilationMatrix n M i hi) S T = Mat.entry (creationMatrix n M i hi) T S :=
  rfl

/-! ### 右から生成作用素の行列を掛けた行列の成分 -/

variable [Add K]

/-- 具体版の A_{S,T} ·_ℂ δ_{R,T} = δ_{R,T} ·_ℂ A_{S,T}（ℂ の乗法の交換法則）の行に要る交換：δ の値は 1 か 0 なので、
a · 1 = a = 1 · a と a · 0 = 0 = 0 · a から従う。 -/
theorem mul_kroneckerDelta_comm (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) {X : Type*} [DecidableEq X]
    (a : K) (x y : X) : a * kroneckerDelta x y = kroneckerDelta x y * a := by
  by_cases hxy : x = y
  · rw [show kroneckerDelta x y = (1 : K) from if_pos hxy, hmul1 a, L.one_mul a]
  · rw [show kroneckerDelta x y = (0 : K) from if_neg hxy, hmul0 a, hzero_mul a]

/-- 本文 `claim_entry_of_matrix_times_creation_operator_matrix` の必要十分版：
(A · c_j)_{S,U} = A_{S,U∪{j}} · ς(N_j(U))（j ∉ U）、0（j ∈ U）。 -/
theorem entry_mul_creationMatrix (L : ValuedMapsLaws K) (hmul1 : ∀ a : K, a * 1 = a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0) (n : K)
    {M j : ℕ} (hj : 1 ≤ j ∧ j ≤ M) (A : Mat K (PowerSet M)) (S U : PowerSet M) :
    (j ∉ U.1 → Mat.entry (Mat.mul L (isFiniteSet_powerSet M) A (creationMatrix n M j hj)) S U
        = Mat.entry A S (unionSingleton U j hj) * sign n (countBelow U j))
      ∧ (j ∈ U.1 → Mat.entry (Mat.mul L (isFiniteSet_powerSet M) A (creationMatrix n M j hj)) S U = 0) := by
  let V := coefficientsVec L
  let hX := isFiniteSet_powerSet M
  constructor
  · -- j ∉ U のとき。R := U ∪ {j}。
    intro hjU
    let R := unionSingleton U j hj
    -- 準備：(c_j)_{T,U} = δ_{R,T} · ς(N_j(U))
    have hc : ∀ T : PowerSet M,
        Mat.entry (creationMatrix n M j hj) T U = (kroneckerDelta R T : K) * sign n (countBelow U j) := by
      intro T
      by_cases hT : T = R
      · calc Mat.entry (creationMatrix n M j hj) T U
            = sign n (countBelow U j) := creationMatrix_entry_of_cond n hj ⟨hjU, hT⟩
          _ = 1 * sign n (countBelow U j) := (L.one_mul (sign n (countBelow U j))).symm
          _ = (kroneckerDelta R T : K) * sign n (countBelow U j) := by
              rw [show (kroneckerDelta R T : K) = (1 : K) from if_pos hT.symm]
      · calc Mat.entry (creationMatrix n M j hj) T U
            = 0 := creationMatrix_entry_of_not_cond n hj (fun h => hT h.2)
          _ = 0 * sign n (countBelow U j) := (hzero_mul (sign n (countBelow U j))).symm
          _ = (kroneckerDelta R T : K) * sign n (countBelow U j) := by
              rw [show (kroneckerDelta R T : K) = (0 : K) from if_neg (fun h => hT h.symm)]
    -- 準備：r_T := A_{S,T} · ς(N_j(U))
    let r : PowerSet M → K := fun T => Mat.entry A S T * sign n (countBelow U j)
    -- 準備：A_{S,T} ·_{K^vec} (c_j)_{T,U} = δ_{R,T} ·_{K^vec} r_T
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry A S T) (Mat.entry (creationMatrix n M j hj) T U)
          = V.smul (kroneckerDelta R T) (r T) := fun T => calc
      V.smul (Mat.entry A S T) (Mat.entry (creationMatrix n M j hj) T U)
          = Mat.entry A S T * Mat.entry (creationMatrix n M j hj) T U := rfl
      _ = Mat.entry A S T * ((kroneckerDelta R T : K) * sign n (countBelow U j)) := by rw [hc T]
      _ = (Mat.entry A S T * (kroneckerDelta R T : K)) * sign n (countBelow U j) :=
          (L.mul_assoc (Mat.entry A S T) (kroneckerDelta R T) (sign n (countBelow U j))).symm
      _ = ((kroneckerDelta R T : K) * Mat.entry A S T) * sign n (countBelow U j) := by
          rw [mul_kroneckerDelta_comm L hmul1 hmul0 hzero_mul (Mat.entry A S T) R T]
      _ = (kroneckerDelta R T : K) * (Mat.entry A S T * sign n (countBelow U j)) :=
          L.mul_assoc (kroneckerDelta R T) (Mat.entry A S T) (sign n (countBelow U j))
      _ = (kroneckerDelta R T : K) * r T := rfl
      _ = V.smul (kroneckerDelta R T) (r T) := rfl
    calc Mat.entry (Mat.mul L hX A (creationMatrix n M j hj)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry A S T)
            (fun T => Mat.entry (creationMatrix n M j hj) T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => (kroneckerDelta R T : K)) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r R := sumOverFiniteSet_kroneckerDelta V (L.add_zero 0) hX r R
      _ = Mat.entry A S R * sign n (countBelow U j) := rfl
      _ = Mat.entry A S (unionSingleton U j hj) * sign n (countBelow U j) := rfl
  · -- j ∈ U のとき。c_j の条件「j ∉ U かつ T = U ∪ {j}」は成り立たない。
    intro hjU
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry A S T) (Mat.entry (creationMatrix n M j hj) T U) = V.smul (0 * 1) 1 :=
      fun T => calc
      V.smul (Mat.entry A S T) (Mat.entry (creationMatrix n M j hj) T U)
          = Mat.entry A S T * Mat.entry (creationMatrix n M j hj) T U := rfl
      _ = Mat.entry A S T * 0 := by
          rw [creationMatrix_entry_of_not_cond n hj (fun h => h.1 hjU)]
      _ = 0 := hmul0 (Mat.entry A S T)
      _ = (0 * 1) * 1 := by rw [hzero_mul (1 : K), hzero_mul (1 : K)]
      _ = V.smul (0 * 1) 1 := rfl
    calc Mat.entry (Mat.mul L hX A (creationMatrix n M j hj)) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry A S T)
            (fun T => Mat.entry (creationMatrix n M j hj) T U) := rfl
      _ = sumOverFiniteSet V hX (fun _ => 0 * 1) (fun _ => 1) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = V.smul 0 (sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1)) :=
          (smul_sumOverFiniteSet V (L.add_zero 0) hmul0 hX (fun _ => 1) (fun _ => 1) 0).symm
      _ = V.zero := zero_smul_eq_zero V (L.add_zero 0) _
      _ = 0 := rfl

/-! ### 左から生成作用素の行列を掛けた行列の成分 -/

/-- 本文 `claim_entry_of_creation_operator_matrix_times_matrix` の必要十分版：
(c_i · A)_{S,U} = ς(N_i(S')) · A_{S',U}（i ∈ S）、0（i ∉ S）。 -/
theorem entry_creationMatrix_mul (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (n : K) {M i : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (A : Mat K (PowerSet M))
    (S U : PowerSet M) :
    (i ∈ S.1 → Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) A) S U
        = sign n (countBelow (removeIndex S i) i) * Mat.entry A (removeIndex S i) U)
      ∧ (i ∉ S.1 → Mat.entry (Mat.mul L (isFiniteSet_powerSet M) (creationMatrix n M i hi) A) S U = 0) := by
  let V := coefficientsVec L
  let hX := isFiniteSet_powerSet M
  constructor
  · -- i ∈ S のとき。
    intro hiS
    let S' := removeIndex S i
    -- 準備：(c_i)_{S,T} = δ_{S',T} · ς(N_i(S'))
    have hc : ∀ T : PowerSet M,
        Mat.entry (creationMatrix n M i hi) S T = (kroneckerDelta S' T : K) * sign n (countBelow S' i) := by
      intro T
      by_cases hT : T = S'
      · calc Mat.entry (creationMatrix n M i hi) S T
            = sign n (countBelow T i) :=
              creationMatrix_entry_of_cond n hi ((unionSingleton_cond_iff_eq_removeIndex hi hiS T).2 hT)
          _ = sign n (countBelow S' i) := by rw [hT]
          _ = 1 * sign n (countBelow S' i) := (L.one_mul (sign n (countBelow S' i))).symm
          _ = (kroneckerDelta S' T : K) * sign n (countBelow S' i) := by
              rw [show (kroneckerDelta S' T : K) = (1 : K) from if_pos hT.symm]
      · calc Mat.entry (creationMatrix n M i hi) S T
            = 0 := creationMatrix_entry_of_not_cond n hi
                (fun h => hT ((unionSingleton_cond_iff_eq_removeIndex hi hiS T).1 h))
          _ = 0 * sign n (countBelow S' i) := (hzero_mul (sign n (countBelow S' i))).symm
          _ = (kroneckerDelta S' T : K) * sign n (countBelow S' i) := by
              rw [show (kroneckerDelta S' T : K) = (0 : K) from if_neg (fun h => hT h.symm)]
    -- 準備：r_T := ς(N_i(S')) · A_{T,U}
    let r : PowerSet M → K := fun T => sign n (countBelow S' i) * Mat.entry A T U
    -- 準備：(c_i)_{S,T} ·_{K^vec} A_{T,U} = δ_{S',T} ·_{K^vec} r_T
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (creationMatrix n M i hi) S T) (Mat.entry A T U)
          = V.smul (kroneckerDelta S' T) (r T) := fun T => calc
      V.smul (Mat.entry (creationMatrix n M i hi) S T) (Mat.entry A T U)
          = Mat.entry (creationMatrix n M i hi) S T * Mat.entry A T U := rfl
      _ = ((kroneckerDelta S' T : K) * sign n (countBelow S' i)) * Mat.entry A T U := by rw [hc T]
      _ = (kroneckerDelta S' T : K) * (sign n (countBelow S' i) * Mat.entry A T U) :=
          L.mul_assoc (kroneckerDelta S' T) (sign n (countBelow S' i)) (Mat.entry A T U)
      _ = (kroneckerDelta S' T : K) * r T := rfl
      _ = V.smul (kroneckerDelta S' T) (r T) := rfl
    calc Mat.entry (Mat.mul L hX (creationMatrix n M i hi) A) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix n M i hi) S T)
            (fun T => Mat.entry A T U) := rfl
      _ = sumOverFiniteSet V hX (fun T => (kroneckerDelta S' T : K)) r :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = r S' := sumOverFiniteSet_kroneckerDelta V (L.add_zero 0) hX r S'
      _ = sign n (countBelow S' i) * Mat.entry A S' U := rfl
  · -- i ∉ S のとき。S = T ∪ {i} なら i ∈ S なので、c_i の条件は成り立たない。
    intro hiS
    have hcond : ∀ T : PowerSet M, ¬(i ∉ T.1 ∧ S = unionSingleton T i hi) := by
      rintro T ⟨_, hS⟩
      apply hiS
      rw [hS]
      exact self_mem_unionSingleton T i hi
    have hterm : ∀ T : PowerSet M,
        V.smul (Mat.entry (creationMatrix n M i hi) S T) (Mat.entry A T U) = V.smul (0 * 1) 1 :=
      fun T => calc
      V.smul (Mat.entry (creationMatrix n M i hi) S T) (Mat.entry A T U)
          = Mat.entry (creationMatrix n M i hi) S T * Mat.entry A T U := rfl
      _ = 0 * Mat.entry A T U := by rw [creationMatrix_entry_of_not_cond n hi (hcond T)]
      _ = 0 := hzero_mul (Mat.entry A T U)
      _ = (0 * 1) * 1 := by rw [hzero_mul (1 : K), hzero_mul (1 : K)]
      _ = V.smul (0 * 1) 1 := rfl
    calc Mat.entry (Mat.mul L hX (creationMatrix n M i hi) A) S U
        = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix n M i hi) S T)
            (fun T => Mat.entry A T U) := rfl
      _ = sumOverFiniteSet V hX (fun _ => 0 * 1) (fun _ => 1) :=
          sumOverFiniteSet_congr V hX _ _ _ _ hterm
      _ = V.smul 0 (sumOverFiniteSet V hX (fun _ => 1) (fun _ => 1)) :=
          (smul_sumOverFiniteSet V (L.add_zero 0) hmul0 hX (fun _ => 1) (fun _ => 1) 0).symm
      _ = V.zero := zero_smul_eq_zero V (L.add_zero 0) _
      _ = 0 := rfl

end CliffordMatrixIsomorphism.NecSuf.Isomorphism
