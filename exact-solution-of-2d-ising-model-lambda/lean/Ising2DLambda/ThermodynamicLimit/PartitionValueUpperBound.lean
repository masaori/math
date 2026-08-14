/-
人手証明「正の実数での分配多項式の値の上からの評価」の具体版。

各項の底を `t` から `1 + t` へ上げ、破れボンド数を `2L²` で上から抑え、
最後に定数の有限和を配位数との積へ直す。実対数・完備性・極限は使わない。
-/
import Ising2DLambda.ThermodynamicLimit.FreeEnergyDensityLowerBound

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial

/-- 正の底を大きくすると自然数冪は減らない。人手証明どおり指数について帰納する。 -/
lemma pow_le_pow_of_pos_of_le_by_induction {u v : ℝ} (hu : 0 < u) (huv : u ≤ v) :
    ∀ k : ℕ, u ^ k ≤ v ^ k
  | 0 => le_rfl
  | k + 1 => by
      rw [pow_succ, pow_succ]
      exact mul_le_mul (pow_le_pow_of_pos_of_le_by_induction hu huv k) huv hu.le
        (pow_pos_by_induction (lt_of_lt_of_le hu huv) k).le

/-- 一以上の底の自然数冪は一以上である。人手証明どおり指数について帰納する。 -/
lemma one_le_pow_by_induction {w : ℝ} (hw : 1 ≤ w) : ∀ k : ℕ, 1 ≤ w ^ k
  | 0 => le_rfl
  | k + 1 => by
      rw [pow_succ]
      nlinarith [one_le_pow_by_induction hw k]

/-- 一以上の底では指数を大きくすると冪は減らない。 -/
lemma pow_le_pow_of_one_le_of_exp_le_by_induction {w : ℝ} (hw : 1 ≤ w) :
    ∀ {m n : ℕ}, m ≤ n → w ^ m ≤ w ^ n := by
  intro m n hmn
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn
  calc
    w ^ m = w ^ m * 1 := (mul_one _).symm
    _ ≤ w ^ m * w ^ d :=
      mul_le_mul_of_nonneg_left (one_le_pow_by_induction hw d)
        (pow_nonneg (zero_le_one.trans hw) _)
    _ = w ^ (m + d) := (pow_add w m d).symm

/-- `claim_partition_value_upper_bound`。人手証明の五段の鎖を同じ順序で辿る。 -/
theorem partitionPolynomial_eval_real_le_upperBound
    (L : PositiveNatural) [NeZero L.1] (t : StrictlyPositiveReal) :
    Polynomial.aeval t.1 (partitionPolynomial L.1) ≤
      ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
  have htBase : t.1 ≤ 1 + t.1 := by linarith
  have hOneBase : 1 ≤ 1 + t.1 := by nlinarith [t.2]
  rw [eval_partitionPolynomial_real L.1 t.1]
  calc
    ∑ σ : Config L.1, t.1 ^ brokenBondCount L.1 σ
        ≤ ∑ σ : Config L.1, (1 + t.1) ^ brokenBondCount L.1 σ := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_pos_of_le_by_induction t.2 htBase _
    _ ≤ ∑ _σ : Config L.1, (1 + t.1) ^ (2 * L.1 ^ 2) := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_one_le_of_exp_le_by_induction hOneBase (brokenBondCount_le L.1 σ)
    _ = ((2 ^ L.1 ^ 2 : ℕ) : ℝ) * (1 + t.1) ^ (2 * L.1 ^ 2) := by
          rw [sum_const, card_univ, card_config, nsmul_eq_mul]

end Ising2DLambda.ThermodynamicLimit
