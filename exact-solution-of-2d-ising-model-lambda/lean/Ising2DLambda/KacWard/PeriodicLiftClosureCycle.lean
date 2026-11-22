/-
章「Onsager 閉形式への接続」の
「接続階段とその周期並進は二つの持ち上げを単純閉路へ閉じる」
（`claim_periodic_lift_closure_is_simple_cycle`）の具体版。

人手証明と同じく、接続階段・移動後の周期持ち上げ・周期並進した
接続階段・元の周期持ち上げの四部分に分ける。共有端点は一方にだけ残し、
各部分内の単射性と六組の像の分離から終点以外の頂点の相異なりを得る。
住処は ℤ だけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 整数格子の四部分を合成した閉路。共有端点は一度だけ数える。 -/
def periodicLiftClosureVertex {I J K M : Type*}
    (connector : I → ℤ × ℤ) (translatedLift : J → ℤ × ℤ)
    (translatedConnector : K → ℤ × ℤ) (originalLift : M → ℤ × ℤ) :
    I ⊕ J ⊕ K ⊕ M → ℤ × ℤ
  | Sum.inl i => connector i
  | Sum.inr (Sum.inl j) => translatedLift j
  | Sum.inr (Sum.inr (Sum.inl k)) => translatedConnector k
  | Sum.inr (Sum.inr (Sum.inr m)) => originalLift m

/-- 四部分の合成の頂点の相異なり。同じ部分の二頂点は部分の単射性で、
異なる部分の二頂点は六組の像の分離で相異なる。 -/
theorem periodicLiftClosureVertex_injective
    {I J K M : Type*}
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
    (h34 : ∀ i j, translatedConnector i ≠ originalLift j) :
    Function.Injective
      (periodicLiftClosureVertex connector translatedLift translatedConnector originalLift) := by
  intro x y hxy
  rcases x with i | j | k | m <;> rcases y with i' | j' | k' | m' <;>
    simp only [periodicLiftClosureVertex] at hxy
  · rw [hconnector hxy]
  · exact absurd hxy (h12 i j')
  · exact absurd hxy (h13 i k')
  · exact absurd hxy (h14 i m')
  · exact absurd hxy.symm (h12 i' j)
  · rw [htranslatedLift hxy]
  · exact absurd hxy (h23 j k')
  · exact absurd hxy (h24 j m')
  · exact absurd hxy.symm (h13 i' k)
  · exact absurd hxy.symm (h23 j' k)
  · rw [htranslatedConnector hxy]
  · exact absurd hxy (h34 k m')
  · exact absurd hxy.symm (h14 i' m)
  · exact absurd hxy.symm (h24 j' m)
  · exact absurd hxy.symm (h34 k' m)
  · rw [horiginalLift hxy]

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
        |(edgeFinish t).2 - (edgeStart t).2| = 1 :=
  ⟨periodicLiftClosureVertex_injective connector translatedLift translatedConnector originalLift
      hconnector htranslatedLift htranslatedConnector horiginalLift h12 h13 h14 h23 h24 h34,
    hclosed, hunit⟩

end Ising2DLambda.KacWard
