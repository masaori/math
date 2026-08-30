/-
「接触点で分けた二本の閉歩道の接触対の個数の和は元より真に小さい」
（`claim_contact_split_pair_descent`）の必要十分版。

辺・閉歩道・接触は使わない。排他的な二つの述語による有限集合の三分割
（`three_way_filter_card_necSuf`）に、どちらの述語も満たさない元が
少なくとも一つ存在するという仮定を足すと、二つの filter の個数の和が
全体の個数より真に小さいことだけを残す。証人の存在は狭義の不等号そのものであり、
削ると等号の場合を除外できないため必要である。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingPartition

namespace Ising2DLambda.NecSuf.KacWard

/-- 排他的な二述語の三分割で、どちらも満たさない証人があれば、
二つの filter の個数の和は全体より真に小さい。 -/
theorem exclusive_split_witness_descent_necSuf {α : Type} (S : Finset α)
    (p q : α → Prop) [DecidablePred p] [DecidablePred q]
    (hpq : ∀ a ∈ S, ¬(p a ∧ q a))
    (w : α) (hw : w ∈ S) (hwp : ¬ p w) (hwq : ¬ q w) :
    (S.filter p).card + (S.filter q).card < S.card := by
  -- 人手証明の「三分割の個数の和」と「混合部分に (k,l) が属するので 1 以上」を結ぶ。
  have hsplit := three_way_filter_card_necSuf S p q hpq
  have hwMixed : w ∈ S.filter (fun a => ¬ p a ∧ ¬ q a) :=
    Finset.mem_filter.mpr ⟨hw, hwp, hwq⟩
  have hpos : 0 < (S.filter fun a => ¬ p a ∧ ¬ q a).card :=
    Finset.card_pos.mpr ⟨w, hwMixed⟩
  omega

end Ising2DLambda.NecSuf.KacWard
