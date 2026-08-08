/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.FreeEntropy.sum_pow_pos` に
  ι := 配位の集合 Config L
  f := 破れボンド数 brokenBondCount L
  K := ℚ
を代入すると、具体版 `FreeEntropy.partitionPolynomial_eval_pos` が出る。
残るのは Step 1（代入を和へ配ること）だけであり、これは `eval_partitionPolynomial` である。

必要十分版が要求する `Nonempty ι` は、人手証明の `|Σ_L| = 2^{L²} ≥ 1` にあたる。
このことは、具体版の証明が「値が有理数であること」「多項式であること」
「指数が破れボンド数であること」「格子の形」を使っていないという主張の裏取りになっている。

住処: ℚ と ℕ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.NecSuf.FreeEntropy.ValuePositive

namespace Ising2DLambda.FreeEntropy

open PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem partitionPolynomial_eval_pos_from_necSuf {q : ℚ} (hq : 0 < q) :
    0 < Polynomial.aeval q (partitionPolynomial L) := by
  haveI : Nonempty (Config L) :=
    Fintype.card_pos_iff.mp (by rw [card_config L]; exact pow_pos (by norm_num) _)
  rw [eval_partitionPolynomial L q]
  exact NecSuf.FreeEntropy.sum_pow_pos (brokenBondCount L) hq

end Ising2DLambda.FreeEntropy
