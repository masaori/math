/-
`claim_twisted_modes_complex_roots_bijection` の具体版が、必要十分版 `bijOn_rootSet_necSuf` の
γ := ℂ、α := Q̄、e := e_{L,c,·}、E := E_{L,c}、f := 複素実現、U := U_a または W_b への特殊化として
得られること。mem は `complexRootCandidate_pow`、period は `complexRootCandidate_period`、
finite・ncardLe は `complexRootSet_finite`・`complexRootSet_ncard_le`、mapsTo は
`claim_complex_realization_twisted_modes_are_complex_roots`、injOn は
`claim_complex_realization_injective`、cardU は `claim_twisted_mode_sets_card` から与える。
-/
import Ising2DLambda.RealEscape.TwistedModesComplexRootsBijection
import Ising2DLambda.NecSuf.RealEscape.TwistedModesComplexRootsBijection

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

theorem complexAlgebraicRealization_bijOn_from_necSuf (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (c : Bool) (U : Set Qbar) (hU : U.ncard = L)
    (hmaps : Set.MapsTo (complexAlgebraicRealization data) U (complexRootSet L c)) :
    Set.BijOn (complexAlgebraicRealization data) U (complexRootSet L c) :=
  Ising2DLambda.NecSuf.RealEscape.bijOn_rootSet_necSuf L (complexRootCandidate L c)
    (complexRootSet L c) (complexRootCandidate_pow L hL c)
    (complexRootCandidate_period L hL c) (complexRootSet_finite L hL c)
    (complexRootSet_ncard_le L hL c) (complexAlgebraicRealization data) U hmaps
    (complexAlgebraicRealization_injective data).injOn hU

theorem complexAlgebraicRealization_horizontal_bijOn_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (complexAlgebraicRealization data) (horizontalTwistedModes L s)
      (complexRootSet L s.1) :=
  complexAlgebraicRealization_bijOn_from_necSuf data L hL s.1 _
    (horizontalTwistedModes_ncard L hL s)
    (fun _ hw => complexAlgebraicRealization_horizontalMode_pow data L s hw)

theorem complexAlgebraicRealization_vertical_bijOn_from_necSuf
    (data : RealClosedSubfieldData) (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (complexAlgebraicRealization data) (verticalTwistedModes L s)
      (complexRootSet L s.2) :=
  complexAlgebraicRealization_bijOn_from_necSuf data L hL s.2 _
    (verticalTwistedModes_ncard L hL s)
    (fun _ hw => complexAlgebraicRealization_verticalMode_pow data L s hw)

end Ising2DLambda.RealEscape
