/-
「平滑化後の横断数は二本の閉歩道の横断数と混合横断数の和である」の必要十分版。
辺・横断・閉歩道は使わず、有限集合を排他的な二つの述語で三つに分けると
元の個数が三つの個数の和になることだけを使う。排他性（両方の述語を同時に
満たす元が無いこと）は、人手証明の「各対は A×A・B×B・混合のちょうど一つに
属する」に対応し、削ると第二の filter が第一と重なって和が過剰になるため必要である。
-/
import Mathlib.Data.Finset.Card

namespace Ising2DLambda.NecSuf.KacWard

/-- 排他的な二つの述語による三分割で、有限集合の個数は三つの個数の和になる。 -/
theorem three_way_filter_card_necSuf {α : Type} (S : Finset α)
    (p q : α → Prop) [DecidablePred p] [DecidablePred q]
    (hpq : ∀ a ∈ S, ¬(p a ∧ q a)) :
    S.card = (S.filter p).card + (S.filter q).card
      + (S.filter fun a => ¬ p a ∧ ¬ q a).card := by
  -- 人手証明の「互いに素な有限集合の分割」を、p での二分割と
  -- その否定側の q での二分割の二段で行う。
  have h1 : (S.filter p).card + (S.filter fun a => ¬ p a).card = S.card :=
    Finset.filter_card_add_filter_neg_card_eq_card (p := p)
  have h2 : ((S.filter fun a => ¬ p a).filter q).card
      + ((S.filter fun a => ¬ p a).filter fun a => ¬ q a).card
      = (S.filter fun a => ¬ p a).card :=
    Finset.filter_card_add_filter_neg_card_eq_card (p := q)
  have h3 : (S.filter fun a => ¬ p a).filter q = S.filter q := by
    ext a
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.2⟩,
      fun h => ⟨⟨h.1, fun hp => hpq a h.1 ⟨hp, h.2⟩⟩, h.2⟩⟩
  have h4 : (S.filter fun a => ¬ p a).filter (fun a => ¬ q a)
      = S.filter fun a => ¬ p a ∧ ¬ q a := by
    ext a
    simp only [Finset.mem_filter]
    exact ⟨fun h => ⟨h.1.1, h.1.2, h.2⟩, fun h => ⟨⟨h.1, h.2.1⟩, h.2.2⟩⟩
  rw [h3, h4] at h2
  omega

end Ising2DLambda.NecSuf.KacWard
