import Ising2DLambda.KacWard.PlaneSimpleCycleTorusProjection

namespace Ising2DLambda.KacWard

/-- The endpoint lemma for the actual projected unit path follows from endpoint compatibility. -/
theorem planeUnitPathTorusProjection_endpoints_from_necSuf (L n : ℕ) [NeZero L]
    (W : Fin (n + 1) → ℤ × ℤ) (j : Fin n)
    (hunit : ∀ k : Fin n,
      W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩ = (0, 1) ∨
      W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩ = (1, 0) ∨
      W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩ = (0, -1) ∨
      W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩ = (-1, 0)) :
    orientedSource (planeUnitPathTorusProjection L n W j) =
        planeVertexProjection L (W ⟨j.val, by omega⟩) ∧
      orientedTarget (planeUnitPathTorusProjection L n W j) =
        planeVertexProjection L (W ⟨j.val + 1, by omega⟩) := by
  have hsource (k : Fin n) :
      orientedSource (projectedUnitStep L (W ⟨k.val, by omega⟩)
        (W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩)) =
        planeVertexProjection L (W ⟨k.val, by omega⟩) :=
    (projectedUnitStep_endpoints L _ _ (hunit k)).1
  have htarget (k : Fin n) :
      orientedTarget (projectedUnitStep L (W ⟨k.val, by omega⟩)
        (W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩)) =
        planeVertexProjection L (W ⟨k.val + 1, by omega⟩) := by
    have h := (projectedUnitStep_endpoints L
      (W ⟨k.val, by omega⟩)
      (W ⟨k.val + 1, by omega⟩ - W ⟨k.val, by omega⟩) (hunit k)).2
    simpa [add_sub_cancel_left] using h
  simpa [planeUnitPathTorusProjection,
    Ising2DLambda.NecSuf.KacWard.finitePathEdgeProjection] using
    (Ising2DLambda.NecSuf.KacWard.finitePathEdgeProjection_endpoints n
      (fun p q : ℤ × ℤ => projectedUnitStep L p (q - p)) W
      (planeVertexProjection L) orientedSource orientedTarget hsource htarget j)

end Ising2DLambda.KacWard
