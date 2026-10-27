import Ising2DLambda.KacWard.VerticalTwistedModesCoset
import Ising2DLambda.NecSuf.KacWard.TwistedModeCoset

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem verticalTwistedModes_eq_coset_from_necSuf (L : ℕ) (ξ : Qbar)
    (hξ : ξ ^ L = -1) :
    verticalTwistedModes L (false, false) = RootOfUnity L ∧
    verticalTwistedModes L (false, true) =
        (fun y : Qbar => ξ * y) '' RootOfUnity L := by
  have hξne : ξ ≠ 0 := by
    intro hzero
    rw [hzero] at hξ
    cases L with
    | zero => norm_num at hξ
    | succ n => simp at hξ
  simpa [verticalTwistedModes, RootOfUnity] using
    Ising2DLambda.NecSuf.KacWard.twistedModes_eq_coset_necSuf L ξ hξ hξne

end Ising2DLambda.KacWard
