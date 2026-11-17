import Ising2DLambda.FisherZero.QuadraticPositiveConeAmbientTrichotomy
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveConeAmbientTrichotomy

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を `Q_s` の包含と符号反転に特殊化する導出。 -/
theorem quadraticPositiveCone_ambient_trichotomy_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (z : Qbar) (hz : z ∈ quadraticFieldSet s) :
    ExactlyOneOfThree (z = 0) (z ∈ quadraticPositiveConeAmbient s)
      (-z ∈ quadraticPositiveConeAmbient s) := by
  have htri (xi : QuadraticFieldElement s) :
      ((xi : Qbar) = 0 ∨ xi ∈ quadraticPositiveCone s ∨
        quadraticNegElement s xi ∈ quadraticPositiveCone s) ∧
      ¬ (xi ∈ quadraticPositiveCone s ∧ (xi : Qbar) = 0) ∧
      ¬ ((xi : Qbar) = 0 ∧ quadraticNegElement s xi ∈ quadraticPositiveCone s) ∧
      ¬ (xi ∈ quadraticPositiveCone s ∧
        quadraticNegElement s xi ∈ quadraticPositiveCone s) := by
    have hsome := quadraticTrichotomyAtLeastOne s hs xi
    have hdistinct := quadraticTrichotomyAtMostOne s hs xi
    refine ⟨?_, hdistinct.1, hdistinct.2.1, hdistinct.2.2⟩
    rcases hsome with hp | hzero | hn
    · exact Or.inr (Or.inl hp)
    · exact Or.inl hzero
    · exact Or.inr (Or.inr hn)
  have h := Ising2DLambda.NecSuf.FisherZero.positiveCone_ambient_trichotomy
    (quadraticFieldSet s) (quadraticPositiveCone s) (quadraticNegElement s)
    (fun _ => rfl) htri z hz
  exact h

end Ising2DLambda.FisherZero
