/-
「低温展開の自明セクター表示」の必要十分版。
具体版の添字の取り替えと同じく、有限集合の間の写像が両向きに往復し、
重みがその写像で保存されることだけを使う。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 互いに逆な写像が重みを保つなら、二つの有限和は等しい。 -/
theorem weighted_sum_eq_of_inverse_necSuf
    {A B M : Type*} [DecidableEq A] [DecidableEq B] [AddCommMonoid M]
    (source : Finset A) (target : Finset B)
    (forward : A → B) (backward : B → A)
    (hforward : ∀ a ∈ source, forward a ∈ target)
    (hbackward : ∀ b ∈ target, backward b ∈ source)
    (hleft : ∀ a ∈ source, backward (forward a) = a)
    (hright : ∀ b ∈ target, forward (backward b) = b)
    (sourceWeight : A → M) (targetWeight : B → M)
    (hweight : ∀ a ∈ source, sourceWeight a = targetWeight (forward a)) :
    ∑ a ∈ source, sourceWeight a = ∑ b ∈ target, targetWeight b := by
  exact Finset.sum_nbij' forward backward hforward hbackward hleft hright hweight

end Ising2DLambda.NecSuf.FisherZero
