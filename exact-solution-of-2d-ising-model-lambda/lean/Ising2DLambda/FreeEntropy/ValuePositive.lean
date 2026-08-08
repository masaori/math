/-
人手証明の主張「分配多項式の正の有理点での値は正の有理数である」（ラベル
`claim_value_at_rational_is_positive`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（代入を和へ配る）          eval_partitionPolynomial
  Step 2（各項が正）                pow_pos（正の有理数の冪は正）
  Step 3（和が正）                  Finset.sum_pos（空でない有限個の正の元の和は正）
  Step 4（結論）                    partitionPolynomial_eval_pos

Step 1 は「代入が環準同型であること」の適用であり、人手証明が明示的に述べている事柄なので、
mathlib の `map_sum` / `map_pow` を引く。Step 3 の「空でない有限個の正の元の和は正」も
人手証明が明示的に適用している定理そのものである。

住処: 人手証明のこのブロックは ℚ を宣言している。ここに ℝ / ℂ は現れない
（代入先は `ℚ`、指数は `ℕ`）。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Ising2DLambda.FreeEntropy.Basic

namespace Ising2DLambda.FreeEntropy

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- Step 1（代入を和へ配る）。`Z_L(q) = Σ_σ q^{b(σ)}`。 -/
lemma eval_partitionPolynomial (q : ℚ) :
    Polynomial.aeval q (partitionPolynomial L) = ∑ σ : Config L, q ^ brokenBondCount L σ := by
  rw [partitionPolynomial, map_sum]
  exact sum_congr rfl fun σ _ => by rw [map_pow, Polynomial.aeval_X]

/-- Step 4（結論）。正の有理点での値は正である（値が有理数であることは型が言っている）。 -/
theorem partitionPolynomial_eval_pos {q : ℚ} (hq : 0 < q) :
    0 < Polynomial.aeval q (partitionPolynomial L) := by
  rw [eval_partitionPolynomial L q]
  -- Step 3。配位は少なくとも 1 つある（人手証明の `|Σ_L| = 2^{L²} ≥ 1`）。
  haveI : Nonempty (Config L) :=
    Fintype.card_pos_iff.mp (by rw [card_config L]; exact pow_pos (by norm_num) _)
  refine sum_pos (fun σ _ => ?_) univ_nonempty
  -- Step 2。正の有理数の冪は正。
  exact pow_pos hq (brokenBondCount L σ)

end Ising2DLambda.FreeEntropy
