/-
章「Onsager 閉形式への接続」の「閉包の周期数の一般化」の具体版。

人手証明で周期数 c ≥ 1 を導入した箇所に対応し、整数格子の非零な一周期
並進 Bγ の c 倍が非零であることと、閉包の四部分の長さを固定する。
住処は ℕ と ℤ だけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 正の周期数 `c` による整数格子の周期並進は、どの点も元の位置へ戻さない。
非零な座標を一つ選び、その座標で `point + c • period = point` から
`c • period = 0` を得て、整数の積が零なら因子が零であることに反する。 -/
theorem positivePeriodicMultiple_movesPoint
    (period point : ℤ × ℤ) (c : ℕ) (hperiod : period ≠ (0, 0)) (hc : 1 ≤ c) :
    (point.1 + c • period.1, point.2 + c • period.2) ≠ point := by
  have hcz : (c : ℤ) ≠ 0 := by omega
  have hcoordinate : period.1 ≠ 0 ∨ period.2 ≠ 0 := by
    by_cases hfirst : period.1 = 0
    · right
      intro hsecond
      apply hperiod
      exact Prod.ext hfirst hsecond
    · left
      exact hfirst
  intro heq
  rcases hcoordinate with hfirst | hsecond
  · have hsum : point.1 + c • period.1 = point.1 := congrArg Prod.fst heq
    have hmul : (c : ℤ) * period.1 = 0 := by
      rw [nsmul_eq_mul] at hsum
      linarith
    rcases mul_eq_zero.mp hmul with h | h
    · exact hcz h
    · exact hfirst h
  · have hsum : point.2 + c • period.2 = point.2 := congrArg Prod.snd heq
    have hmul : (c : ℤ) * period.2 = 0 := by
      rw [nsmul_eq_mul] at hsum
      linarith
    rcases mul_eq_zero.mp hmul with h | h
    · exact hcz h
    · exact hsecond h

/-- `N = 2h + 2cm` は閉包の四部分の長さの和である（自然数の和の並べ替え）。 -/
theorem periodicLiftClosure_length (h m c : ℕ) :
    2 * h + 2 * (c * m) = h + c * m + h + c * m := by
  omega

end Ising2DLambda.KacWard
