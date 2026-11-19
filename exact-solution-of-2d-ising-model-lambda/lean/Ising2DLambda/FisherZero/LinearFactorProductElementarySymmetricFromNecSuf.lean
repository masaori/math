/- 必要十分版を Qbar と `ℕ_{<n}` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.LinearFactorProductElementarySymmetric
import Ising2DLambda.NecSuf.FisherZero.LinearFactorProductElementarySymmetric

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_point_value_elementary_symmetric_last_split` を必要十分版から得る。 -/
theorem qbarMvValue_elementarySymmetric_last_split_from_necSuf {n : ℕ} (α : Fin (n + 1) → Qbar)
    (j : ℕ) :
    qbarMvValue α (qbarElementarySymmetric (n + 1) (j + 1))
      = qbarMvValue (fun k : Fin n => α (Fin.castSucc k)) (qbarElementarySymmetric n (j + 1))
        + α (Fin.last n) * qbarMvValue (fun k : Fin n => α (Fin.castSucc k)) (qbarElementarySymmetric n j) := by
  rw [qbarMvValue_elementarySymmetric, qbarMvValue_elementarySymmetric, qbarMvValue_elementarySymmetric]
  exact Ising2DLambda.NecSuf.FisherZero.elementarySymmetricValue_last_split_necSuf α j

/-- `claim_linear_factor_product_coefficient_elementary_symmetric` を必要十分版から得る。 -/
theorem linearFactorProduct_coeff_elementarySymmetric_from_necSuf (w : ℕ → Qbar) :
    ∀ n j : ℕ, j ≤ n →
      (∏ i ∈ Finset.range n, (Polynomial.X - qbarConst (w i))).coeff (n - j)
        = (-1) ^ j * qbarMvValue (fun k : Fin n => w k) (qbarElementarySymmetric n j) := by
  intro n j hj
  rw [qbarMvValue_elementarySymmetric]
  exact Ising2DLambda.NecSuf.FisherZero.linearFactorProduct_coeff_elementarySymmetric_necSuf w n j hj

end Ising2DLambda.FisherZero
