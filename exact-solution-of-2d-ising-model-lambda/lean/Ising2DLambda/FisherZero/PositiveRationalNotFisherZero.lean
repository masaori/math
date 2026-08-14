/-
人手証明の主張「正の有理点は Fisher 零点でない」
（ラベル `claim_positive_rational_not_fisher_zero`）の具体版。

人手証明との対応:

  第 1 行  Qbar での評価を多重度の有限和へ開く
  第 2 行  その有限和を Q での代入値と同じ元へ戻す
  第 3 行  Q での代入値の正値性を適用する
  結論    Fisher 零点の定義が与える零性と矛盾させる

住処: Q と Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.Algebraicity
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda PartitionPolynomial AlgebraicEigenvalue

variable (L : ℕ) [NeZero L]

/-- 人手証明の第 1 行。Qbar での評価を多重度の有限和へ開く。 -/
lemma qbarPolynomialEval_partitionPolynomial_eq_sum_multiplicity (q : ℚ) :
    qbarPolynomialEval (q : Qbar) (partitionPolynomial L) =
      ∑ m ∈ range (2 * L ^ 2 + 1),
        (PartitionPolynomial.multiplicity L m : Qbar) * (q : Qbar) ^ m := by
  rw [partitionPolynomial_eq_sum_multiplicity]
  simp [qbarPolynomialEval]

/-- 人手証明の第 2 行。Qbar の評価は Q での代入値を埋め込んだ元に等しい。 -/
lemma qbarPolynomialEval_partitionPolynomial_eq_ratEval (q : ℚ) :
    qbarPolynomialEval (q : Qbar) (partitionPolynomial L) =
      (Polynomial.aeval q (partitionPolynomial L) : Qbar) := by
  rw [qbarPolynomialEval_partitionPolynomial_eq_sum_multiplicity L q]
  rw [partitionPolynomial_eq_sum_multiplicity]
  simp

/-- 正の有理点は有限格子の Fisher 零点ではない。 -/
theorem positiveRational_not_mem_fisherZero {q : ℚ} (hq : 0 < q) :
    (q : Qbar) ∉ FisherZeroSet L := by
  have hpositive : 0 < Polynomial.aeval q (partitionPolynomial L) :=
    Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos L hq
  have hnonzeroQ : Polynomial.aeval q (partitionPolynomial L) ≠ 0 := ne_of_gt hpositive
  have hnonzeroQbar : qbarPolynomialEval (q : Qbar) (partitionPolynomial L) ≠ 0 := by
    rw [qbarPolynomialEval_partitionPolynomial_eq_ratEval L q]
    exact_mod_cast hnonzeroQ
  intro hroot
  exact hnonzeroQbar ((mem_fisherZero).1 hroot)

end Ising2DLambda.FisherZero
