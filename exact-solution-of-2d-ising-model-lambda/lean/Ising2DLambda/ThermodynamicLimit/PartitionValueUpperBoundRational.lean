/-
人手証明「正の有理点での分配多項式の値の上からの評価」（`claim_partition_value_upper_bound_at_positive_rational`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `Z_L(q) ≤ 2^{L²}·(1+q)^{2L²}`。
準備の第一: 正の有理数の冪は正（`pow_pos_by_induction`。指数についての帰納法）。
準備の第二: 底の単調性 `0 < u ≤ v → u^k ≤ v^k`（`pow_le_pow_of_pos_of_le_by_induction_rat`。指数についての帰納法）。
準備の第三: 指数の単調性 `1 ≤ w → m ≤ n → w^m ≤ w^n`（`one_le_pow_by_induction_rat`・`pow_le_pow_of_one_le_of_exp_le_by_induction_rat`）。
準備の第四: 定数の有限和 `Σ_{s∈S} c = |S|·c`（`Finset.sum_const` と `card_config`）。
式変形は人手証明と同じ五段:
  Z_L(q) = Σ_σ q^{b(σ)}                （代入は環準同型。`eval_partitionPolynomial`）
        ≤ Σ_σ (1+q)^{b(σ)}             （底を 1+q へ上げる。準備の第二）
        ≤ Σ_σ (1+q)^{2L²}              （指数を 2L² へ上げる。`brokenBondCount_le` と準備の第三）
        = |Σ_L|·(1+q)^{2L²}            （定数の有限和。準備の第四）
        = 2^{L²}·(1+q)^{2L²}           （`card_config`）
住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.NecSuf.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial FreeEntropy NecSuf.ThermodynamicLimit

/-- 準備の第二: 正の底を大きくすると自然数冪は減らない。人手証明どおり指数について帰納する。 -/
lemma pow_le_pow_of_pos_of_le_by_induction_rat {u v : ℚ} (hu : 0 < u) (huv : u ≤ v) :
    ∀ k : ℕ, u ^ k ≤ v ^ k
  | 0 => by rw [pow_zero, pow_zero]                              -- 両辺とも 1
  | k + 1 => by
      rw [pow_succ, pow_succ]
      -- u^k·u ≤ v^k·u（帰納法の仮定と 0 < u）、v^k·u ≤ v^k·v（u ≤ v と 0 < v^k）
      exact mul_le_mul (pow_le_pow_of_pos_of_le_by_induction_rat hu huv k) huv hu.le
        (pow_pos_by_induction (lt_of_lt_of_le hu huv) k).le

/-- 準備の第三の前半: 一以上の底の自然数冪は一以上である。指数について帰納する。 -/
lemma one_le_pow_by_induction_rat {w : ℚ} (hw : 1 ≤ w) : ∀ k : ℕ, 1 ≤ w ^ k
  | 0 => by rw [pow_zero]                                        -- w^0 = 1
  | k + 1 => by
      rw [pow_succ]
      -- 1 = 1·1 ≤ w^k·1 ≤ w^k·w
      calc
        (1 : ℚ) = 1 * 1 := (mul_one 1).symm
        _ ≤ w ^ k * 1 := by
          rw [mul_one, mul_one]; exact one_le_pow_by_induction_rat hw k
        _ ≤ w ^ k * w :=
          mul_le_mul_of_nonneg_left hw
            (pow_pos_by_induction (lt_of_lt_of_le zero_lt_one hw) k).le

/-- 準備の第三の後半: 一以上の底では指数を大きくすると冪は減らない。 -/
lemma pow_le_pow_of_one_le_of_exp_le_by_induction_rat {w : ℚ} (hw : 1 ≤ w) :
    ∀ {m n : ℕ}, m ≤ n → w ^ m ≤ w ^ n := by
  intro m n hmn
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn                 -- n = m + d
  calc
    w ^ m = w ^ m * 1 := (mul_one _).symm
    _ ≤ w ^ m * w ^ d :=
      mul_le_mul_of_nonneg_left (one_le_pow_by_induction_rat hw d)
        (pow_pos_by_induction (lt_of_lt_of_le zero_lt_one hw) m).le
    _ = w ^ (m + d) := (pow_add w m d).symm                        -- 冪の指数法則

/-- `claim_partition_value_upper_bound_at_positive_rational`。人手証明の五段の鎖を同じ順序で辿る。 -/
theorem partitionPolynomial_eval_rat_le_upperBound (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    Polynomial.aeval q (partitionPolynomial L) ≤
      ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
  have hqBase : q ≤ 1 + q := by linarith                          -- 0 < 1 を q へ足す
  have hOneBase : 1 ≤ 1 + q := by linarith                        -- 0 < q を 1 へ足す
  rw [eval_partitionPolynomial L q]                               -- 代入は環準同型
  calc
    ∑ σ : Config L, q ^ brokenBondCount L σ
        ≤ ∑ σ : Config L, (1 + q) ^ brokenBondCount L σ := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_pos_of_le_by_induction_rat hq hqBase _  -- 底を 1+q へ上げる
    _ ≤ ∑ _σ : Config L, (1 + q) ^ (2 * L ^ 2) := by
          exact sum_le_sum fun σ _ =>
            pow_le_pow_of_one_le_of_exp_le_by_induction_rat hOneBase
              (brokenBondCount_le L σ)                            -- 指数を 2L² へ上げる
    _ = ((2 ^ L ^ 2 : ℕ) : ℚ) * (1 + q) ^ (2 * L ^ 2) := by
          rw [sum_const, card_univ, card_config, nsmul_eq_mul]    -- 定数の有限和・|Σ_L| = 2^{L²}

end Ising2DLambda.ThermodynamicLimit
