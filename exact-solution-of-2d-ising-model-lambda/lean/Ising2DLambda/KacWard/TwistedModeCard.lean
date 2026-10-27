import Ising2DLambda.KacWard.HorizontalTwistedModesCoset
import Ising2DLambda.KacWard.VerticalTwistedModesCoset
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityCard

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- Both directional mode sets have exactly L elements for either twist. -/
theorem twistedModeSets_ncard (L : ℕ) (hL : 0 < L) (ξ : Qbar)
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
  have himage : ((fun y : Qbar => ξ * y) '' RootOfUnity L).ncard = L := by
    calc
      ((fun y : Qbar => ξ * y) '' RootOfUnity L).ncard
          = (RootOfUnity L).ncard :=
            Set.ncard_image_of_injective _ (fun _ _ h => mul_left_cancel₀ hξne h)
      _ = L := hroot
  obtain ⟨hh0, hh1⟩ := horizontalTwistedModes_eq_coset L ξ hξ
  obtain ⟨hv0, hv1⟩ := verticalTwistedModes_eq_coset L ξ hξ
  exact ⟨by rw [hh0]; exact hroot,
    by rw [hh1]; exact himage,
    by rw [hv0]; exact hroot,
    by rw [hv1]; exact himage⟩

end Ising2DLambda.KacWard
