/-
章「同型の証明」の、非負整数の偶奇による符号 ς(n) ∈ ℂ と、その自分自身との積が 1 であることの具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                         このファイル
  def_sign_of_nonnegative_integer                      sign・sign_zero・sign_succ
  claim_sign_of_nonnegative_integer_squares_to_one     neg_one_mul_neg_one_add_neg_one・neg_one_mul_neg_one・
                                                       sign_mul_self

表し方: n ∈ ℤ_{≥0} は ℕ の元 n で表し、本文の段 n ∈ ℤ_{≥1} は n + 1（n - 1 は n）と書く。
-1_ℂ は ℂ の `-1`（1 + (-1) = 0 は `add_neg_cancel`）。

必要十分版は `NecSuf/Isomorphism/CreationOperatorMatrices/Sign.lean`、導出版は `CountAndSignFromNecSuf.lean`。
-/
import Mathlib.Data.Complex.Basic

namespace CliffordMatrixIsomorphism.Isomorphism

/-- 本文 `def_sign_of_nonnegative_integer`：ς(0) := 1_ℂ、n ∈ ℤ_{≥1} で ς(n) := (-1_ℂ) ·_ℂ ς(n-1)。 -/
def sign : ℕ → ℂ
  | 0 => 1
  | n + 1 => (-1) * sign n

/-- 本文 `def_sign_of_nonnegative_integer`：ς(0) = 1_ℂ。 -/
theorem sign_zero : sign 0 = 1 := rfl

/-- 本文 `def_sign_of_nonnegative_integer`：ς(n + 1) = (-1_ℂ) ·_ℂ ς(n)。 -/
theorem sign_succ (n : ℕ) : sign (n + 1) = (-1) * sign n := rfl

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の準備の一つ目：
(-1_ℂ)(-1_ℂ) + (-1_ℂ) = 0_ℂ。 -/
theorem neg_one_mul_neg_one_add_neg_one : (-1 : ℂ) * (-1) + (-1) = 0 :=
  calc (-1 : ℂ) * (-1) + (-1)
      = (-1) * (-1) + (-1) * 1 := by rw [mul_one (-1 : ℂ)]
    _ = (-1) * ((-1) + 1) := by rw [← mul_add (-1 : ℂ) (-1) 1]
    _ = (-1) * (1 + (-1)) := by rw [add_comm (-1 : ℂ) 1]
    _ = (-1) * 0 := by rw [add_neg_cancel (1 : ℂ)]
    _ = 0 := mul_zero (-1 : ℂ)

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one` の準備の二つ目：(-1_ℂ)(-1_ℂ) = 1_ℂ。 -/
theorem neg_one_mul_neg_one : (-1 : ℂ) * (-1) = 1 :=
  calc (-1 : ℂ) * (-1)
      = (-1) * (-1) + 0 := (add_zero ((-1 : ℂ) * (-1))).symm
    _ = (-1) * (-1) + (1 + (-1)) := by rw [add_neg_cancel (1 : ℂ)]
    _ = (-1) * (-1) + ((-1) + 1) := by rw [add_comm (1 : ℂ) (-1)]
    _ = ((-1) * (-1) + (-1)) + 1 := (add_assoc ((-1 : ℂ) * (-1)) (-1) 1).symm
    _ = 0 + 1 := by rw [neg_one_mul_neg_one_add_neg_one]
    _ = 1 := zero_add (1 : ℂ)

/-- 本文 `claim_sign_of_nonnegative_integer_squares_to_one`：すべての n ∈ ℤ_{≥0} で ς(n) ·_ℂ ς(n) = 1_ℂ。 -/
theorem sign_mul_self (n : ℕ) : sign n * sign n = 1 := by
  induction n with
  | zero =>
    calc sign 0 * sign 0
        = 1 * 1 := rfl
      _ = 1 := mul_one (1 : ℂ)
  | succ n ih =>
    calc sign (n + 1) * sign (n + 1)
        = ((-1) * sign n) * ((-1) * sign n) := rfl
      _ = (-1) * (sign n * ((-1) * sign n)) := mul_assoc (-1) (sign n) ((-1) * sign n)
      _ = (-1) * ((sign n * (-1)) * sign n) := by rw [← mul_assoc (sign n) (-1) (sign n)]
      _ = (-1) * (((-1) * sign n) * sign n) := by rw [mul_comm (sign n) (-1)]
      _ = (-1) * ((-1) * (sign n * sign n)) := by rw [mul_assoc (-1) (sign n) (sign n)]
      _ = ((-1) * (-1)) * (sign n * sign n) := (mul_assoc (-1) (-1) (sign n * sign n)).symm
      _ = 1 * (sign n * sign n) := by rw [neg_one_mul_neg_one]
      _ = 1 * 1 := by rw [ih]
      _ = 1 := mul_one (1 : ℂ)

end CliffordMatrixIsomorphism.Isomorphism
