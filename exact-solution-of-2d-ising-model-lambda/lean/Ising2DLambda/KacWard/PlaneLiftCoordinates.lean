import Ising2DLambda.KacWard.PlaneLift
import Ising2DLambda.KacWard.EdgeRepresentativeDisplacement

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

/-- The initial source followed by each edge target. -/
def planeLiftVertex {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L) :
    Fin (m + 2) → ZMod L × ZMod L :=
  Fin.cases (orientedSource (γ 0)) (fun k => orientedTarget (γ k))

/-- Signed vertical seam crossings before a lift point. -/
def verticalPrefix {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (k : Fin (m + 2)) : ℤ :=
  ∑ t ∈ Finset.range k.val,
    (verticalSeamParity (γ (Fin.ofNat (m + 1) t)) : ℤ) *
      (1 - 2 * ((γ (Fin.ofNat (m + 1) t)).2.toNat : ℤ))

/-- Signed horizontal seam crossings before a lift point. -/
def horizontalPrefix {L m : ℕ} (γ : Fin (m + 1) → OrientedEdge L)
    (k : Fin (m + 2)) : ℤ :=
  ∑ t ∈ Finset.range k.val,
    (horizontalSeamParity (γ (Fin.ofNat (m + 1) t)) : ℤ) *
      (1 - 2 * ((γ (Fin.ofNat (m + 1) t)).2.toNat : ℤ))

theorem planeLiftVertex_succ_source {L m : ℕ}
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : nonbacktrackingEdgeSequence γ)
    (k : Fin (m + 1)) : planeLiftVertex γ k.castSucc = orientedSource (γ k) := by
  induction k using Fin.cases with
  | zero => rfl
  | succ j =>
    change orientedTarget (γ j.castSucc) = orientedSource (γ j.succ)
    exact (Finset.mem_filter.mp (hγ j)).2.1

/-- `claim_plane_lift_coordinates` for the actual nonbacktracking edge sequence. -/
theorem planeLift_coordinates {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : nonbacktrackingEdgeSequence γ)
    (k : Fin (m + 2)) :
    planeLift γ k =
      (residueRepresentative L (planeLiftVertex γ k).1 + (L : ℤ) * verticalPrefix γ k,
       residueRepresentative L (planeLiftVertex γ k).2 + (L : ℤ) * horizontalPrefix γ k) := by
  induction k using Fin.induction with
  | zero =>
    simp [planeLift_zero, planeLiftVertex, verticalPrefix, horizontalPrefix,
      residueRepresentative]
  | succ k ih =>
    have hsrc := planeLiftVertex_succ_source γ hγ k
    have hstep := edge_representative_displacement L (γ k)
    have hv : verticalPrefix γ k.succ = verticalPrefix γ k.castSucc +
        (verticalSeamParity (γ k) : ℤ) * (1 - 2 * ((γ k).2.toNat : ℤ)) := by
      simp [verticalPrefix, Finset.sum_range_succ]
    have hh : horizontalPrefix γ k.succ = horizontalPrefix γ k.castSucc +
        (horizontalSeamParity (γ k) : ℤ) * (1 - 2 * ((γ k).2.toNat : ℤ)) := by
      simp [horizontalPrefix, Finset.sum_range_succ]
    rw [planeLift_succ, ih, hv, hh]
    have htarget : planeLiftVertex γ k.succ = orientedTarget (γ k) := rfl
    rw [hsrc, htarget]
    apply Prod.ext <;> dsimp [Prod.fst, Prod.snd]
    · have hr := congrArg Prod.fst hstep
      dsimp at hr
      nlinarith
    · have hc := congrArg Prod.snd hstep
      dsimp at hc
      nlinarith

end Ising2DLambda.KacWard
