import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- A lift whose projection is a simple cyclic vertex sequence is itself simple. -/
theorem lift_points_injective_of_projected_vertices_injective
    {I P V : Type*} (p : I → P) (v : I → V) (π : P → V)
    (hproj : ∀ i, π (p i) = v i) (hv : Function.Injective v) :
    Function.Injective p := by
  intro i j hij
  apply hv
  calc
    v i = π (p i) := (hproj i).symm
    _ = π (p j) := congrArg π hij
    _ = v j := hproj j

end Ising2DLambda.NecSuf.KacWard
