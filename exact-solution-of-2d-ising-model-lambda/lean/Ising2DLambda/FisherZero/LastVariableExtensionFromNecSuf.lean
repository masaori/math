/- 必要十分版を `Qbar` 係数・部分体 `F`（零元を含む）・重み `w = wsz_n`、`w' = wsz_{n+1}` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.LastVariableExtension
import Ising2DLambda.FisherZero.LastVariableZeroSubfieldCoefficientDegreeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.LastVariableExtension

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- 具体版の持ち上げと必要十分版の持ち上げは同じ式（係数の場合分けの式と同じ制限）で定めてある。 -/
theorem lastVariableExtension_eq_necSuf {n : ℕ} (Q : QbarMvPoly n) :
    lastVariableExtension Q = Ising2DLambda.NecSuf.FisherZero.lastVariableExtensionNecSuf Q :=
  rfl

/-- `claim_last_variable_zero_of_extension` を必要十分版から得る（`K = Qbar`）。 -/
theorem lastVariableZero_lastVariableExtension_from_necSuf {n : ℕ} (Q : QbarMvPoly n) :
    lastVariableZero n (lastVariableExtension Q) = Q := by
  rw [lastVariableExtension_eq_necSuf]
  exact Ising2DLambda.NecSuf.FisherZero.lastVariableZero_lastVariableExtension_necSuf Q

/-- `claim_last_variable_extension_subfield_coefficient` を必要十分版から得る（`S = F`、`0 ∈ F`）。 -/
theorem lastVariableExtension_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ}
    (Q : QbarMvPoly n) (hQ : Q ∈ subfieldCoefficientMvPolys F n) :
    lastVariableExtension Q ∈ subfieldCoefficientMvPolys F (n + 1) := by
  rw [lastVariableExtension_eq_necSuf]
  exact Ising2DLambda.NecSuf.FisherZero.lastVariableExtension_mem_coeffIn_necSuf
    (S := (F : Set Qbar)) F.zero_mem Q hQ

/-- `claim_last_variable_extension_weighted_degree_bound` を必要十分版から得る（`w = wsz_n`、`w' = wsz_{n+1}`）。 -/
theorem qbarWeightedDegree_lastVariableExtension_le_from_necSuf {n : ℕ} (Q : QbarMvPoly n) :
    qbarWeightedDegree (lastVariableExtension Q) ≤ qbarWeightedDegree Q := by
  rw [lastVariableExtension_eq_necSuf]
  exact Ising2DLambda.NecSuf.FisherZero.wDeg_lastVariableExtension_le_necSuf
    exponentWeightedTotal exponentWeightedTotal
    (fun a h => (exponentWeightedTotal_of_last_eq_zero a h).le) Q

end Ising2DLambda.FisherZero
