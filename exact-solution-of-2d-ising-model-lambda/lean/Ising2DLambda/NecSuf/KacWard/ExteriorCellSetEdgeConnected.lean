/-
「内側セル集合の補集合は辺連結である」の必要十分版。

格子から切り離すと、必要なのは二つの連結な核が交わり、全ての点がその合併へ
集合内の有限列で到達できることだけである。
-/
import Ising2DLambda.NecSuf.KacWard.InteriorCellSetEdgeConnected

namespace Ising2DLambda.NecSuf.KacWard

/-- 交わる二つの連結な核へ全点が到達できれば、集合全体も非空で連結である。 -/
theorem connected_of_two_connected_cores_and_reaches_necSuf
    {α : Type*} (adj : α → α → Prop)
    (hAdjSymm : ∀ ⦃a b⦄, adj a b → adj b a)
    (S firstCore secondCore : Set α)
    (hfirstSubset : firstCore ⊆ S)
    (hsecondSubset : secondCore ⊆ S)
    (hfirstConnected : ConnectedBy adj firstCore)
    (hsecondConnected : ConnectedBy adj secondCore)
    (hoverlap : ∃ z, z ∈ firstCore ∧ z ∈ secondCore)
    (hreaches : ∀ x ∈ S, ∃ b ∈ firstCore ∪ secondCore,
      Relation.ReflTransGen (fun a b => a ∈ S ∧ b ∈ S ∧ adj a b) x b) :
    S.Nonempty ∧ ConnectedBy adj S := by
  let core := firstCore ∪ secondCore
  have hcoreNonempty : core.Nonempty := by
    obtain ⟨x, hxFirst, -⟩ := hoverlap
    exact ⟨x, Or.inl hxFirst⟩
  have hcoreSubset : core ⊆ S := Set.union_subset hfirstSubset hsecondSubset
  have hcoreConnected : ConnectedBy adj core := by
    intro x hx y hy
    obtain ⟨bridge, hbridgeFirst, hbridgeSecond⟩ := hoverlap
    have liftFirst :
        (fun a b => a ∈ firstCore ∧ b ∈ firstCore ∧ adj a b) ≤
          (fun a b => a ∈ core ∧ b ∈ core ∧ adj a b) := by
      intro a b hab
      exact ⟨Or.inl hab.1, Or.inl hab.2.1, hab.2.2⟩
    have liftSecond :
        (fun a b => a ∈ secondCore ∧ b ∈ secondCore ∧ adj a b) ≤
          (fun a b => a ∈ core ∧ b ∈ core ∧ adj a b) := by
      intro a b hab
      exact ⟨Or.inr hab.1, Or.inr hab.2.1, hab.2.2⟩
    rcases hx with hxFirst | hxSecond
    · rcases hy with hyFirst | hySecond
      · exact (Relation.ReflTransGen.mono liftFirst x y)
          (hfirstConnected hxFirst hyFirst)
      · have hxb := (Relation.ReflTransGen.mono liftFirst x bridge)
            (hfirstConnected hxFirst hbridgeFirst)
        have hby := (Relation.ReflTransGen.mono liftSecond bridge y)
            (hsecondConnected hbridgeSecond hySecond)
        exact hxb.trans hby
    · rcases hy with hyFirst | hySecond
      · have hxb := (Relation.ReflTransGen.mono liftSecond x bridge)
            (hsecondConnected hxSecond hbridgeSecond)
        have hby := (Relation.ReflTransGen.mono liftFirst bridge y)
            (hfirstConnected hbridgeFirst hyFirst)
        exact hxb.trans hby
      · exact (Relation.ReflTransGen.mono liftSecond x y)
          (hsecondConnected hxSecond hySecond)
  exact connected_of_connected_core_and_reaches_necSuf
    adj hAdjSymm S core hcoreNonempty hcoreSubset hcoreConnected hreaches

end Ising2DLambda.NecSuf.KacWard
