/- 必要十分版を `Qbar` 係数・部分体 `F`・重み `w = sz_n`、`w' = sz_{n+1}` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.LastVariableZeroSubfieldCoefficientDegree
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionDegreeBoundFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.LastVariableZeroSubfieldCoefficientDegree

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_last_variable_zero_subfield_coefficient` を必要十分版から得る（`S = F`）。
具体版の `lz_n` と必要十分版の零代入は同じ式（`aeval` に同じ値の写像）で定めてある。 -/
theorem lastVariableZero_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ}
    (P : QbarMvPoly (n + 1)) (hP : P ∈ subfieldCoefficientMvPolys F (n + 1)) :
    lastVariableZero n P ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.lastVariableZero_mem_coeffIn_necSuf (S := (F : Set Qbar)) P hP

/-- `claim_last_variable_zero_total_degree_bound` を必要十分版から得る（`w = sz_n`、`w' = sz_{n+1}`）。 -/
theorem qbarTotalDegree_lastVariableZero_le_from_necSuf {n : ℕ} (P : QbarMvPoly (n + 1)) :
    qbarTotalDegree (lastVariableZero n P) ≤ qbarTotalDegree P :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_lastVariableZero_le_necSuf exponentTotal exponentTotal
    (fun b => (exponentTotal_exponentZeroExtension b).le) P

end Ising2DLambda.FisherZero
