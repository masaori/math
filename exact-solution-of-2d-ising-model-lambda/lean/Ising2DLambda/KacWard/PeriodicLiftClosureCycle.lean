/-
章「Onsager 閉形式への接続」の
「接続階段とその周期並進は二つの持ち上げを単純閉路へ閉じる」
（`claim_periodic_lift_closure_is_simple_cycle`）の具体版。

人手証明と同じく、接続階段・移動後の周期持ち上げ・周期並進した
接続階段・元の周期持ち上げの四部分に分ける。共有端点は一方にだけ残し、
各部分内の単射性と六組の像の分離から終点以外の頂点の相異なりを得る。
住処は ℤ だけである。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosureCycle

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 整数格子の四部分を合成した閉路。共有端点は一度だけ数える。 -/
def periodicLiftClosureVertex {I J K M : Type*}
    (connector : I → ℤ × ℤ) (translatedLift : J → ℤ × ℤ)
    (translatedConnector : K → ℤ × ℤ) (originalLift : M → ℤ × ℤ) :
    I ⊕ J ⊕ K ⊕ M → ℤ × ℤ :=
  fourSegmentVertex connector translatedLift translatedConnector originalLift

/-- `claim_periodic_lift_closure_is_simple_cycle`の四部分の合成。 -/
theorem periodicLiftClosure_is_simple_cycle
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
  exact four_segments_form_simple_closed_walk_necSuf
    connector translatedLift translatedConnector originalLift
    hconnector htranslatedLift htranslatedConnector horiginalLift
    h12 h13 h14 h23 h24 h34 start finish hclosed
    (fun p q : ℤ × ℤ => |q.1 - p.1| + |q.2 - p.2| = 1)
    edgeStart edgeFinish hunit

end Ising2DLambda.KacWard
