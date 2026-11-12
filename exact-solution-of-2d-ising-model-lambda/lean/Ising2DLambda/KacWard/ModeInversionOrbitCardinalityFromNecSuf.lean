import Ising2DLambda.KacWard.ModeInversionOrbitCardinality
import Ising2DLambda.NecSuf.KacWard.ModeInversionOrbitCardinality

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Classical

/-- 具体版の軌道と元数は、必要十分版の定義を `K := Qbar` に特殊化したものである。 -/
theorem modeInversionOrbit_from_necSuf (varpi varsigma : Qbar) :
    modeInversionOrbit varpi varsigma =
      Ising2DLambda.NecSuf.KacWard.modeInversionOrbit varpi varsigma := rfl

/-- 具体版の主張は、必要十分版を `K := Qbar`、`t := (−1)^a`、`t' := (−1)^b` に特殊化して得られる。 -/
theorem mode_inversion_orbit_cardinality_from_necSuf {L : ℕ} (hL : 1 ≤ L) (s : SpinStructure)
    {varpi varsigma : Qbar} (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) :
    (∀ m ∈ modeInversionOrbit varpi varsigma,
        m.1 ∈ horizontalTwistedModes L s ∧ m.2 ∈ verticalTwistedModes L s) ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ∨
        (modeInversionOrbit varpi varsigma).card = 2 ∨
        (modeInversionOrbit varpi varsigma).card = 4) ∧
      ((modeInversionOrbit varpi varsigma).card = 1 ↔
        (varpi = 1 ∨ varpi = -1) ∧ (varsigma = 1 ∨ varsigma = -1)) := by
  rw [modeInversionOrbit_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.mode_inversion_orbit_cardinality_necSuf hL _ _
    (twistSign_mul_self s.1) (twistSign_mul_self s.2) hvarpi hvarsigma

end Ising2DLambda.KacWard
