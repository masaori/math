import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosureSimpleFromWalk
import Ising2DLambda.KacWard.OneSidedClosureNonbacktracking

namespace Ising2DLambda.KacWard

/-- 最大横断水準で切断した実際の閉歩道の一側閉包は、終点を除いて単射である。 -/
theorem oneSidedClosurePointFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      ∀ i < N, ∀ j < N, W i = W j → i = j := by
  obtain ⟨k₀, hmax⟩ := periodicPlaneLiftFromWalk_maximum_cut γ
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hsimple := oneSidedPeriodicLiftClosureFromWalk_injective
    γ hγ hcontact hwind k₀ hmax t c ht hc
  dsimp only at hsimple
  dsimp only
  intro i hi j hj hij
  apply hsimple i (by
    dsimp only [oneSidedClosureLength] at hi
    omega) j (by
    dsimp only [oneSidedClosureLength] at hj
    omega)
  simpa only [oneSidedClosurePoint, periodicPlaneLiftFromWalk,
    Nat.cast_zero, add_zero] using hij

end Ising2DLambda.KacWard
