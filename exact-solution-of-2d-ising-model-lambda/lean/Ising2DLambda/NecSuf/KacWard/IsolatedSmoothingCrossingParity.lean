/-
「孤立した一つの横断を平滑化すると横断数が一つ減る」
（`claim_isolated_smoothing_crossing_number_update`）の必要十分版。

人手証明が使うのは、平滑化後の関係が選択した順序なし対だけを元の関係から
除いたものであること、選択した対が元の関係に属すること、添字の全順序だけである。
-/
import Mathlib.Data.Finset.Prod

namespace Ising2DLambda.NecSuf.KacWard

/-- 関係 `r` から順序なし対 `{a,b}` だけを除いた関係。 -/
def removeUnorderedPair {ι : Type} [DecidableEq ι] (r : ι → ι → Prop)
    (a b i j : ι) : Prop :=
  r i j ∧ ¬((i = a ∧ j = b) ∨ (i = b ∧ j = a))

instance {ι : Type} [DecidableEq ι] (r : ι → ι → Prop) [DecidableRel r]
    (a b : ι) : DecidableRel (removeUnorderedPair r a b) := by
  intro i j
  unfold removeUnorderedPair
  infer_instance

/-- 有限な全順序集合上で、関係から実在する順序なし対を一つ除くと、
`i < j` で数えた元の個数は除去後の個数より一つ多い。 -/
theorem remove_unordered_pair_card_add_one_necSuf {ι : Type} [LinearOrder ι]
    (s : Finset ι) (r : ι → ι → Prop) [DecidableRel r]
    (a b : ι) (ha : a ∈ s) (hb : b ∈ s) (hab : a < b) (hr : r a b) :
    ((s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2).card
      = ((s ×ˢ s).filter fun p =>
          p.1 < p.2 ∧ removeUnorderedPair r a b p.1 p.2).card + 1 := by
  let before := (s ×ˢ s).filter fun p => p.1 < p.2 ∧ r p.1 p.2
  have hab_mem : (a, b) ∈ before := by
    exact Finset.mem_filter.mpr
      ⟨Finset.mem_product.mpr ⟨ha, hb⟩, hab, hr⟩
  have hafter :
      ((s ×ˢ s).filter fun p =>
          p.1 < p.2 ∧ removeUnorderedPair r a b p.1 p.2)
        = before.erase (a, b) := by
    ext p
    rcases p with ⟨i, j⟩
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_erase,
      before, removeUnorderedPair]
    constructor
    · rintro ⟨⟨hi, hj⟩, hij, hrij, hremove⟩
      refine ⟨?_, ⟨⟨hi, hj⟩, hij, hrij⟩⟩
      intro heq
      exact hremove (Or.inl ⟨congrArg Prod.fst heq, congrArg Prod.snd heq⟩)
    · rintro ⟨hne, ⟨⟨hi, hj⟩, hij, hrij⟩⟩
      refine ⟨⟨hi, hj⟩, hij, hrij, ?_⟩
      rintro (heq | heq)
      · exact hne (Prod.ext heq.1 heq.2)
      · obtain ⟨hia, hjb⟩ := heq
        subst i
        subst j
        exact (lt_asymm hij hab).elim
  have hcard_pos : 0 < before.card := Finset.card_pos.mpr ⟨(a, b), hab_mem⟩
  rw [hafter, Finset.card_erase_of_mem hab_mem]
  change before.card = before.card - 1 + 1
  exact (Nat.sub_add_cancel hcard_pos).symm

end Ising2DLambda.NecSuf.KacWard
