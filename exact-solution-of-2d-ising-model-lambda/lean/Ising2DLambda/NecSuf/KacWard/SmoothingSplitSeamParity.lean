/-
「二本の閉歩道の切断線偶奇の和は元の切断線偶奇に等しい」の必要十分版。
辺・切断線・閉歩道は使わず、自然数の三つの区間による有限和の分割と
二で割った余りだけを使う。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitTurningSum

namespace Ising2DLambda.NecSuf.KacWard

/-- 二成分の区間和をそれぞれ二で割った余りの和は、全区間の和の余りに等しい。 -/
theorem interval_split_parity_pair_necSuf (horizontal vertical : ℕ → ℕ)
    (m k l : ℕ) (hkl : k ≤ l) (hlm : l ≤ m) :
    (((∑ r ∈ Finset.Ioc k l, horizontal r) % 2
        + ((∑ r ∈ Finset.Ioc l m, horizontal r)
          + ∑ r ∈ Finset.Ioc 0 k, horizontal r) % 2) % 2,
      ((∑ r ∈ Finset.Ioc k l, vertical r) % 2
        + ((∑ r ∈ Finset.Ioc l m, vertical r)
          + ∑ r ∈ Finset.Ioc 0 k, vertical r) % 2) % 2) =
    ((∑ r ∈ Finset.Ioc 0 m, horizontal r) % 2,
      (∑ r ∈ Finset.Ioc 0 m, vertical r) % 2) := by
  have hh := interval_split_sum_necSuf m k l hkl hlm horizontal
  have hv := interval_split_sum_necSuf m k l hkl hlm vertical
  apply Prod.ext <;> simp only <;> omega

end Ising2DLambda.NecSuf.KacWard
