/- 必要十分版を `Qbar` 係数・部分体係数の対称多項式へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.SymmetricVanishingDivisibleByProduct
import Ising2DLambda.NecSuf.FisherZero.SymmetricVanishingDivisibleByProduct

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_qbar_all_ones_shift_subfield_coefficient` を必要十分版から得る。`K = Qbar`、`S = F`。 -/
theorem allOnesShift_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ}
    (P : QbarMvPoly n) (hP : P ∈ subfieldCoefficientMvPolys F n) :
    allOnesShift P ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.allOnesShift_coeff_mem_necSuf (F : Set Qbar) P hP

/-- `claim_symmetric_vanishing_last_variable_shift_total_degree` を必要十分版から得る。
`K = Qbar`。対称性から各互換 `(k n)` についての不変性を取り出して渡す。 -/
theorem symmetricVanishing_allOnesShift_totalDegree_from_necSuf {n : ℕ} (P : QbarMvPoly (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) (hP : P ≠ 0) :
    qbarTotalDegree (allOnesShift P) + (n + 1) = qbarTotalDegree P :=
  Ising2DLambda.NecSuf.FisherZero.allOnesShift_totalDegree_necSuf P
    (fun k => hsym (Equiv.swap k (Fin.last n))) hlz hP

/-- `claim_symmetric_vanishing_last_variable_divisible_by_product` を必要十分版から得る。
`K = Qbar`、`S = F`。全次数・指数 `1`・`sd` は具体版と同じ式で定めてある。 -/
theorem symmetricVanishing_divisible_by_elementarySymmetric_from_necSuf (F : Subfield Qbar) {n : ℕ}
    (P : QbarMvPoly (n + 1)) (hF : P ∈ subfieldCoefficientMvPolys F (n + 1))
    (hsym : IsQbarSymmetric P) (hlz : lastVariableZero n P = 0) :
    ∃ Q ∈ subfieldCoefficientMvPolys F (n + 1), IsQbarSymmetric Q ∧
      P = qbarElementarySymmetric (n + 1) (n + 1) * Q ∧
      (P ≠ 0 → qbarTotalDegree Q + (n + 1) = qbarTotalDegree P) := by
  obtain ⟨Q, hQS, hQsym, hPQ, hdeg⟩ :=
    Ising2DLambda.NecSuf.FisherZero.symmetricVanishing_divisible_by_product_necSuf (F : Set Qbar) P hF
      hsym hlz
  exact ⟨Q, hQS, hQsym, hPQ, hdeg⟩

end Ising2DLambda.FisherZero
