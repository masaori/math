import Ising2DLambda.FisherZero.QuadraticTrichotomyAtMostOne
import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `P_s` を `Qbar` の部分集合として読む包含写像の像。 -/
def quadraticPositiveConeAmbient (s : Qbar) : Set Qbar :=
  {z | ∃ hz : z ∈ quadraticFieldSet s,
    (⟨z, hz⟩ : QuadraticFieldElement s) ∈ quadraticPositiveCone s}

/-- `claim_quadratic_positive_cone_ambient_trichotomy` の具体版。 -/
theorem quadraticPositiveCone_ambient_trichotomy
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (z : Qbar) (hz : z ∈ quadraticFieldSet s) :
    ExactlyOneOfThree (z = 0) (z ∈ quadraticPositiveConeAmbient s)
      (-z ∈ quadraticPositiveConeAmbient s) := by
  let xi : QuadraticFieldElement s := ⟨z, hz⟩
  have hneg_eq (hneg : -z ∈ quadraticFieldSet s) :
      (⟨-z, hneg⟩ : QuadraticFieldElement s) = quadraticNegElement s xi := by
    apply Subtype.ext
    rfl
  have hpos_iff : z ∈ quadraticPositiveConeAmbient s ↔
      xi ∈ quadraticPositiveCone s := by
    constructor
    · rintro ⟨h, hp⟩
      have heq : (⟨z, h⟩ : QuadraticFieldElement s) = xi := Subtype.ext rfl
      simpa [heq] using hp
    · intro hp
      exact ⟨hz, hp⟩
  have hneg_iff : -z ∈ quadraticPositiveConeAmbient s ↔
      quadraticNegElement s xi ∈ quadraticPositiveCone s := by
    constructor
    · rintro ⟨h, hp⟩
      simpa [hneg_eq h] using hp
    · intro hp
      exact ⟨quadraticNeg_mem s xi, by simpa [hneg_eq (quadraticNeg_mem s xi)] using hp⟩
  have hsome := quadraticTrichotomyAtLeastOne s hs xi
  have hdistinct := quadraticTrichotomyAtMostOne s hs xi
  dsimp [ExactlyOneOfThree]
  constructor
  · rcases hsome with hp | hzero | hn
    · exact Or.inr (Or.inl (hpos_iff.mpr hp))
    · exact Or.inl hzero
    · exact Or.inr (Or.inr (hneg_iff.mpr hn))
  constructor
  · rintro ⟨hzero, hp⟩
    exact hdistinct.1 ⟨hpos_iff.mp hp, hzero⟩
  constructor
  · rintro ⟨hzero, hn⟩
    exact hdistinct.2.1 ⟨hzero, hneg_iff.mp hn⟩
  · rintro ⟨hp, hn⟩
    exact hdistinct.2.2 ⟨hpos_iff.mp hp, hneg_iff.mp hn⟩

end Ising2DLambda.FisherZero
