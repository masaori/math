import Ising3DCut.LimitQuantity.BoxFreeDivisibilityExcludesNoRationalPoint
import Ising3DCut.NecSuf.BoxFreeDivisibilityExcludesNoRationalPoint

namespace Ising3DCut.LimitQuantity

/-- `box_free_divisibility_excludes_no_rational_point` を必要十分版から導いた版。 -/
theorem box_free_divisibility_excludes_no_rational_point_viaNecSuf
    (a : ℤ) (ha : 0 < a) :
    ∃ c : ℤ, 1 ≤ c ∧ a ∣ 2 * (c - 1) := by
  apply Ising3DCut.NecSuf.every_target_has_related_admissible_witness
      (fun c : ℤ => 1 ≤ c)
      (fun a c : ℤ => a ∣ 2 * (c - 1))
      a (a + 1)
  ·
    have h1 : (1 : ℤ) ≤ a := ha
    linarith
  ·
    have hstep : 2 * ((a + 1) - 1) = 2 * a := by ring
    rw [hstep]
    exact Dvd.intro_left 2 rfl

end Ising3DCut.LimitQuantity
