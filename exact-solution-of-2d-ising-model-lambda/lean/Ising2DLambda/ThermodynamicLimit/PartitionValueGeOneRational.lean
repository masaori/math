/-
人手証明「正の有理点での分配多項式の値は 1 以上である」（`claim_partition_value_ge_one_at_positive_rational`）の具体版。

`L ≥ 1`、`q ∈ ℚ_{>0}` について `1 ≤ Z_L(q)`。
準備: 各配位で `0 < q^{b(σ)}`（正の有理数の冪は正。`claim_value_at_rational_is_positive` の具体版と同じ `pow_pos`）、`σ₊ ∈ Σ_L`。
式変形は人手証明と同じ五段:
  1 = q^0                                        （冪の指数 0 の約束）
    = q^{b(σ₊)}                                  （`allPlusConfig_brokenBondCount_eq_zero`）
    ≤ q^{b(σ₊)} + Σ_{σ≠σ₊} q^{b(σ)}                （加えた和は 0 以上）
    = Σ_σ q^{b(σ)}                                （分離した 1 項を有限和へ戻す）
    = Z_L(q)                                     （代入は環準同型。`eval_partitionPolynomial`）
住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.ThermodynamicLimit.ConstantPlusConfiguration

namespace Ising2DLambda.ThermodynamicLimit

open Finset PartitionPolynomial FreeEntropy

/-- `claim_partition_value_ge_one_at_positive_rational`。 -/
theorem one_le_partitionPolynomial_eval_rat (L : ℕ) [NeZero L] {q : ℚ} (hq : 0 < q) :
    1 ≤ Polynomial.aeval q (partitionPolynomial L) := by
  let σplus : Config L := allPlusConfig L
  have hσplus : σplus ∈ (univ : Finset (Config L)) := mem_univ σplus     -- σ₊ ∈ Σ_L
  have hbreaks : brokenBondCount L σplus = 0 :=
    allPlusConfig_brokenBondCount_eq_zero L                              -- b(σ₊) = 0
  -- 準備: 加えた和は正の有理数の有限和なので 0 以上
  have hrest : 0 ≤ ∑ σ ∈ (univ : Finset (Config L)).erase σplus, q ^ brokenBondCount L σ :=
    sum_nonneg fun σ _ => (pow_pos hq _).le
  calc
    1 = q ^ 0 := (pow_zero q).symm                                        -- 冪の指数 0 の約束
    _ = q ^ brokenBondCount L σplus := by rw [hbreaks]                    -- b(σ₊) = 0
    _ ≤ q ^ brokenBondCount L σplus +
        ∑ σ ∈ (univ : Finset (Config L)).erase σplus, q ^ brokenBondCount L σ :=
          le_add_of_nonneg_right hrest                                    -- 加えた和は 0 以上
    _ = ∑ σ : Config L, q ^ brokenBondCount L σ := by
          rw [add_comm, sum_erase_add _ _ hσplus]                         -- 1 項を有限和へ戻す
    _ = Polynomial.aeval q (partitionPolynomial L) :=
          (eval_partitionPolynomial L q).symm                             -- 代入は環準同型

end Ising2DLambda.ThermodynamicLimit
