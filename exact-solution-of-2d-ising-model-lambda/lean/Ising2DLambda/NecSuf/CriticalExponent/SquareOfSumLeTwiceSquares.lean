/-
`claim_square_of_sum_le_twice_sum_of_squares` の必要十分版。

具体版が使う本質は次だけである。
  - 恒等式 (2u²+2v²) − (u+v)² = (u−v)·(u−v)（可換環の分配則・可換則・減法）。
  - u ≠ v から u − v ≠ 0（加法群の性質。CommRing に含まれる）。
  - 「差が零でない元の平方」で定めた狭義順序と、その等号との選言で定めた広義順序。

体・順序の三分法・実閉性は要らない。CommRing より弱くできない理由: 恒等式の変形が
分配則・積の可換則・加法逆元をすべて使う（どれかを落とすと `ring` の三段が書けない）。
-/
import Mathlib.Tactic.Ring
import Ising2DLambda.NecSuf.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.NecSuf.CriticalExponent

open Ising2DLambda.NecSuf.FisherZero

/-- 和の平方は平方和の二倍以下である（差が零でない元の平方、で定めた順序）。 -/
theorem squareOfSum_le_twiceSumOfSquares_necSuf {K : Type} [CommRing K]
    (u v : K) :
    nonstrictOrderOfDifference (fun b a => b - a)
      (fun x => ∃ w : K, w ≠ 0 ∧ x = w * w)
      ((u + v) * (u + v)) (2 * (u * u) + 2 * (v * v)) := by
  by_cases huv : u = v
  · -- u = v なら両辺が等しい（等号の枝）。
    exact Or.inr (by subst huv; ring)
  · -- u ≠ v なら w := u − v ≠ 0 が差の平方の証人（狭義順序の枝）。
    exact Or.inl ⟨u - v, sub_ne_zero.mpr huv, by ring⟩

end Ising2DLambda.NecSuf.CriticalExponent
