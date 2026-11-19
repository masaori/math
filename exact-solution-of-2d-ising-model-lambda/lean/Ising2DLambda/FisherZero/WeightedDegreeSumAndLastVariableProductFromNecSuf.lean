/- 必要十分版を `Qbar` 係数・重み `w = wsz_n`・変数 `i = n`（`Fin.last n`）・`d = n + 1` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.WeightedDegreeSumAndLastVariableProduct
import Ising2DLambda.NecSuf.FisherZero.WeightedDegreeSumAndLastVariableProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- 具体版の重み付き次数は、必要十分版の次数を重み `wsz_n` で読んだものである。 -/
theorem qbarWeightedDegree_eq_wDeg {n : ℕ} (Q : QbarMvPoly n) :
    qbarWeightedDegree Q = Ising2DLambda.NecSuf.FisherZero.wDeg exponentWeightedTotal Q :=
  rfl

/-- `claim_qbar_weighted_degree_sum_bound` を必要十分版から得る（`w = wsz_n`）。 -/
theorem qbarWeightedDegree_add_le_from_necSuf {n : ℕ} (A B : QbarMvPoly n) :
    qbarWeightedDegree (A + B) ≤ max (qbarWeightedDegree A) (qbarWeightedDegree B) :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_add_le_necSuf exponentWeightedTotal A B

/-- `claim_qbar_weighted_degree_last_variable_product_bound` を必要十分版から得る
（`i = n`、`d = n + 1`。`hw` は具体版の式鎖の等号 `wsz(δ_n + c) = (n+1) + wsz(c)` から）。 -/
theorem qbarWeightedDegree_X_last_mul_le_from_necSuf {n : ℕ} (S : QbarMvPoly (n + 1)) :
    qbarWeightedDegree (X (Fin.last n) * S) ≤ (n + 1) + qbarWeightedDegree S := by
  refine Ising2DLambda.NecSuf.FisherZero.wDeg_X_mul_le_necSuf exponentWeightedTotal (Fin.last n)
    (n + 1) (fun c => ?_) S
  have hle : Finsupp.single (Fin.last n) 1 ≤ Finsupp.single (Fin.last n) 1 + c := le_self_add
  rw [exponentWeightedTotal_of_single_last_le _ hle, add_tsub_cancel_left]

end Ising2DLambda.FisherZero
