/-
「歩道沿いの内側帯は空でなく辺連結である」の必要十分版。

格子から切り離すと、必要なのは有限個の非空な連結集合が順に交わることだけである。
各集合内の道と、隣り合う集合の共通元を順につなぐ。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 関係 `adj` の辺だけを使って集合 `S` の中で二点を結べること。 -/
def ConnectedBy {α : Type*} (adj : α → α → Prop) (S : Set α) : Prop :=
  ∀ ⦃x⦄, x ∈ S → ∀ ⦃y⦄, y ∈ S →
    Relation.ReflTransGen (fun a b => a ∈ S ∧ b ∈ S ∧ adj a b) x y

/-- 有限鎖をなす非空な連結集合の合併は非空で連結である。 -/
theorem finite_chain_union_connected_necSuf
    {α : Type*} (adj : α → α → Prop)
    (hAdjSymm : ∀ ⦃a b⦄, adj a b → adj b a)
    (n : ℕ) (A : ℕ → Set α) (hn : 0 < n)
    (hnonempty : ∀ k < n, (A k).Nonempty)
    (hconnected : ∀ k < n, ConnectedBy adj (A k))
    (hoverlap : ∀ k, k + 1 < n → ∃ z, z ∈ A k ∧ z ∈ A (k + 1)) :
    let band : Set α := {x | ∃ k < n, x ∈ A k}
    band.Nonempty ∧ ConnectedBy adj band := by
  let band : Set α := {x | ∃ k < n, x ∈ A k}
  have hsubset (k : ℕ) (hk : k < n) : A k ⊆ band := by
    intro x hx
    exact ⟨k, hk, hx⟩
  obtain ⟨base, hbase⟩ := hnonempty 0 hn
  have hbaseBand : base ∈ band := hsubset 0 hn hbase
  have htoBase : ∀ k < n, ∀ ⦃x⦄, x ∈ A k →
      Relation.ReflTransGen
        (fun a b => a ∈ band ∧ b ∈ band ∧ adj a b) x base := by
    intro k
    induction k with
    | zero =>
        intro hk x hx
        exact (Relation.ReflTransGen.mono
          (r := fun a b => a ∈ A 0 ∧ b ∈ A 0 ∧ adj a b)
          (fun (a b : α) h =>
            ⟨hsubset 0 hk h.1, hsubset 0 hk h.2.1, h.2.2⟩) x base)
          (hconnected 0 hk hx hbase)
    | succ k ih =>
        intro hk x hx
        obtain ⟨z, hzPrev, hzNext⟩ := hoverlap k hk
        have hlift :
            (fun a b => a ∈ A (k + 1) ∧ b ∈ A (k + 1) ∧ adj a b) ≤
              (fun a b => a ∈ band ∧ b ∈ band ∧ adj a b) := by
          intro a b h
          exact ⟨hsubset (k + 1) hk h.1, hsubset (k + 1) hk h.2.1, h.2.2⟩
        have hxz := (Relation.ReflTransGen.mono
          (r := fun a b => a ∈ A (k + 1) ∧ b ∈ A (k + 1) ∧ adj a b)
          hlift x z)
          (hconnected (k + 1) hk hx hzNext)
        exact hxz.trans (ih (Nat.lt_of_succ_lt hk) hzPrev)
  refine ⟨⟨base, hbaseBand⟩, ?_⟩
  intro x hx y hy
  obtain ⟨i, hi, hxi⟩ := hx
  obtain ⟨j, hj, hyj⟩ := hy
  have hxb := htoBase i hi hxi
  have hyb := htoBase j hj hyj
  let step := fun a b => a ∈ band ∧ b ∈ band ∧ adj a b
  have hybSwap : Relation.ReflTransGen (Function.swap step) base y :=
    (Relation.ReflTransGen.swap (r := step) base y) hyb
  have hstepSwap : Function.swap step ≤ step := by
    intro a b hab
    exact ⟨hab.2.1, hab.1, hAdjSymm hab.2.2⟩
  have hby : Relation.ReflTransGen step base y :=
    (Relation.ReflTransGen.mono (r := Function.swap step) hstepSwap base y) hybSwap
  exact hxb.trans hby

end Ising2DLambda.NecSuf.KacWard
