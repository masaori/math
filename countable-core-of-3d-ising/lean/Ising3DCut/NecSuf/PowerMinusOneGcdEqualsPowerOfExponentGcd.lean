import Mathlib

/-!
具体的な冪差・整数・最大公約数を落とすと、二項演算で同じ値へ到達したことと、
同じ二値への二項演算を一値へ正規化できることだけが残る。
-/

namespace Ising3DCut.NecSuf

theorem combine_eq_normalize_of_reaches_self
    {α β : Type*} (combine : α → α → β) (normalize : α → β)
    (left right reached : α)
    (reaches : combine left right = combine reached reached)
    (self_eq : combine reached reached = normalize reached) :
    combine left right = normalize reached := by
  calc
    combine left right = combine reached reached := reaches
    _ = normalize reached := self_eq

end Ising3DCut.NecSuf
