import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A finite boundary is equivalent to departure positions when every
departure lies on the boundary, every boundary vertex is visited, and the
visited points are distinct. -/
noncomputable def boundary_vertices_equiv_positions
    {I V : Type*} [DecidableEq V]
    (boundary : Finset V) (point : I → V)
    (hmem : ∀ i, point i ∈ boundary)
    (hinj : Function.Injective point)
    (hcover : ∀ v ∈ boundary, ∃ i, point i = v) :
    I ≃ {v // v ∈ boundary} := by
  let f : I → {v // v ∈ boundary} := fun i => ⟨point i, hmem i⟩
  apply Equiv.ofBijective f
  constructor
  · intro i j hij
    apply hinj
    exact congrArg Subtype.val hij
  · intro v
    obtain ⟨i, hi⟩ := hcover v.val v.property
    refine ⟨i, ?_⟩
    apply Subtype.ext
    exact hi

end Ising2DLambda.NecSuf.KacWard
