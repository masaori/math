/-
人手証明「末尾で点数乗表示が成り立つ正の有理点は 1 に限られる」
（ラベル `claim_eventual_power_form_only_at_one`）の Lean 必要十分版。

具体版から有限箱・分配多項式・多重度・点数・有理数・点数乗という形をすべて落とすと、
残るのは次の二つだけである。

* 性質を満たす対象の候補が三つに尽きていること（三択）。
* そのうち二つで性質が成り立たないこと（二つの不可能性）。

三つ目が実際に性質を満たすことは、この論法には要らない（要るのは逆向きの主張の側であり、
そこは別の定理が担う）。逆に、候補が三つであることも本質ではないので、
有限集合に属するという形の一般版も併せて置く。
-/

namespace Ising3DCut.NecSuf

/-- 三択と二つの不可能性から残る一点を決める。台となる型にも性質にも構造を要求しない。 -/
theorem eq_of_three_candidates_of_two_impossible
    {α : Sort _} {P : α → Prop} {q a b c : α}
    (hq : P q) (hcandidates : q = a ∨ q = b ∨ q = c)
    (ha : ¬ P a) (hc : ¬ P c) :
    q = b := by
  rcases hcandidates with h | h | h
  · exact absurd (h ▸ hq) ha
  · exact h
  · exact absurd (h ▸ hq) hc

/-- 候補が有限集合に属し、その中で性質を満たすものが一意ならば、その一点に決まる。
上の三択版はこの形の特別な場合である。 -/
theorem eq_of_candidates_of_unique
    {α : Sort _} {P : α → Prop} {q b : α}
    (hq : P q) (hunique : ∀ x, P x → x = b) :
    q = b :=
  hunique q hq

end Ising3DCut.NecSuf
