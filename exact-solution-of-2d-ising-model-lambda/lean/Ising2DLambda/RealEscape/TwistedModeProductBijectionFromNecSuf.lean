/-
`claim_twisted_mode_product_bijection` の具体版が、必要十分版 `pairMap_bijOn_necSuf` の
α = β := Q̄、γ = δ := ℂ、f = g := 複素実現、U := U_a、W := W_b、E := E_{L,a}、F := E_{L,b} への
特殊化として得られること。成分の全単射は `claim_twisted_modes_complex_roots_bijection` から与える。
-/
import Ising2DLambda.RealEscape.TwistedModeProductBijection
import Ising2DLambda.NecSuf.RealEscape.TwistedModeProductBijection

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 具体版の Θ は必要十分版の組の写像の特殊化である。 -/
theorem twistedModeProductRealization_eq_pairMap (data : RealClosedSubfieldData) :
    twistedModeProductRealization data =
      Ising2DLambda.NecSuf.RealEscape.pairMap (complexAlgebraicRealization data)
        (complexAlgebraicRealization data) := rfl

theorem twistedModeProductRealization_bijOn_from_necSuf (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (twistedModeProductRealization data)
      (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s)
      (complexRootSet L s.1 ×ˢ complexRootSet L s.2) := by
  rw [twistedModeProductRealization_eq_pairMap]
  exact Ising2DLambda.NecSuf.RealEscape.pairMap_bijOn_necSuf _ _ _ _ _ _
    (complexAlgebraicRealization_horizontal_bijOn data L hL s)
    (complexAlgebraicRealization_vertical_bijOn data L hL s)

end Ising2DLambda.RealEscape
