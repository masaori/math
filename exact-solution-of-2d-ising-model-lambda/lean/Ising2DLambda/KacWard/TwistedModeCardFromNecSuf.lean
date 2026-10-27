import Ising2DLambda.KacWard.TwistedModeCard
import Ising2DLambda.NecSuf.KacWard.TwistedModeCard

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem twistedModeSets_ncard_from_necSuf (L : ℕ) (hL : 0 < L) (ξ : Qbar)
    (hξ : ξ ^ L = -1) :
    (horizontalTwistedModes L (false, false)).ncard = L ∧
    (horizontalTwistedModes L (true, false)).ncard = L ∧
    (verticalTwistedModes L (false, false)).ncard = L ∧
    (verticalTwistedModes L (false, true)).ncard = L := by
  have hξne : ξ ≠ 0 := by
    intro hzero
    rw [hzero] at hξ
    simp [Nat.ne_of_gt hL] at hξ
  have hroot : (RootOfUnity L).ncard = L := rootOfUnityCardEq L hL
  have himage := Ising2DLambda.NecSuf.KacWard.scalarModeImage_ncard_necSuf
    (RootOfUnity L) ξ hξne L hroot
  obtain ⟨hh0, hh1⟩ := horizontalTwistedModes_eq_coset L ξ hξ
  obtain ⟨hv0, hv1⟩ := verticalTwistedModes_eq_coset L ξ hξ
  exact ⟨by rw [hh0]; exact hroot,
    by rw [hh1]; exact himage,
    by rw [hv0]; exact hroot,
    by rw [hv1]; exact himage⟩

end Ising2DLambda.KacWard
