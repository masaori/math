import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedMode_ratio_root {L : ℕ} (s : SpinStructure)
    {varpi varpi' varsigma varsigma' : Qbar}
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarpi' : varpi' ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (hvarsigma' : varsigma' ∈ verticalTwistedModes L s) :
    varpi' / varpi ∈ RootOfUnity L ∧ varsigma' / varsigma ∈ RootOfUnity L := by
  constructor
  · change (varpi' / varpi) ^ L = 1
    have hσ : (if s.1 then (-1 : Qbar) else 1) ≠ 0 := by split_ifs <;> norm_num
    calc
      (varpi' / varpi) ^ L = varpi' ^ L / varpi ^ L := div_pow varpi' varpi L
      _ = (if s.1 then (-1 : Qbar) else 1) /
          (if s.1 then (-1 : Qbar) else 1) := by
            rw [show varpi' ^ L = (if s.1 then (-1 : Qbar) else 1) from hvarpi',
              show varpi ^ L = (if s.1 then (-1 : Qbar) else 1) from hvarpi]
      _ = 1 := div_self hσ
  · change (varsigma' / varsigma) ^ L = 1
    have hσ : (if s.2 then (-1 : Qbar) else 1) ≠ 0 := by split_ifs <;> norm_num
    calc
      (varsigma' / varsigma) ^ L = varsigma' ^ L / varsigma ^ L := div_pow varsigma' varsigma L
      _ = (if s.2 then (-1 : Qbar) else 1) /
          (if s.2 then (-1 : Qbar) else 1) := by
            rw [show varsigma' ^ L = (if s.2 then (-1 : Qbar) else 1) from hvarsigma',
              show varsigma ^ L = (if s.2 then (-1 : Qbar) else 1) from hvarsigma]
      _ = 1 := div_self hσ

end Ising2DLambda.KacWard
