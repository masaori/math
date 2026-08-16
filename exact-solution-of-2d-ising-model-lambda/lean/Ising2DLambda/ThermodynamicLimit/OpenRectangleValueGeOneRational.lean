/-
章「熱力学極限」の「開境界長方形の正の有理点での値は 1 以上である」
（`claim_open_rectangle_value_ge_one_at_positive_rational`）の具体版（人手証明と 1 対 1 に対応させる）。

`a, b ≥ 1`、`q ∈ ℚ_{>0}` について `1 ≤ Z^op_{a,b}(q)`。
準備: 各配位で `0 < q^{b^op(σ)}`（正の有理数の冪は正。`claim_open_rectangle_value_at_rational_is_positive`
の具体版と同じ `pow_pos`）、`τ_+ ∈ Σ^op_{a,b}`。
式変形は人手証明と同じ五段:
  1 = q^0                                          （冪の指数 0 の約束）
    = q^{b^op(τ_+)}                                 （`openAllPlusConfig_openBrokenBondCount_eq_zero`）
    ≤ q^{b^op(τ_+)} + Σ_{σ≠τ_+} q^{b^op(σ)}           （加えた和は 0 以上）
    = Σ_σ q^{b^op(σ)}                                （分離した 1 項を有限和へ戻す）
    = Z^op_{a,b}(q)                                 （代入は環準同型。`openPartitionValueRat_eq_sum`）
住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。周期境界の `one_le_partitionPolynomial_eval_rat`
（`PartitionValueGeOneRational.lean`）と同じ形。実数側の `one_le_openPartitionValue`
（`OpenRectangleValueAtLeastOne.lean`）はこの実数側の像であり、旧経路の撤去まで併存させる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectanglePartitionValueRational
import Ising2DLambda.ThermodynamicLimit.OpenRectangleConstantPlusConfiguration

namespace Ising2DLambda.ThermodynamicLimit

open Finset

variable (a b : ℕ)

/-- `claim_open_rectangle_value_ge_one_at_positive_rational`。 -/
theorem one_le_openPartitionValueRat {q : ℚ} (hq : 0 < q) :
    1 ≤ openPartitionValueRat a b q := by
  let τplus : OpenConfig a b := openAllPlusConfig a b
  have hmem : τplus ∈ (univ : Finset (OpenConfig a b)) := mem_univ τplus   -- τ_+ ∈ Σ^op_{a,b}
  have hbreaks : openBrokenBondCount a b τplus = 0 :=
    openAllPlusConfig_openBrokenBondCount_eq_zero a b                       -- b^op(τ_+) = 0
  -- 準備: 加えた和は正の有理数の有限和なので 0 以上
  have hrest : 0 ≤ ∑ σ ∈ (univ : Finset (OpenConfig a b)).erase τplus,
      q ^ openBrokenBondCount a b σ :=
    sum_nonneg fun σ _ => (pow_pos hq _).le
  calc
    1 = q ^ 0 := (pow_zero q).symm                                          -- 冪の指数 0 の約束
    _ = q ^ openBrokenBondCount a b τplus := by rw [hbreaks]                -- b^op(τ_+) = 0
    _ ≤ q ^ openBrokenBondCount a b τplus +
        ∑ σ ∈ (univ : Finset (OpenConfig a b)).erase τplus,
          q ^ openBrokenBondCount a b σ :=
          le_add_of_nonneg_right hrest                                      -- 加えた和は 0 以上
    _ = ∑ σ : OpenConfig a b, q ^ openBrokenBondCount a b σ := by
          rw [add_comm, sum_erase_add _ _ hmem]                             -- 1 項を有限和へ戻す
    _ = openPartitionValueRat a b q :=
          (openPartitionValueRat_eq_sum a b q).symm                         -- 代入は環準同型

end Ising2DLambda.ThermodynamicLimit
