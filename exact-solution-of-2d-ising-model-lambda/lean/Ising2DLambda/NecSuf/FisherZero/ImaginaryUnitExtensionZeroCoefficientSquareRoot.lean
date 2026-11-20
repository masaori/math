import Mathlib.Algebra.Field.Subfield.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 三分法と正の元の平方根だけで足りる。極大性や代数閉性は使わない。 -/
theorem imaginaryUnitExtension_zeroCoefficient_squareRoot
    {K : Type*} [Field K] (F : Subfield K) (C : Set K)
    (htri : ∀ a : K, a ∈ F → a = 0 ∨ a ∈ C ∨ -a ∈ C)
    (hpositive : ∀ z : K, z ∈ C →
      ∃ w : K, w ∈ F ∧ w * w = z)
    (a omega : K) (ha : a ∈ F) (homega : omega * omega = -1) :
    ∃ u v : K, u ∈ F ∧ v ∈ F ∧
      (u + v * omega) * (u + v * omega) = a := by
  rcases htri a ha with hz | hp | hn
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

end Ising2DLambda.NecSuf.FisherZero
