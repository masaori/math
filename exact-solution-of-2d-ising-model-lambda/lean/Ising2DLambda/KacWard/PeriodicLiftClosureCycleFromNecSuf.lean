/- 具体版が必要十分版の整数格子上の四部分閉包への特殊化であることの導出。 -/
import Ising2DLambda.KacWard.PeriodicLiftClosureCycle

namespace Ising2DLambda.KacWard

/-- `claim_periodic_lift_closure_is_simple_cycle` を必要十分版から導いたもの。 -/
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
        |(edgeFinish t).2 - (edgeStart t).2| = 1 :=
  periodicLiftClosure_is_simple_cycle connector translatedLift translatedConnector originalLift
    hconnector htranslatedLift htranslatedConnector horiginalLift
    h12 h13 h14 h23 h24 h34 start finish hclosed edgeStart edgeFinish hunit

end Ising2DLambda.KacWard
