/-
「右半直線との交差奇偶で定めた内側セルは有限個である」の必要十分版。

格子路そのものから切り離すと、必要なのは各座標方向の四つの境界条件だけである。
矩形の外で交差数が零または偶数なら、交差数が奇数の点は有限矩形に含まれる。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 奇数値を取る点が矩形の外では排除されるなら、その集合は有限である。 -/
theorem odd_support_finite_necSuf
    (count : ℤ × ℤ → ℕ) (rMin rMax cMin cMax : ℤ)
    (rowLower : ∀ r c, r < rMin → count (r, c) = 0)
    (rowUpper : ∀ r c, rMax ≤ r → count (r, c) = 0)
    (colLower : ∀ r c, c < cMin → Even (count (r, c)))
    (colUpper : ∀ r c, cMax ≤ c → count (r, c) = 0) :
    {p : ℤ × ℤ | Odd (count p)}.Finite := by
  apply Set.Finite.subset
    (Set.Finite.prod (Set.finite_Ico rMin rMax) (Set.finite_Ico cMin cMax))
  rintro ⟨r, c⟩ hodd
  have odd_ne_zero {n : ℕ} (hn : Odd n) : n ≠ 0 := by
    rcases hn with ⟨k, hk⟩
    omega
  have odd_not_even {n : ℕ} (ho : Odd n) (he : Even n) : False := by
    rcases ho with ⟨k, hk⟩
    rcases he with ⟨j, hj⟩
    omega
  constructor
  · constructor
    · by_contra h
      exact odd_ne_zero hodd (rowLower r c (lt_of_not_ge h))
    · by_contra h
      exact odd_ne_zero hodd (rowUpper r c (le_of_not_gt h))
  · constructor
    · by_contra h
      exact odd_not_even hodd (colLower r c (lt_of_not_ge h))
    · by_contra h
      exact odd_ne_zero hodd (colUpper r c (le_of_not_gt h))

end Ising2DLambda.NecSuf.KacWard
