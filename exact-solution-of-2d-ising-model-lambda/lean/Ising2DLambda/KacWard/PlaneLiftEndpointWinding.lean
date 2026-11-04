import Ising2DLambda.KacWard.ClosedWalkPlaneDisplacement

namespace Ising2DLambda.KacWard

private theorem finite_lift_endpoint (n : ℕ) (p : Fin (n + 1) → ℤ) (d : Fin n → ℤ)
    (hstep : ∀ k : Fin n, p k.succ = p k.castSucc + d k) :
    p (Fin.last n) = p 0 + ∑ k : Fin n, d k := by
  have hsum : (∑ k : Fin n, d k) = p (Fin.last n) - p 0 := by
    calc
      _ = ∑ k : Fin n, (p k.succ - p k.castSucc) := by
        apply Finset.sum_congr rfl
        intro k _
        have h := hstep k
        omega
      _ = ∑ k ∈ Finset.range n,
          (p (Fin.ofNat (n + 1) (k + 1)) - p (Fin.ofNat (n + 1) k)) := by
        rw [← Fin.sum_univ_eq_sum_range]
        apply Finset.sum_congr rfl
        intro k _
        congr 1 <;> apply congrArg p <;> apply Fin.ext <;>
          simp [Fin.ofNat, Nat.mod_eq_of_lt, k.isLt, Nat.lt_succ_of_lt k.isLt]
      _ = p (Fin.last n) - p 0 := by
        have ht := Finset.sum_range_sub (fun k : ℕ => p (Fin.ofNat (n + 1) k)) n
        have hlast : Fin.ofNat (n + 1) n = Fin.last n := by
          apply Fin.ext
          simp [Fin.ofNat]
        have hzero : Fin.ofNat (n + 1) 0 = 0 := by
          apply Fin.ext
          simp [Fin.ofNat]
        simpa only [hlast, hzero] using ht
  omega

/-- `claim_plane_lift_endpoint_winding` for the actual closed walk and lift. -/
theorem planeLift_endpoint_winding {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L) (hγ : closedNonbacktrackingWalk γ) :
    planeLift γ (Fin.last (m + 1)) = planeLift γ 0 +
      ((L : ℤ) * verticalDirectedWindingNumber γ,
        (L : ℤ) * horizontalDirectedWindingNumber γ) := by
  have hw := closedWalk_planeDisplacement γ hγ
  have hrow := finite_lift_endpoint (m + 1) (fun k => (planeLift γ k).1)
    (fun k => (orientedEdgeLatticeStep (γ k)).1)
    (fun k => congrArg Prod.fst (planeLift_succ γ k))
  have hcol := finite_lift_endpoint (m + 1) (fun k => (planeLift γ k).2)
    (fun k => (orientedEdgeLatticeStep (γ k)).2)
    (fun k => congrArg Prod.snd (planeLift_succ γ k))
  apply Prod.ext
  · simpa only [Prod.fst_add, hw.1] using hrow
  · simpa only [Prod.snd_add, hw.2] using hcol

end Ising2DLambda.KacWard
