import Ising2DLambda.KacWard.TwistedModeRatioRoot
import Ising2DLambda.NecSuf.KacWard.TwistedModeRatioRoot

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedMode_ratio_root_from_necSuf {L : ℕ} (s : SpinStructure)
    {varpi varpi' varsigma varsigma' : Qbar}
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarpi' : varpi' ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (hvarsigma' : varsigma' ∈ verticalTwistedModes L s) :
    varpi' / varpi ∈ RootOfUnity L ∧ varsigma' / varsigma ∈ RootOfUnity L := by
  constructor
  · exact Ising2DLambda.NecSuf.KacWard.equalPower_ratio_root_necSuf hvarpi hvarpi'
      (by split_ifs <;> norm_num)
  · exact Ising2DLambda.NecSuf.KacWard.equalPower_ratio_root_necSuf hvarsigma hvarsigma'
      (by split_ifs <;> norm_num)

end Ising2DLambda.KacWard
