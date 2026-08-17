/-
`claim_leading_distance_lt_iff_close_zero` の必要十分版。

具体版が使う本質は次だけである。
  - 選ばれた値 m は、ある候補点 xi の距離値である（第一条件 → 第二条件で使う）。
  - m の最小性: どの候補点の距離値も、m に等しいか m より大きい（第二条件 → 第一条件で使う）。
  - 比較の推移律（第二の場合で使う）。

体・順序の三分法・有限集合・零元・平方は、この同値の論法自体には要らない。
仮定を落とすと通らない理由:
  - `hmMem` を落とすと mp 方向の証人が取れない。
  - `hmMin` を落とすと mpr 方向で m と距離値を比べられない。
  - `htrans` を落とすと mpr 方向の第二の場合が閉じない。
-/

namespace Ising2DLambda.NecSuf.CriticalExponent

universe u v

theorem min_lt_iff_exists_lt_necSuf
    {P : Type u} {X : Type v}
    (candidate : P → Prop)
    (distance : P → X)
    (lt : X → X → Prop)
    (m t : X)
    (hmMem : ∃ xi, candidate xi ∧ distance xi = m)
    (hmMin : ∀ xi, candidate xi → distance xi = m ∨ lt m (distance xi))
    (htrans : ∀ a b c, lt a b → lt b c → lt a c) :
    lt m t ↔ ∃ xi, candidate xi ∧ lt (distance xi) t := by
  constructor
  · intro h
    obtain ⟨xi, hxi, hdist⟩ := hmMem
    exact ⟨xi, hxi, hdist ▸ h⟩
  · rintro ⟨xi, hxi, hlt⟩
    rcases hmMin xi hxi with heq | hlt2
    · exact heq ▸ hlt
    · exact htrans m (distance xi) t hlt2 hlt

end Ising2DLambda.NecSuf.CriticalExponent
