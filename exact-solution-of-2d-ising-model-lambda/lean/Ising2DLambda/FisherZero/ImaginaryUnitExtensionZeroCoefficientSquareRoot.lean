import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 虚係数が零なら、正錐の三分法に従って実の根または虚の根を選ぶ。 -/
theorem imaginaryUnitExtension_zeroCoefficient_squareRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (hpositive : ∀ z : Qbar, z ∈ C →
      ∃ w : Qbar, w ∈ F ∧ w * w = z)
    (a omega : Qbar) (ha : a ∈ F) (homega : omega * omega = -1) :
    ∃ u v : Qbar, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a := by
  rcases (hC.trichotomy a ha).1 with hz | hp | hn
  · exact ⟨0, 0, F.zero_mem, F.zero_mem, by simp [hz]⟩
  · obtain ⟨w, hwF, hw2⟩ := hpositive a hp
    refine ⟨w, 0, hwF, F.zero_mem, ?_⟩
    simpa using hw2
  · obtain ⟨w, hwF, hw2⟩ := hpositive (-a) hn
    refine ⟨0, w, F.zero_mem, hwF, ?_⟩
    calc
      (0 + w * omega) * (0 + w * omega) = (w * w) * (omega * omega) := by ring
      _ = (-a) * (-1) := by rw [hw2, homega]
      _ = a := by ring

end Ising2DLambda.FisherZero
