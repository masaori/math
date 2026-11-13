/-
節「ℂ-線型空間」のうち線型結合についての七つの主張の必要十分版。具体版
`MathematicalToolkit/ComplexVectorSpace/LinearCombination.lean` と同じ帰納法と calc の行で書く。

各主張が実際に使う K の性質:

  linearCombination_add_of_same_family        なし（K の演算は公理 add_smul の中にしか現れない）
  smul_linearCombination                      0 + 0 = 0、a · 0 = 0
  linearCombination_eq_of_terms_eq            なし
  linearCombination_eq_zero_of_terms_eq_zero  なし
  linearCombination_add_of_same_coefficients  なし
  linearCombination_split                     なし
  coefficients_eq_of_linearCombination_eq     a + 0 = a、0 + a = a、加法の結合法則・交換法則、
                                              1 + n = 0 となる n の存在、1 · a = a、右分配法則、
                                              a · 0 = 0、0 · a = 0
                                              （乗法の結合法則・交換法則・左分配法則は使わない）
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v

variable {K : Type u} [Add K] [Mul K] [One K] [Zero K] {V : Type v}

omit [Zero K] in
/-- 本文 `claim_sum_of_linear_combinations_of_same_family` の帰納法の主張 L^λ_m +_V L^μ_m = L^{λ+μ}_m。 -/
theorem partialLinearCombination_add_of_same_family (S : VectorSpace K V) (b : ℕ → V)
    (c d : ℕ → K) (m : ℕ) :
    S.add (partialLinearCombination S c b m) (partialLinearCombination S d b m)
      = partialLinearCombination S (fun k => c k + d k) b m := by
  induction m with
  | zero => calc
      S.add (partialLinearCombination S c b 0) (partialLinearCombination S d b 0)
          = S.add S.zero S.zero := rfl
      _ = S.zero := by rw [S.add_zero S.zero]
      _ = partialLinearCombination S (fun k => c k + d k) b 0 := rfl
  | succ m ih => calc
      S.add (partialLinearCombination S c b (m + 1)) (partialLinearCombination S d b (m + 1))
          = S.add (S.add (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1))))
              (S.add (partialLinearCombination S d b m) (S.smul (d (m + 1)) (b (m + 1)))) := rfl
      _ = S.add (partialLinearCombination S c b m)
            (S.add (S.smul (c (m + 1)) (b (m + 1)))
              (S.add (partialLinearCombination S d b m) (S.smul (d (m + 1)) (b (m + 1))))) := by
            rw [S.add_assoc (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1)))
              (S.add (partialLinearCombination S d b m) (S.smul (d (m + 1)) (b (m + 1))))]
      _ = S.add (partialLinearCombination S c b m)
            (S.add (S.add (S.smul (c (m + 1)) (b (m + 1))) (partialLinearCombination S d b m))
              (S.smul (d (m + 1)) (b (m + 1)))) := by
            rw [S.add_assoc (S.smul (c (m + 1)) (b (m + 1))) (partialLinearCombination S d b m)
              (S.smul (d (m + 1)) (b (m + 1)))]
      _ = S.add (partialLinearCombination S c b m)
            (S.add (S.add (partialLinearCombination S d b m) (S.smul (c (m + 1)) (b (m + 1))))
              (S.smul (d (m + 1)) (b (m + 1)))) := by
            rw [S.add_comm (S.smul (c (m + 1)) (b (m + 1))) (partialLinearCombination S d b m)]
      _ = S.add (partialLinearCombination S c b m)
            (S.add (partialLinearCombination S d b m)
              (S.add (S.smul (c (m + 1)) (b (m + 1))) (S.smul (d (m + 1)) (b (m + 1))))) := by
            rw [S.add_assoc (partialLinearCombination S d b m) (S.smul (c (m + 1)) (b (m + 1)))
              (S.smul (d (m + 1)) (b (m + 1)))]
      _ = S.add (S.add (partialLinearCombination S c b m) (partialLinearCombination S d b m))
            (S.add (S.smul (c (m + 1)) (b (m + 1))) (S.smul (d (m + 1)) (b (m + 1)))) := by
            rw [S.add_assoc (partialLinearCombination S c b m) (partialLinearCombination S d b m)
              (S.add (S.smul (c (m + 1)) (b (m + 1))) (S.smul (d (m + 1)) (b (m + 1))))]
      _ = S.add (partialLinearCombination S (fun k => c k + d k) b m)
            (S.add (S.smul (c (m + 1)) (b (m + 1))) (S.smul (d (m + 1)) (b (m + 1)))) := by
            rw [ih]
      _ = S.add (partialLinearCombination S (fun k => c k + d k) b m)
            (S.smul (c (m + 1) + d (m + 1)) (b (m + 1))) := by
            rw [S.add_smul (c (m + 1)) (d (m + 1)) (b (m + 1))]
      _ = partialLinearCombination S (fun k => c k + d k) b (m + 1) := rfl

omit [Zero K] in
/-- 本文 `claim_sum_of_linear_combinations_of_same_family`：
(Σ λ_k ·_V b_k) +_V (Σ μ_k ·_V b_k) = Σ (λ_k +_ℂ μ_k) ·_V b_k。帰納法の m = n。 -/
theorem linearCombination_add_of_same_family (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (c d : ℕ → K) :
    S.add (linearCombination S n c b) (linearCombination S n d b)
      = linearCombination S n (fun k => c k + d k) b :=
  partialLinearCombination_add_of_same_family S b c d n

/-- 本文 `claim_scalar_multiple_of_linear_combination` の帰納法の主張 μ ·_V L^λ_m = L^{μλ}_m。 -/
theorem smul_partialLinearCombination (S : VectorSpace K V) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (b : ℕ → V) (c : ℕ → K) (μ : K) (m : ℕ) :
    S.smul μ (partialLinearCombination S c b m)
      = partialLinearCombination S (fun k => μ * c k) b m := by
  induction m with
  | zero => calc
      S.smul μ (partialLinearCombination S c b 0) = S.smul μ S.zero := rfl
      _ = S.smul μ (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S h00 S.zero]
      _ = S.smul (μ * 0) S.zero := by rw [S.smul_assoc μ 0 S.zero]
      _ = S.smul 0 S.zero := by rw [hmul0 μ]
      _ = S.zero := zero_smul_eq_zero S h00 S.zero
      _ = partialLinearCombination S (fun k => μ * c k) b 0 := rfl
  | succ m ih => calc
      S.smul μ (partialLinearCombination S c b (m + 1))
          = S.smul μ (S.add (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1)))) :=
            rfl
      _ = S.add (S.smul μ (partialLinearCombination S c b m))
            (S.smul μ (S.smul (c (m + 1)) (b (m + 1)))) := by
            rw [S.smul_add μ (partialLinearCombination S c b m) (S.smul (c (m + 1)) (b (m + 1)))]
      _ = S.add (partialLinearCombination S (fun k => μ * c k) b m)
            (S.smul μ (S.smul (c (m + 1)) (b (m + 1)))) := by rw [ih]
      _ = S.add (partialLinearCombination S (fun k => μ * c k) b m)
            (S.smul (μ * c (m + 1)) (b (m + 1))) := by
            rw [S.smul_assoc μ (c (m + 1)) (b (m + 1))]
      _ = partialLinearCombination S (fun k => μ * c k) b (m + 1) := rfl

/-- 本文 `claim_scalar_multiple_of_linear_combination`：μ ·_V (Σ λ_k ·_V b_k) = Σ (μ ·_ℂ λ_k) ·_V b_k。 -/
theorem smul_linearCombination (S : VectorSpace K V) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (n : ℕ) (b : ℕ → V) (c : ℕ → K) (μ : K) :
    S.smul μ (linearCombination S n c b) = linearCombination S n (fun k => μ * c k) b :=
  smul_partialLinearCombination S h00 hmul0 b c μ n

omit [Zero K] in
/-- 本文 `claim_linear_combinations_with_equal_terms_are_equal` の帰納法の主張 L^λ_m = L^μ_m（m ≤ n）。 -/
theorem partialLinearCombination_eq_of_terms_eq (S : VectorSpace K V) (n : ℕ)
    (x y : ℕ → V) (c d : ℕ → K)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.smul (d k) (y k)) :
    ∀ m : ℕ, m ≤ n → partialLinearCombination S c x m = partialLinearCombination S d y m := by
  intro m
  induction m with
  | zero => intro _; rfl
  | succ m ih =>
    intro hm
    calc partialLinearCombination S c x (m + 1)
        = S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1))) := rfl
      _ = S.add (partialLinearCombination S d y m) (S.smul (c (m + 1)) (x (m + 1))) := by
            rw [ih (Nat.le_of_succ_le hm)]
      _ = S.add (partialLinearCombination S d y m) (S.smul (d (m + 1)) (y (m + 1))) := by
            rw [h (m + 1) (Nat.succ_pos m) hm]
      _ = partialLinearCombination S d y (m + 1) := rfl

omit [Zero K] in
/-- 本文 `claim_linear_combinations_with_equal_terms_are_equal`。 -/
theorem linearCombination_eq_of_terms_eq (S : VectorSpace K V) (n : ℕ) (x y : ℕ → V)
    (c d : ℕ → K) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.smul (d k) (y k)) :
    linearCombination S n c x = linearCombination S n d y :=
  partialLinearCombination_eq_of_terms_eq S n x y c d h n le_rfl

omit [Zero K] in
/-- 本文 `claim_linear_combination_of_zero_terms_is_zero` の帰納法の主張 L_m = 0_V（m ≤ n）。 -/
theorem partialLinearCombination_eq_zero_of_terms_eq_zero (S : VectorSpace K V) (n : ℕ)
    (x : ℕ → V) (c : ℕ → K) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.zero) :
    ∀ m : ℕ, m ≤ n → partialLinearCombination S c x m = S.zero := by
  intro m
  induction m with
  | zero => intro _; rfl
  | succ m ih =>
    intro hm
    calc partialLinearCombination S c x (m + 1)
        = S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1))) := rfl
      _ = S.add S.zero (S.smul (c (m + 1)) (x (m + 1))) := by rw [ih (Nat.le_of_succ_le hm)]
      _ = S.add S.zero S.zero := by rw [h (m + 1) (Nat.succ_pos m) hm]
      _ = S.zero := by rw [S.add_zero S.zero]

omit [Zero K] in
/-- 本文 `claim_linear_combination_of_zero_terms_is_zero`。 -/
theorem linearCombination_eq_zero_of_terms_eq_zero (S : VectorSpace K V) (n : ℕ)
    (x : ℕ → V) (c : ℕ → K) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.zero) :
    linearCombination S n c x = S.zero :=
  partialLinearCombination_eq_zero_of_terms_eq_zero S n x c h n le_rfl

omit [Zero K] in
/-- 本文 `claim_sum_of_linear_combinations_with_same_coefficients` の帰納法の主張
L^x_m +_V L^y_m = L^{x+y}_m。 -/
theorem partialLinearCombination_add_of_same_coefficients (S : VectorSpace K V)
    (x y : ℕ → V) (c : ℕ → K) (m : ℕ) :
    S.add (partialLinearCombination S c x m) (partialLinearCombination S c y m)
      = partialLinearCombination S c (fun k => S.add (x k) (y k)) m := by
  induction m with
  | zero => calc
      S.add (partialLinearCombination S c x 0) (partialLinearCombination S c y 0)
          = S.add S.zero S.zero := rfl
      _ = S.zero := by rw [S.add_zero S.zero]
      _ = partialLinearCombination S c (fun k => S.add (x k) (y k)) 0 := rfl
  | succ m ih => calc
      S.add (partialLinearCombination S c x (m + 1)) (partialLinearCombination S c y (m + 1))
          = S.add (S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1))))
              (S.add (partialLinearCombination S c y m) (S.smul (c (m + 1)) (y (m + 1)))) := rfl
      _ = S.add (partialLinearCombination S c x m)
            (S.add (S.smul (c (m + 1)) (x (m + 1)))
              (S.add (partialLinearCombination S c y m) (S.smul (c (m + 1)) (y (m + 1))))) := by
            rw [S.add_assoc (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1)))
              (S.add (partialLinearCombination S c y m) (S.smul (c (m + 1)) (y (m + 1))))]
      _ = S.add (partialLinearCombination S c x m)
            (S.add (S.add (S.smul (c (m + 1)) (x (m + 1))) (partialLinearCombination S c y m))
              (S.smul (c (m + 1)) (y (m + 1)))) := by
            rw [S.add_assoc (S.smul (c (m + 1)) (x (m + 1))) (partialLinearCombination S c y m)
              (S.smul (c (m + 1)) (y (m + 1)))]
      _ = S.add (partialLinearCombination S c x m)
            (S.add (S.add (partialLinearCombination S c y m) (S.smul (c (m + 1)) (x (m + 1))))
              (S.smul (c (m + 1)) (y (m + 1)))) := by
            rw [S.add_comm (S.smul (c (m + 1)) (x (m + 1))) (partialLinearCombination S c y m)]
      _ = S.add (partialLinearCombination S c x m)
            (S.add (partialLinearCombination S c y m)
              (S.add (S.smul (c (m + 1)) (x (m + 1))) (S.smul (c (m + 1)) (y (m + 1))))) := by
            rw [S.add_assoc (partialLinearCombination S c y m) (S.smul (c (m + 1)) (x (m + 1)))
              (S.smul (c (m + 1)) (y (m + 1)))]
      _ = S.add (S.add (partialLinearCombination S c x m) (partialLinearCombination S c y m))
            (S.add (S.smul (c (m + 1)) (x (m + 1))) (S.smul (c (m + 1)) (y (m + 1)))) := by
            rw [S.add_assoc (partialLinearCombination S c x m) (partialLinearCombination S c y m)
              (S.add (S.smul (c (m + 1)) (x (m + 1))) (S.smul (c (m + 1)) (y (m + 1))))]
      _ = S.add (partialLinearCombination S c (fun k => S.add (x k) (y k)) m)
            (S.add (S.smul (c (m + 1)) (x (m + 1))) (S.smul (c (m + 1)) (y (m + 1)))) := by
            rw [ih]
      _ = S.add (partialLinearCombination S c (fun k => S.add (x k) (y k)) m)
            (S.smul (c (m + 1)) (S.add (x (m + 1)) (y (m + 1)))) := by
            rw [S.smul_add (c (m + 1)) (x (m + 1)) (y (m + 1))]
      _ = partialLinearCombination S c (fun k => S.add (x k) (y k)) (m + 1) := rfl

omit [Zero K] in
/-- 本文 `claim_sum_of_linear_combinations_with_same_coefficients`：
(Σ λ_k ·_V x_k) +_V (Σ λ_k ·_V y_k) = Σ λ_k ·_V (x_k +_V y_k)。 -/
theorem linearCombination_add_of_same_coefficients (S : VectorSpace K V) (n : ℕ)
    (x y : ℕ → V) (c : ℕ → K) :
    S.add (linearCombination S n c x) (linearCombination S n c y)
      = linearCombination S n c (fun k => S.add (x k) (y k)) :=
  partialLinearCombination_add_of_same_coefficients S x y c n

omit [Zero K] in
/-- 本文 `claim_splitting_linear_combination_into_first_and_last_terms` の帰納法の主張
L_{n+m} = L_n +_V L'_m（L' は x_{n+j}・λ_{n+j} の族の部分和）。 -/
theorem partialLinearCombination_split (S : VectorSpace K V) (n : ℕ) (x : ℕ → V)
    (c : ℕ → K) (m : ℕ) :
    partialLinearCombination S c x (n + m)
      = S.add (partialLinearCombination S c x n)
          (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) m) := by
  induction m with
  | zero => calc
      partialLinearCombination S c x (n + 0) = partialLinearCombination S c x n := rfl
      _ = S.add (partialLinearCombination S c x n) S.zero := by
            rw [S.add_zero (partialLinearCombination S c x n)]
      _ = S.add (partialLinearCombination S c x n)
            (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) 0) := rfl
  | succ m ih => calc
      partialLinearCombination S c x (n + (m + 1))
          = S.add (partialLinearCombination S c x (n + m))
              (S.smul (c (n + (m + 1))) (x (n + (m + 1)))) := rfl
      _ = S.add (S.add (partialLinearCombination S c x n)
              (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) m))
            (S.smul (c (n + (m + 1))) (x (n + (m + 1)))) := by rw [ih]
      _ = S.add (partialLinearCombination S c x n)
            (S.add (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) m)
              (S.smul (c (n + (m + 1))) (x (n + (m + 1))))) := by
            rw [S.add_assoc (partialLinearCombination S c x n)
              (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) m)
              (S.smul (c (n + (m + 1))) (x (n + (m + 1))))]
      _ = S.add (partialLinearCombination S c x n)
            (partialLinearCombination S (fun j => c (n + j)) (fun j => x (n + j)) (m + 1)) := rfl

omit [Zero K] in
/-- 本文 `claim_splitting_linear_combination_into_first_and_last_terms`：
Σ_{k=1}^{n+n'} λ_k ·_V x_k = (Σ_{k=1}^{n} λ_k ·_V x_k) +_V (Σ_{j=1}^{n'} λ_{n+j} ·_V x_{n+j})。 -/
theorem linearCombination_split (S : VectorSpace K V) (n n' : ℕ) (x : ℕ → V) (c : ℕ → K) :
    linearCombination S (n + n') c x
      = S.add (linearCombination S n c x)
          (linearCombination S n' (fun j => c (n + j)) (fun j => x (n + j))) :=
  partialLinearCombination_split S n x c n'

/-- 本文 `claim_uniqueness_of_coefficients_of_linear_combination` の必要十分版。
-1 は `hneg` が与える n（1 + n = 0）で置き換える。0 + 0 = 0 は `hadd_zero 0` から得る。
`hzero_add` は `hcomm` と `hadd_zero` から従うが、本文の行（0_ℂ +_ℂ μ_k = μ_k）をそのまま当てるため仮定に置く。 -/
theorem coefficients_eq_of_linearCombination_eq (S : VectorSpace K V)
    (hadd_zero : ∀ a : K, a + 0 = a) (hzero_add : ∀ a : K, 0 + a = a)
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hcomm : ∀ a b : K, a + b = b + a)
    (hneg : ∃ n : K, 1 + n = 0) (hone_mul : ∀ a : K, 1 * a = a)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c)
    (hmul0 : ∀ a : K, a * 0 = 0) (hzero_mul : ∀ a : K, 0 * a = 0)
    (n : ℕ) (b : ℕ → V) (hb : IsLinearlyIndependentFamily S n b) (c d : ℕ → K)
    (h : linearCombination S n c b = linearCombination S n d b) :
    ∀ k : ℕ, 1 ≤ k → k ≤ n → c k = d k := by
  have h00 : (0 : K) + 0 = 0 := hadd_zero 0
  obtain ⟨e, he⟩ := hneg
  have hν : linearCombination S n (fun k => c k + e * d k) b = S.zero := calc
    linearCombination S n (fun k => c k + e * d k) b
        = S.add (linearCombination S n c b) (linearCombination S n (fun k => e * d k) b) :=
          (linearCombination_add_of_same_family S n b c (fun k => e * d k)).symm
    _ = S.add (linearCombination S n c b) (S.smul e (linearCombination S n d b)) := by
          rw [smul_linearCombination S h00 hmul0 n b d e]
    _ = S.add (linearCombination S n d b) (S.smul e (linearCombination S n d b)) := by
          rw [h]
    _ = S.add (S.smul 1 (linearCombination S n d b)) (S.smul e (linearCombination S n d b)) := by
          rw [S.one_smul (linearCombination S n d b)]
    _ = S.smul (1 + e) (linearCombination S n d b) := by
          rw [S.add_smul 1 e (linearCombination S n d b)]
    _ = S.smul 0 (linearCombination S n d b) := by rw [he]
    _ = S.zero := zero_smul_eq_zero S h00 (linearCombination S n d b)
  intro k hk1 hkn
  have hνk : c k + e * d k = 0 := hb (fun k => c k + e * d k) hν k hk1 hkn
  symm
  calc d k = 0 + d k := by rw [hzero_add (d k)]
    _ = (c k + e * d k) + d k := by rw [hνk]
    _ = c k + (e * d k + d k) := by rw [hassoc (c k) (e * d k) (d k)]
    _ = c k + (e * d k + 1 * d k) := by rw [hone_mul (d k)]
    _ = c k + ((e + 1) * d k) := by rw [hrdistrib e 1 (d k)]
    _ = c k + ((1 + e) * d k) := by rw [hcomm e 1]
    _ = c k + (0 * d k) := by rw [he]
    _ = c k + 0 := by rw [hzero_mul (d k)]
    _ = c k := by rw [hadd_zero (c k)]

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
