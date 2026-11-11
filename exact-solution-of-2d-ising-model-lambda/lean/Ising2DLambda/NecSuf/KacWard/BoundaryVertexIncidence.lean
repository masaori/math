import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- Four binary cell memberships have a nonconstant boundary precisely when
their sum is one, two, or three. -/
theorem boundary_vertex_incidence_necSuf (a b c d : Bool) :
    ((if a then 1 else 0) + (if b then 1 else 0) +
      (if c then 1 else 0) + (if d then 1 else 0) = 1 ∨
    (if a then 1 else 0) + (if b then 1 else 0) +
      (if c then 1 else 0) + (if d then 1 else 0) = 2 ∨
    (if a then 1 else 0) + (if b then 1 else 0) +
      (if c then 1 else 0) + (if d then 1 else 0) = 3) ↔
      a ≠ b ∨ c ≠ d ∨ a ≠ c ∨ b ≠ d := by
  cases a <;> cases b <;> cases c <;> cases d <;> decide

end Ising2DLambda.NecSuf.KacWard
