import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A unique selected successor and a phase transport law suffice for a mode vector. -/
theorem transition_on_endpointModeVector_necSuf
    {E D R : Type*} [Fintype E] [DecidableEq E] [DecidableEq D] [CommSemiring R]
    (next : E → Finset E) (direction : E → D) (opposite : D → D)
    (position : E → R) (twist : E → R) (phase : E → E → R)
    (phaseDirection : D → D → R) (weight : D → R)
    (hback : ∀ e f, f ∈ next e → direction f ≠ opposite (direction e))
    (hselect : ∀ e d, d ≠ opposite (direction e) →
      ∃! f, f ∈ next e ∧ direction f = d)
    (htransport : ∀ e f, f ∈ next e →
      twist f * position f = weight (direction f) * position e)
    (hphase : ∀ e f, f ∈ next e →
      phase e f = phaseDirection (direction e) (direction f))
    (e : E) (d : D) :
    (∑ f : E, (if f ∈ next e then twist f * phase e f else 0) *
      (if direction f = d then position f else 0)) =
    (if d = opposite (direction e) then 0 else
      phaseDirection (direction e) d * weight d) * position e := by
  classical
  by_cases hd : d = opposite (direction e)
  · have hzero : ∀ f : E,
        (if f ∈ next e then twist f * phase e f else 0) *
          (if direction f = d then position f else 0) = 0 := by
      intro f
      by_cases hf : f ∈ next e
      · have hneq : direction f ≠ d := by simpa [hd] using hback e f hf
        simp [hneq]
      · simp [hf]
    simpa only [if_pos hd, zero_mul] using
      (Finset.sum_eq_zero (fun f _ => hzero f) :
        (∑ f : E, (if f ∈ next e then twist f * phase e f else 0) *
          (if direction f = d then position f else 0)) = 0)
  · obtain ⟨f, ⟨hf, hdir⟩, hunique⟩ := hselect e d hd
    have hsum :
        (∑ g : E, (if g ∈ next e then twist g * phase e g else 0) *
          (if direction g = d then position g else 0)) =
        twist f * phase e f * position f := by
      calc
        _ = (if f ∈ next e then twist f * phase e f else 0) *
            (if direction f = d then position f else 0) := by
          apply Fintype.sum_eq_single f
          intro g hgf
          by_cases hg : g ∈ next e
          · by_cases hgd : direction g = d
            · exact False.elim (hgf (hunique g ⟨hg, hgd⟩))
            · simp [hgd]
          · simp [hg]
        _ = twist f * phase e f * position f := by simp [hf, hdir]
    calc
      _ = twist f * phase e f * position f := hsum
      _ = phase e f * (twist f * position f) := by ring
      _ = phaseDirection (direction e) d * (weight d * position e) := by
        rw [hphase e f hf, hdir, htransport e f hf, hdir]
      _ = (if d = opposite (direction e) then 0 else
          phaseDirection (direction e) d * weight d) * position e := by
        simp [hd, mul_assoc]

end Ising2DLambda.NecSuf.KacWard
