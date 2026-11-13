/-
節「ℂ-線型空間」のうち線型結合についての七つの主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  claim_sum_of_linear_combinations_of_same_family               linearCombination_add_of_same_family
  claim_scalar_multiple_of_linear_combination                   smul_linearCombination
  claim_linear_combinations_with_equal_terms_are_equal          linearCombination_eq_of_terms_eq
  claim_linear_combination_of_zero_terms_is_zero                linearCombination_eq_zero_of_terms_eq_zero
  claim_sum_of_linear_combinations_with_same_coefficients       linearCombination_add_of_same_coefficients
  claim_splitting_linear_combination_into_first_and_last_terms  linearCombination_split
  claim_uniqueness_of_coefficients_of_linear_combination        coefficients_eq_of_linearCombination_eq

本文の m についての帰納法は、部分和 L_m（`partialLinearCombination`）についての `induction` で書く。
本文は m ∈ {0,…,n} について示すが、L_m は m > n でも同じ式で定まり、示す等式もそのまま成り立つので、
「項が等しい」「項が零」の二つ（仮定が 1,…,n の項にしか無いもの）を除き、m の範囲を制限しない。

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/LinearCombination.lean`、導出版は `ComplexVectorSpaceFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `claim_sum_of_linear_combinations_of_same_family` の帰納法の主張 L^λ_m +_V L^μ_m = L^{λ+μ}_m。 -/
theorem partialLinearCombination_add_of_same_family (S : ComplexVectorSpace V) (b : ℕ → V)
    (c d : ℕ → ℂ) (m : ℕ) :
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

/-- 本文 `claim_sum_of_linear_combinations_of_same_family`：
(Σ λ_k ·_V b_k) +_V (Σ μ_k ·_V b_k) = Σ (λ_k +_ℂ μ_k) ·_V b_k。帰納法の m = n。 -/
theorem linearCombination_add_of_same_family (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (c d : ℕ → ℂ) :
    S.add (linearCombination S n c b) (linearCombination S n d b)
      = linearCombination S n (fun k => c k + d k) b :=
  partialLinearCombination_add_of_same_family S b c d n

/-- 本文 `claim_scalar_multiple_of_linear_combination` の帰納法の主張 μ ·_V L^λ_m = L^{μλ}_m。 -/
theorem smul_partialLinearCombination (S : ComplexVectorSpace V) (b : ℕ → V) (c : ℕ → ℂ)
    (μ : ℂ) (m : ℕ) :
    S.smul μ (partialLinearCombination S c b m)
      = partialLinearCombination S (fun k => μ * c k) b m := by
  induction m with
  | zero => calc
      S.smul μ (partialLinearCombination S c b 0) = S.smul μ S.zero := rfl
      _ = S.smul μ (S.smul 0 S.zero) := by rw [zero_smul_eq_zero S S.zero]
      _ = S.smul (μ * 0) S.zero := by rw [S.smul_assoc μ 0 S.zero]
      _ = S.smul 0 S.zero := by rw [mul_zero μ]
      _ = S.zero := zero_smul_eq_zero S S.zero
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
theorem smul_linearCombination (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) (c : ℕ → ℂ)
    (μ : ℂ) :
    S.smul μ (linearCombination S n c b) = linearCombination S n (fun k => μ * c k) b :=
  smul_partialLinearCombination S b c μ n

/-- 本文 `claim_linear_combinations_with_equal_terms_are_equal` の帰納法の主張 L^λ_m = L^μ_m（m ≤ n）。 -/
theorem partialLinearCombination_eq_of_terms_eq (S : ComplexVectorSpace V) (n : ℕ)
    (x y : ℕ → V) (c d : ℕ → ℂ)
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

/-- 本文 `claim_linear_combinations_with_equal_terms_are_equal`。 -/
theorem linearCombination_eq_of_terms_eq (S : ComplexVectorSpace V) (n : ℕ) (x y : ℕ → V)
    (c d : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.smul (d k) (y k)) :
    linearCombination S n c x = linearCombination S n d y :=
  partialLinearCombination_eq_of_terms_eq S n x y c d h n le_rfl

/-- 本文 `claim_linear_combination_of_zero_terms_is_zero` の帰納法の主張 L_m = 0_V（m ≤ n）。 -/
theorem partialLinearCombination_eq_zero_of_terms_eq_zero (S : ComplexVectorSpace V) (n : ℕ)
    (x : ℕ → V) (c : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.zero) :
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

/-- 本文 `claim_linear_combination_of_zero_terms_is_zero`。 -/
theorem linearCombination_eq_zero_of_terms_eq_zero (S : ComplexVectorSpace V) (n : ℕ)
    (x : ℕ → V) (c : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.zero) :
    linearCombination S n c x = S.zero :=
  partialLinearCombination_eq_zero_of_terms_eq_zero S n x c h n le_rfl

/-- 本文 `claim_sum_of_linear_combinations_with_same_coefficients` の帰納法の主張
L^x_m +_V L^y_m = L^{x+y}_m。 -/
theorem partialLinearCombination_add_of_same_coefficients (S : ComplexVectorSpace V)
    (x y : ℕ → V) (c : ℕ → ℂ) (m : ℕ) :
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

/-- 本文 `claim_sum_of_linear_combinations_with_same_coefficients`：
(Σ λ_k ·_V x_k) +_V (Σ λ_k ·_V y_k) = Σ λ_k ·_V (x_k +_V y_k)。 -/
theorem linearCombination_add_of_same_coefficients (S : ComplexVectorSpace V) (n : ℕ)
    (x y : ℕ → V) (c : ℕ → ℂ) :
    S.add (linearCombination S n c x) (linearCombination S n c y)
      = linearCombination S n c (fun k => S.add (x k) (y k)) :=
  partialLinearCombination_add_of_same_coefficients S x y c n

/-- 本文 `claim_splitting_linear_combination_into_first_and_last_terms` の帰納法の主張
L_{n+m} = L_n +_V L'_m（L' は x_{n+j}・λ_{n+j} の族の部分和）。 -/
theorem partialLinearCombination_split (S : ComplexVectorSpace V) (n : ℕ) (x : ℕ → V)
    (c : ℕ → ℂ) (m : ℕ) :
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

/-- 本文 `claim_splitting_linear_combination_into_first_and_last_terms`：
Σ_{k=1}^{n+n'} λ_k ·_V x_k = (Σ_{k=1}^{n} λ_k ·_V x_k) +_V (Σ_{j=1}^{n'} λ_{n+j} ·_V x_{n+j})。 -/
theorem linearCombination_split (S : ComplexVectorSpace V) (n n' : ℕ) (x : ℕ → V) (c : ℕ → ℂ) :
    linearCombination S (n + n') c x
      = S.add (linearCombination S n c x)
          (linearCombination S n' (fun j => c (n + j)) (fun j => x (n + j))) :=
  partialLinearCombination_split S n x c n'

/-- 本文 `claim_uniqueness_of_coefficients_of_linear_combination`：一次独立な族 b について
Σ λ_k ·_V b_k = Σ μ_k ·_V b_k なら λ_k = μ_k（1 ≤ k ≤ n）。
ν_k := λ_k +_ℂ ((-1_ℂ) ·_ℂ μ_k) の線型結合が 0_V であることを示し、一次独立から ν_k = 0_ℂ を得る。 -/
theorem coefficients_eq_of_linearCombination_eq (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsLinearlyIndependentFamily S n b) (c d : ℕ → ℂ)
    (h : linearCombination S n c b = linearCombination S n d b) :
    ∀ k : ℕ, 1 ≤ k → k ≤ n → c k = d k := by
  have hν : linearCombination S n (fun k => c k + (-1) * d k) b = S.zero := calc
    linearCombination S n (fun k => c k + (-1) * d k) b
        = S.add (linearCombination S n c b) (linearCombination S n (fun k => (-1) * d k) b) :=
          (linearCombination_add_of_same_family S n b c (fun k => (-1) * d k)).symm
    _ = S.add (linearCombination S n c b) (S.smul (-1) (linearCombination S n d b)) := by
          rw [smul_linearCombination S n b d (-1)]
    _ = S.add (linearCombination S n d b) (S.smul (-1) (linearCombination S n d b)) := by
          rw [h]
    _ = S.add (S.smul 1 (linearCombination S n d b)) (S.smul (-1) (linearCombination S n d b)) := by
          rw [S.one_smul (linearCombination S n d b)]
    _ = S.smul (1 + (-1)) (linearCombination S n d b) := by
          rw [S.add_smul 1 (-1) (linearCombination S n d b)]
    _ = S.smul 0 (linearCombination S n d b) := by rw [add_neg_cancel (1 : ℂ)]
    _ = S.zero := zero_smul_eq_zero S (linearCombination S n d b)
  intro k hk1 hkn
  have hνk : c k + (-1) * d k = 0 := hb (fun k => c k + (-1) * d k) hν k hk1 hkn
  symm
  calc d k = 0 + d k := by rw [zero_add (d k)]
    _ = (c k + (-1) * d k) + d k := by rw [hνk]
    _ = c k + ((-1) * d k + d k) := by rw [_root_.add_assoc (c k) ((-1) * d k) (d k)]
    _ = c k + ((-1) * d k + 1 * d k) := by rw [one_mul (d k)]
    _ = c k + ((-1 + 1) * d k) := by rw [add_mul (-1 : ℂ) 1 (d k)]
    _ = c k + ((1 + (-1)) * d k) := by rw [_root_.add_comm (-1 : ℂ) 1]
    _ = c k + (0 * d k) := by rw [add_neg_cancel (1 : ℂ)]
    _ = c k + 0 := by rw [zero_mul (d k)]
    _ = c k := by rw [_root_.add_zero (c k)]

end CliffordMatrixIsomorphism.ComplexVectorSpace
