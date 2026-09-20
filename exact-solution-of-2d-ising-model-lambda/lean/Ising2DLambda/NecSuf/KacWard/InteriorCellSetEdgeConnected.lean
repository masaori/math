/-
「内側セル集合は辺連結である」の必要十分版。

格子から切り離すと、必要なのは連結な非空部分集合があり、全ての点が集合内の有限列で
その部分集合へ到達できることだけである。
-/
import Ising2DLambda.NecSuf.KacWard.WalkSideInteriorBandConnected

namespace Ising2DLambda.NecSuf.KacWard

/-- 連結な非空部分集合へ全ての点が集合内で到達できれば、集合全体も非空で連結である。 -/
theorem connected_of_connected_core_and_reaches_necSuf
    {α : Type*} (adj : α → α → Prop)
    (hAdjSymm : ∀ ⦃a b⦄, adj a b → adj b a)
    (S core : Set α)
    (hcoreNonempty : core.Nonempty)
    (hcoreSubset : core ⊆ S)
    (hcoreConnected : ConnectedBy adj core)
    (hreaches : ∀ x ∈ S, ∃ b ∈ core,
      Relation.ReflTransGen (fun a b => a ∈ S ∧ b ∈ S ∧ adj a b) x b) :
    S.Nonempty ∧ ConnectedBy adj S := by
  obtain ⟨base, hbaseCore⟩ := hcoreNonempty
  have hbaseS : base ∈ S := hcoreSubset hbaseCore
  refine ⟨⟨base, hbaseS⟩, ?_⟩
  intro x hx y hy
  obtain ⟨bx, hbxCore, hxbx⟩ := hreaches x hx
  obtain ⟨bridgeY, hbridgeYCore, hyBridgeY⟩ := hreaches y hy
  have hcorePath :
      Relation.ReflTransGen
        (fun a b => a ∈ core ∧ b ∈ core ∧ adj a b) bx bridgeY :=
    hcoreConnected hbxCore hbridgeYCore
  have hcorePathInS :
      Relation.ReflTransGen
        (fun a b => a ∈ S ∧ b ∈ S ∧ adj a b) bx bridgeY :=
    (Relation.ReflTransGen.mono
      (r := fun a b => a ∈ core ∧ b ∈ core ∧ adj a b)
      (fun _ _ h => ⟨hcoreSubset h.1, hcoreSubset h.2.1, h.2.2⟩)
      bx bridgeY) hcorePath
  let step := fun a b => a ∈ S ∧ b ∈ S ∧ adj a b
  have hreverse : Relation.ReflTransGen (Function.swap step) bridgeY y :=
    (Relation.ReflTransGen.swap (r := step) bridgeY y) hyBridgeY
  have hswap : Function.swap step ≤ step := by
    intro a b hab
    exact ⟨hab.2.1, hab.1, hAdjSymm hab.2.2⟩
  have hbyy : Relation.ReflTransGen step bridgeY y :=
    (Relation.ReflTransGen.mono (r := Function.swap step) hswap bridgeY y) hreverse
  exact hxbx.trans (hcorePathInS.trans hbyy)

end Ising2DLambda.NecSuf.KacWard
