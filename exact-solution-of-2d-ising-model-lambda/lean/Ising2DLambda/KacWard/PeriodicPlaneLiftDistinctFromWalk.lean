import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinct
import Ising2DLambda.KacWard.VertexSimplePlaneLiftDistinct
import Ising2DLambda.KacWard.PlaneLift

namespace Ising2DLambda.KacWard

/-- 接触のない実際の閉歩道の周期持ち上げは整数添字について単射である。 -/
theorem periodicPlaneLiftFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    Function.Injective (periodicPlaneLiftFromWalk γ) := by
  have hnonzero : verticalDirectedWindingNumber γ ≠ 0 ∨
      horizontalDirectedWindingNumber γ ≠ 0 := by
    by_contra h
    push Not at h
    exact hwind (Prod.ext h.2 h.1)
  have hbase (k k' : ℤ)
      (heq : residuePoint L
          (planeLiftIntegerBase γ (k % ((m + 1 : ℕ) : ℤ))) =
        residuePoint L
          (planeLiftIntegerBase γ (k' % ((m + 1 : ℕ) : ℤ)))) :
      k % ((m + 1 : ℕ) : ℤ) = k' % ((m + 1 : ℕ) : ℤ) := by
    have hk0 : 0 ≤ k % ((m + 1 : ℕ) : ℤ) := Int.emod_nonneg _ (by omega)
    have hk1 : k % ((m + 1 : ℕ) : ℤ) < m + 1 := Int.emod_lt_of_pos _ (by omega)
    have hk'0 : 0 ≤ k' % ((m + 1 : ℕ) : ℤ) := Int.emod_nonneg _ (by omega)
    have hk'1 : k' % ((m + 1 : ℕ) : ℤ) < m + 1 := Int.emod_lt_of_pos _ (by omega)
    let i : Fin (m + 1) := ⟨(k % ((m + 1 : ℕ) : ℤ)).toNat, by omega⟩
    let j : Fin (m + 1) := ⟨(k' % ((m + 1 : ℕ) : ℤ)).toNat, by omega⟩
    have hki : planeLiftIntegerBase γ (k % ((m + 1 : ℕ) : ℤ)) =
        planeLift γ i.castSucc := by
      unfold planeLiftIntegerBase
      congr 1
      apply Fin.ext
      change (k % ((m + 1 : ℕ) : ℤ)).toNat % (m + 2) = i.val
      rw [Nat.mod_eq_of_lt (by omega)]
    have hkj : planeLiftIntegerBase γ (k' % ((m + 1 : ℕ) : ℤ)) =
        planeLift γ j.castSucc := by
      unfold planeLiftIntegerBase
      congr 1
      apply Fin.ext
      change (k' % ((m + 1 : ℕ) : ℤ)).toNat % (m + 2) = j.val
      rw [Nat.mod_eq_of_lt (by omega)]
    rw [hki, hkj] at heq
    have hvertices : planeLiftVertex γ i.castSucc = planeLiftVertex γ j.castSucc := by
      calc
        planeLiftVertex γ i.castSucc = residuePoint L (planeLift γ i.castSucc) := by
          simpa [residuePoint, PartitionPolynomial.residueProjection] using
            (planeLift_projection γ hγ i).symm
        _ = residuePoint L (planeLift γ j.castSucc) := heq
        _ = planeLiftVertex γ j.castSucc := by
          simpa [residuePoint, PartitionPolynomial.residueProjection] using
            planeLift_projection γ hγ j
    have hij := planeLiftVertex_injective_of_no_contacts γ hγ hcontact hvertices
    have hval := congrArg Fin.val hij
    change (k % ((m + 1 : ℕ) : ℤ)).toNat =
      (k' % ((m + 1 : ℕ) : ℤ)).toNat at hval
    omega
  change Function.Injective (periodicPlaneLift (m + 1) (planeLiftIntegerBase γ) L
    (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ))
  exact periodicPlaneLift_injective (m + 1) L (by omega) (NeZero.pos L)
      (planeLiftIntegerBase γ) (verticalDirectedWindingNumber γ)
      (horizontalDirectedWindingNumber γ) hnonzero hbase

end Ising2DLambda.KacWard
