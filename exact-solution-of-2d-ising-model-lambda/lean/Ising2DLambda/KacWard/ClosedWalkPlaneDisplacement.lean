import Ising2DLambda.KacWard.PlaneLiftCoordinates
import Ising2DLambda.KacWard.DirectedWindingNumbers

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial

private theorem closed_representative_sum (n : ℕ) (L : ℤ)
    (r : Fin (n + 1) → ℤ) (d c : Fin n → ℤ)
    (hclose : r (Fin.last n) = r 0)
    (hstep : ∀ k : Fin n,
      r k.succ - r k.castSucc = d k - L * c k) :
    (∑ k : Fin n, d k) = L * ∑ k : Fin n, c k := by
  have hsum : ∑ k : Fin n, (d k - L * c k) = 0 := by
    calc
      _ = ∑ k : Fin n, (r k.succ - r k.castSucc) := by
        apply Finset.sum_congr rfl
        intro k _
        exact (hstep k).symm
      _ = ∑ k : Fin n,
          (r (Fin.ofNat (n + 1) (k.val + 1)) - r (Fin.ofNat (n + 1) k.val)) := by
        apply Finset.sum_congr rfl
        intro k _
        congr 1 <;> apply congrArg r <;> apply Fin.ext <;>
          simp [Fin.ofNat, Nat.mod_eq_of_lt, k.isLt, Nat.lt_succ_of_lt k.isLt]
      _ = ∑ k ∈ Finset.range n,
          (r (Fin.ofNat (n + 1) (k + 1)) - r (Fin.ofNat (n + 1) k)) := by
        exact Fin.sum_univ_eq_sum_range
          (fun k : ℕ =>
            r (Fin.ofNat (n + 1) (k + 1)) - r (Fin.ofNat (n + 1) k)) n
      _ = r (Fin.last n) - r 0 := by
        have ht := Finset.sum_range_sub
          (fun k : ℕ => r (Fin.ofNat (n + 1) k)) n
        have hlast : Fin.ofNat (n + 1) n = Fin.last n := by
          apply Fin.ext
          simp [Fin.ofNat]
        have hzero : Fin.ofNat (n + 1) 0 = 0 := by
          apply Fin.ext
          simp [Fin.ofNat]
        simpa only [hlast, hzero] using ht
      _ = 0 := by rw [hclose]; ring
  simp only [Finset.sum_sub_distrib, ← Finset.mul_sum] at hsum
  omega

/-- `claim_closed_walk_plane_displacement` for an actual closed nonbacktracking walk. -/
theorem closedWalk_planeDisplacement {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ) :
    (∑ k : Fin (m + 1), (orientedEdgeLatticeStep (γ k)).1 =
        (L : ℤ) * verticalDirectedWindingNumber γ) ∧
    (∑ k : Fin (m + 1), (orientedEdgeLatticeStep (γ k)).2 =
        (L : ℤ) * horizontalDirectedWindingNumber γ) := by
  have hclose : planeLiftVertex γ (Fin.last (m + 1)) = planeLiftVertex γ 0 := by
    change orientedTarget (γ (Fin.last m)) = orientedSource (γ 0)
    exact (Finset.mem_filter.mp hγ.2).2.1
  have hrow (k : Fin (m + 1)) :
      residueRepresentative L (planeLiftVertex γ k.succ).1 -
          residueRepresentative L (planeLiftVertex γ k.castSucc).1 =
        (orientedEdgeLatticeStep (γ k)).1 -
          (L : ℤ) * ((verticalSeamParity (γ k) : ℤ) *
            (1 - 2 * ((γ k).2.toNat : ℤ))) := by
    rw [planeLiftVertex_succ_source γ hγ.1 k]
    change residueRepresentative L (orientedTarget (γ k)).1 -
      residueRepresentative L (orientedSource (γ k)).1 = _
    have h := congrArg Prod.fst (edge_representative_displacement L (γ k))
    simpa only [mul_assoc] using h
  have hcol (k : Fin (m + 1)) :
      residueRepresentative L (planeLiftVertex γ k.succ).2 -
          residueRepresentative L (planeLiftVertex γ k.castSucc).2 =
        (orientedEdgeLatticeStep (γ k)).2 -
          (L : ℤ) * ((horizontalSeamParity (γ k) : ℤ) *
            (1 - 2 * ((γ k).2.toNat : ℤ))) := by
    rw [planeLiftVertex_succ_source γ hγ.1 k]
    change residueRepresentative L (orientedTarget (γ k)).2 -
      residueRepresentative L (orientedSource (γ k)).2 = _
    have h := congrArg Prod.snd (edge_representative_displacement L (γ k))
    simpa only [mul_assoc] using h
  constructor
  · have h := closed_representative_sum
      (m + 1) (L : ℤ)
      (fun k => residueRepresentative L (planeLiftVertex γ k).1)
      (fun k => (orientedEdgeLatticeStep (γ k)).1)
      (fun k => (verticalSeamParity (γ k) : ℤ) *
        (1 - 2 * ((γ k).2.toNat : ℤ)))
      (congrArg (fun p => residueRepresentative L p.1) hclose) hrow
    simpa only [verticalDirectedWindingNumber] using h
  · have h := closed_representative_sum
      (m + 1) (L : ℤ)
      (fun k => residueRepresentative L (planeLiftVertex γ k).2)
      (fun k => (orientedEdgeLatticeStep (γ k)).2)
      (fun k => (horizontalSeamParity (γ k) : ℤ) *
        (1 - 2 * ((γ k).2.toNat : ℤ)))
      (congrArg (fun p => residueRepresentative L p.2) hclose) hcol
    simpa only [horizontalDirectedWindingNumber] using h

end Ising2DLambda.KacWard
