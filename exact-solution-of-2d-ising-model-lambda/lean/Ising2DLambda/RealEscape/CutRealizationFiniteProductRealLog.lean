import Ising2DLambda.RealEscape.CutRealizationFiniteProduct
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.ThermodynamicLimit

/-- 正の元の有限積を実現すると、その実対数は実現した各元の実対数の和になる。 -/
theorem cutRealization_realLog_finiteProduct {α : Type*} [DecidableEq α]
    (data : RealClosedSubfieldData) (S : Finset α) (u : α → data.carrier)
    (hpos : ∀ i, 0 < realAlgebraicCutRealization data (u i)) :
    realLog ⟨realAlgebraicCutRealization data (∏ i ∈ S, u i), by
      rw [cutRealization_finiteProduct]
      exact Finset.prod_pos (fun i _ => hpos i)⟩ =
      ∑ i ∈ S, realLog ⟨realAlgebraicCutRealization data (u i), hpos i⟩ := by
  calc
    realLog ⟨realAlgebraicCutRealization data (∏ i ∈ S, u i), _⟩ =
        realLog ⟨∏ i ∈ S, realAlgebraicCutRealization data (u i),
          Finset.prod_pos (fun i _ => hpos i)⟩ :=
          realLog_congr _ _ (cutRealization_finiteProduct data S u)
    _ = ∑ i ∈ S, realLog ⟨realAlgebraicCutRealization data (u i), hpos i⟩ :=
      realLog_prod S
        (fun i => ⟨realAlgebraicCutRealization data (u i), hpos i⟩)

end Ising2DLambda.RealEscape
