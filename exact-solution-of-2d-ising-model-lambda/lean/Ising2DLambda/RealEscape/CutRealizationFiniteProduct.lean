import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder

namespace Ising2DLambda.RealEscape

open Ising2DLambda.CriticalExponent
open Ising2DLambda.FisherZero

/-- 下切断による実現写像は有限積を保つ。 -/
theorem cutRealization_finiteProduct {α : Type*} [DecidableEq α]
    (data : RealClosedSubfieldData) (S : Finset α) (u : α → data.carrier) :
    realAlgebraicCutRealization data (∏ i ∈ S, u i) =
      ∏ i ∈ S, realAlgebraicCutRealization data (u i) := by
  induction S using Finset.induction_on with
  | empty =>
      simp only [Finset.prod_empty]
      exact cutRealization_one data
  | insert i S hi ih =>
      rw [Finset.prod_insert hi, Finset.prod_insert hi]
      rw [cutRealization_preserves_multiplication data, ih]

end Ising2DLambda.RealEscape
