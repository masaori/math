/-
「接触点で分けた二本の閉歩道の接触対の個数の和は元より真に小さい」
（`claim_contact_split_pair_descent`）の具体版。
人手証明と同じく、接触対の集合（添字対 a < b と通過の頂点の一致の filter）を
「両方が区間 (k,l] に属する」「両方が属さない」「一方だけが属する」の三つに分け、
選んだ接触点 (k,l) が混合部分に属することから狭義の不等号を得る。
-/
import Mathlib.Data.Finset.Card
import Mathlib.Order.Interval.Finset.Nat
import Ising2DLambda.NecSuf.KacWard.ContactSplitPairDescent

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem contact_split_pair_descent {V : Type} [DecidableEq V]
    (tgt : ℕ → V) (m k l : ℕ)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m)
    (hcontact : tgt k = tgt l) :
    (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)).card
    < ((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).card := by
  -- 証人は選んだ接触点の添字対 (k, l) である。
  have hwMem : (k, l) ∈ (Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
      (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2) := by
    rw [Finset.mem_filter, Finset.mem_product, Finset.mem_Ioc, Finset.mem_Ioc]
    exact ⟨⟨⟨hk, le_of_lt (lt_of_lt_of_le hkl hlm)⟩, ⟨lt_trans hk hkl, hlm⟩⟩,
      hkl, hcontact⟩
  -- k は区間 (k,l] に属さないので、第一の述語は (k,l) で偽である。
  have hwp : ¬((k, l).1 ∈ Finset.Ioc k l ∧ (k, l).2 ∈ Finset.Ioc k l) := by
    rw [Finset.mem_Ioc, Finset.mem_Ioc]
    omega
  -- l は区間 (k,l] に属するので、第二の述語も (k,l) で偽である。
  have hwq : ¬(¬ (k, l).1 ∈ Finset.Ioc k l ∧ ¬ (k, l).2 ∈ Finset.Ioc k l) := by
    rw [Finset.mem_Ioc, Finset.mem_Ioc]
    omega
  exact exclusive_split_witness_descent_necSuf _
    (fun ab : ℕ × ℕ => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)
    (fun ab : ℕ × ℕ => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)
    (fun ab _ h => h.2.1 h.1.1) (k, l) hwMem hwp hwq

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem contact_split_pair_descent_from_necSuf {V : Type} [DecidableEq V]
    (tgt : ℕ → V) (m k l : ℕ)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m)
    (hcontact : tgt k = tgt l) :
    (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)).card
    < ((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).card :=
  contact_split_pair_descent tgt m k l hk hkl hlm hcontact

end Ising2DLambda.KacWard
