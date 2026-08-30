/-
「二本の閉歩道の循環総回転数の和は元の循環総回転数に等しい」の必要十分版。
辺・回転数・格子は使わず、加法可換モノイドの値と自然数の三つの区間
`(k,l]`・`(l,m]`・`(0,k]` が `(0,m]` を互いに素に覆うことだけを使う。
可換性は三つの区間の和を本文の順（A・B の順）に並べ替えるために要る。
-/
import Mathlib.Algebra.BigOperators.Intervals

namespace Ising2DLambda.NecSuf.KacWard

/-- 区間 `(0,m]` の有限和は、`(k,l]` の和と `(l,m]`・`(0,k]` の和の合併に分かれる。 -/
theorem interval_split_sum_necSuf {M : Type} [AddCommMonoid M]
    (m k l : ℕ) (hkl : k ≤ l) (hlm : l ≤ m) (g : ℕ → M) :
    (∑ r ∈ Finset.Ioc k l, g r)
      + ((∑ r ∈ Finset.Ioc l m, g r) + ∑ r ∈ Finset.Ioc 0 k, g r)
    = ∑ r ∈ Finset.Ioc 0 m, g r := by
  -- 人手証明の「互いに素な有限和の分割」と同じ二回の連結。
  have h1 : (∑ r ∈ Finset.Ioc 0 k, g r) + (∑ r ∈ Finset.Ioc k l, g r)
      = ∑ r ∈ Finset.Ioc 0 l, g r :=
    Finset.sum_Ioc_consecutive g (Nat.zero_le k) hkl
  have h2 : (∑ r ∈ Finset.Ioc 0 l, g r) + (∑ r ∈ Finset.Ioc l m, g r)
      = ∑ r ∈ Finset.Ioc 0 m, g r :=
    Finset.sum_Ioc_consecutive g (Nat.zero_le l) hlm
  calc (∑ r ∈ Finset.Ioc k l, g r)
        + ((∑ r ∈ Finset.Ioc l m, g r) + ∑ r ∈ Finset.Ioc 0 k, g r)
      = ((∑ r ∈ Finset.Ioc 0 k, g r) + (∑ r ∈ Finset.Ioc k l, g r))
          + ∑ r ∈ Finset.Ioc l m, g r := by
        rw [add_comm (∑ r ∈ Finset.Ioc l m, g r) (∑ r ∈ Finset.Ioc 0 k, g r),
          ← add_assoc,
          add_comm (∑ r ∈ Finset.Ioc k l, g r) (∑ r ∈ Finset.Ioc 0 k, g r)]
    _ = (∑ r ∈ Finset.Ioc 0 l, g r) + ∑ r ∈ Finset.Ioc l m, g r := by rw [h1]
    _ = ∑ r ∈ Finset.Ioc 0 m, g r := h2

end Ising2DLambda.NecSuf.KacWard
