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
  -- S を A×A、B×B、混合対へ分け、混合対に (k,l) が属することを使う。
  let S := (Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
    (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)
  let p : ℕ × ℕ → Prop := fun ab => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l
  let q : ℕ × ℕ → Prop := fun ab => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l
  have hpq : ∀ ab ∈ S, ¬ (p ab ∧ q ab) := by
    intro ab _ h
    exact h.2.1 h.1.1
  have hfirst : (S.filter p).card + (S.filter fun ab => ¬ p ab).card = S.card :=
    Finset.card_filter_add_card_filter_not (p := p)
  have hsecond : ((S.filter fun ab => ¬ p ab).filter q).card
      + ((S.filter fun ab => ¬ p ab).filter fun ab => ¬ q ab).card
      = (S.filter fun ab => ¬ p ab).card :=
    Finset.card_filter_add_card_filter_not (p := q)
  have hq : (S.filter fun ab => ¬ p ab).filter q = S.filter q := by
    ext ab
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.2⟩,
      fun h => ⟨⟨h.1, fun hp => hpq ab h.1 ⟨hp, h.2⟩⟩, h.2⟩⟩
  have hmixed : (S.filter fun ab => ¬ p ab).filter (fun ab => ¬ q ab)
      = S.filter fun ab => ¬ p ab ∧ ¬ q ab := by
    ext ab
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.1.2, h.2⟩,
      fun h => ⟨⟨h.1, h.2.1⟩, h.2.2⟩⟩
  rw [hq, hmixed] at hsecond
  have hwMixed : (k, l) ∈ S.filter (fun ab => ¬ p ab ∧ ¬ q ab) :=
    Finset.mem_filter.mpr ⟨hwMem, hwp, hwq⟩
  have hpositive : 0 < (S.filter fun ab => ¬ p ab ∧ ¬ q ab).card :=
    Finset.card_pos.mpr ⟨(k, l), hwMixed⟩
  change (S.filter p).card + (S.filter q).card < S.card
  omega

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
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).card := by
  have hwMem : (k, l) ∈ (Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
      (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2) := by
    rw [Finset.mem_filter, Finset.mem_product, Finset.mem_Ioc, Finset.mem_Ioc]
    exact ⟨⟨⟨hk, le_of_lt (lt_of_lt_of_le hkl hlm)⟩, ⟨lt_trans hk hkl, hlm⟩⟩,
      hkl, hcontact⟩
  exact Ising2DLambda.NecSuf.KacWard.exclusive_split_witness_descent_necSuf _
    (fun ab : ℕ × ℕ => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)
    (fun ab : ℕ × ℕ => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)
    (fun ab _ h => h.2.1 h.1.1) (k, l) hwMem
    (by rw [Finset.mem_Ioc, Finset.mem_Ioc]; omega)
    (by rw [Finset.mem_Ioc, Finset.mem_Ioc]; omega)

end Ising2DLambda.KacWard
