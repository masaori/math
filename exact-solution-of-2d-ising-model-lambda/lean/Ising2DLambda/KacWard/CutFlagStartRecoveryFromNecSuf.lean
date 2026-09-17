import Ising2DLambda.KacWard.CutFlagStartRecovery
import Ising2DLambda.NecSuf.KacWard.CutFlagStartRecovery

namespace Ising2DLambda.KacWard

theorem coordinateStartCompatible_iff_forcedForbidden_from_necSuf
    (side : ℤ) {n : ℕ} (displacement : Fin n → ℤ)
    (flags : Fin n → Bool × Bool) (r : ℤ) (_hside : 2 ≤ side) :
    (0 ≤ r ∧ r < side ∧ coordinateStartCompatible side displacement flags r) ↔
      0 ≤ r ∧ r < side ∧
        (∀ x, coordinateForcedResidue side displacement flags x → r = x) ∧
        ¬coordinateForbiddenResidue side displacement flags r := by
  constructor
  · rintro ⟨hr0, hrside, hr⟩
    have h := (Ising2DLambda.NecSuf.KacWard.compatible_iff_forced_forbidden
      (coordinateCutTarget side displacement) (coordinateCutPositive flags) r).mp hr
    exact ⟨hr0, hrside, h.1, h.2⟩
  · rintro ⟨hr0, hrside, hforced, hforbidden⟩
    have h := (Ising2DLambda.NecSuf.KacWard.compatible_iff_forced_forbidden
      (coordinateCutTarget side displacement) (coordinateCutPositive flags) r).mpr
      ⟨hforced, hforbidden⟩
    exact ⟨hr0, hrside, h⟩

end Ising2DLambda.KacWard
