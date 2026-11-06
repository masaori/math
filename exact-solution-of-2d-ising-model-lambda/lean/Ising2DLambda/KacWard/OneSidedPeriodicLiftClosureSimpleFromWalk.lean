import Ising2DLambda.KacWard.OneSidedPeriodicLiftClosureSimple
import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinctFromWalk
import Ising2DLambda.KacWard.OneSidedClosureStaircaseInjectiveFromWalk
import Ising2DLambda.KacWard.OneSidedParallelReturnFromWalk
import Ising2DLambda.KacWard.OneSidedParallelReturnAvoidsPeriodicLiftFromWalk
import Ising2DLambda.KacWard.OneSidedStaircasesAvoidPeriodicLiftFromWalk
import Ising2DLambda.KacWard.OneSidedStaircasesDisjointFromWalk
import Ising2DLambda.KacWard.OneSidedParallelReturnAvoidsStaircasesFromWalk

namespace Ising2DLambda.KacWard

/-- 実際の閉歩道から作った一側閉包は、終点を除いて頂点を繰り返さない。 -/
theorem oneSidedPeriodicLiftClosureFromWalk_injective {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0))
    (k₀ : ℤ)
    (hmax : ∀ i : ℕ,
      windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ (k₀ + i)) ≤
        windingTransverseCoordinateFromWalk γ (periodicPlaneLiftFromWalk γ k₀))
    (t c : ℕ) (ht : 0 < t) (hc : 0 < c) :
    let wh := horizontalDirectedWindingNumber γ
    let wv := verticalDirectedWindingNumber γ
    let S := periodicPlaneLiftFromWalk γ k₀
    let b := t * (wh.natAbs + wv.natAbs)
    let n := L * wh.natAbs + L * wv.natAbs
    let period := fun i : ℕ => periodicPlaneLiftFromWalk γ (k₀ + i)
    let upper := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
    let parallel := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
    let lower := iteratedTransverseStaircase wh wv S
    ∀ i < c * (m + 1) + 2 * b + c * n,
      ∀ j < c * (m + 1) + 2 * b + c * n,
        oneSidedPeriodicLiftClosure period upper parallel lower
            (c * (m + 1)) b (c * n) i =
          oneSidedPeriodicLiftClosure period upper parallel lower
            (c * (m + 1)) b (c * n) j → i = j := by
  dsimp only
  let wh := horizontalDirectedWindingNumber γ
  let wv := verticalDirectedWindingNumber γ
  let S := periodicPlaneLiftFromWalk γ k₀
  let b := t * (wh.natAbs + wv.natAbs)
  let n := L * wh.natAbs + L * wv.natAbs
  let period := fun i : ℕ => periodicPlaneLiftFromWalk γ (k₀ + i)
  let upper := iteratedTransverseStaircase wh wv (S + c • windingShift L wv wh)
  let parallel := oneSidedParallelReturn L wh wv (S + t • (wh, -wv)) c
  let lower := iteratedTransverseStaircase wh wv S
  have hstairs := oneSidedClosureStaircasesFromWalk_injective γ k₀ t c hwind
  have hperiod := oneSidedPeriodicPartFromWalk_injective γ hγ hcontact hwind k₀ c
  have hparallel := oneSidedParallelReturnFromWalk_injective γ hwind k₀ t c
  have hperiodParallel := oneSidedParallelReturnFromWalk_avoids_periodicLift
    γ hwind k₀ hmax t c ht
  have hperiodStairs := oneSidedStaircasesFromWalk_avoid_periodicLift
    γ hγ hcontact hwind k₀ hmax t c
  have hstairsDisjoint := oneSidedStaircasesFromWalk_disjoint γ hwind k₀ t c ht hc
  have hparallelStairs := oneSidedParallelReturnFromWalk_avoids_staircases
    γ hwind k₀ t c
  dsimp only [period, upper, parallel, lower, b, n, wh, wv, S] at *
  exact oneSidedPeriodicLiftClosure_injective period upper parallel lower
    (c * (m + 1)) b (c * n)
    hperiod
    (fun i hi j hj hij => hstairs.1 i j hi hj hij)
    (fun i _ j _ hij => hparallel hij)
    (fun i hi hib j hj hjb hij => hstairs.2 i j hi hib hj hjb hij)
    hperiodStairs.1 hperiodParallel hperiodStairs.2
    hparallelStairs.1
    (fun i hi j hj hjb => hstairsDisjoint i j (Nat.le_of_lt hi) hjb)
    hparallelStairs.2

end Ising2DLambda.KacWard
