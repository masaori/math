/- 具体版が必要十分版の整数格子上の四部分閉包への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.PeriodicLiftClosureCycle
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosureCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 具体版の四部分の合成は、必要十分版の合成を整数格子へ特殊化したものに一致する。 -/
theorem periodicLiftClosureVertex_eq_necSuf {I J K M : Type*}
    (connector : I → ℤ × ℤ) (translatedLift : J → ℤ × ℤ)
    (translatedConnector : K → ℤ × ℤ) (originalLift : M → ℤ × ℤ) :
    periodicLiftClosureVertex connector translatedLift translatedConnector originalLift =
      fourSegmentVertex connector translatedLift translatedConnector originalLift := by
  funext x
  rcases x with i | j | k | m <;> rfl

/-- `claim_periodic_lift_closure_is_simple_cycle` を必要十分版から導いたもの。
許容される一歩を単位格子辺に特殊化する。 -/
theorem periodicLiftClosure_is_simple_cycle_from_necSuf
    {I J K M T : Type*}
    (connector : I → ℤ × ℤ) (translatedLift : J → ℤ × ℤ)
    (translatedConnector : K → ℤ × ℤ) (originalLift : M → ℤ × ℤ)
    (hconnector : Function.Injective connector)
    (htranslatedLift : Function.Injective translatedLift)
    (htranslatedConnector : Function.Injective translatedConnector)
    (horiginalLift : Function.Injective originalLift)
    (h12 : ∀ i j, connector i ≠ translatedLift j)
    (h13 : ∀ i j, connector i ≠ translatedConnector j)
    (h14 : ∀ i j, connector i ≠ originalLift j)
    (h23 : ∀ i j, translatedLift i ≠ translatedConnector j)
    (h24 : ∀ i j, translatedLift i ≠ originalLift j)
    (h34 : ∀ i j, translatedConnector i ≠ originalLift j)
    (start finish : ℤ × ℤ) (hclosed : finish = start)
    (edgeStart edgeFinish : T → ℤ × ℤ)
    (hunit : ∀ t,
      |(edgeFinish t).1 - (edgeStart t).1| +
        |(edgeFinish t).2 - (edgeStart t).2| = 1) :
    Function.Injective
        (periodicLiftClosureVertex connector translatedLift translatedConnector originalLift) ∧
      finish = start ∧
      ∀ t, |(edgeFinish t).1 - (edgeStart t).1| +
        |(edgeFinish t).2 - (edgeStart t).2| = 1 := by
  rw [periodicLiftClosureVertex_eq_necSuf]
  exact four_segments_form_simple_closed_walk_necSuf
    connector translatedLift translatedConnector originalLift
    hconnector htranslatedLift htranslatedConnector horiginalLift
    h12 h13 h14 h23 h24 h34 start finish hclosed
    (fun p q : ℤ × ℤ => |q.1 - p.1| + |q.2 - p.2| = 1)
    edgeStart edgeFinish hunit

end Ising2DLambda.KacWard
