/-
章「Onsager 閉形式への接続」の一側閉包（`def_one_sided_periodic_lift_closure`）、
接続階段と周期持ち上げから作る閉路（`def_periodic_lift_closure_cycle`）、
一側閉包の四接合（`claim_one_sided_closure_junction_pairs`）が共有する、
四つの部分を並べる有限列の具体版。

本文の四部分はどれも `ℤ × ℤ` の点（または歩ベクトル）の有限列である。
ここでも値の型を `ℤ × ℤ` に固定する。必要十分版は import しない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 長さ `a`, `b`, `c`, `b` の四部分を、第四部分だけ逆向きにたどって連結する有限路。 -/
def oneSidedFourSegmentPath (first second third fourth : ℕ → ℤ × ℤ) (a b c j : ℕ) :
    ℤ × ℤ :=
  if j < a then first j
  else if j < a + b then second (j - a)
  else if j < a + b + c then third (j - a - b)
  else fourth (a + 2 * b + c - j)

/-- 四つの有限列を、共有する境界の添字を一度だけ使って並べる。 -/
def fourPartClosure (h p : ℕ) (first second third fourth : ℕ → ℤ × ℤ) :
    Fin (2 * h + 2 * p + 1) → ℤ × ℤ :=
  fun j =>
    if j.val ≤ h then first j.val
    else if j.val ≤ h + p then second (j.val - h)
    else if j.val ≤ 2 * h + p then third (j.val - h - p)
    else fourth (j.val - 2 * h - p)

/-- 四部分の歩ベクトル列の、隣り合う部分の末項と先頭の対（第四部分の末項と第一部分の先頭を含む）。 -/
def fourJunctionPairs (a b c d : ℕ) (u v w x : ℕ → ℤ × ℤ) :
    List ((ℤ × ℤ) × (ℤ × ℤ)) :=
  [(u (a - 1), v 0), (v (b - 1), w 0),
    (w (c - 1), x 0), (x (d - 1), u 0)]

end Ising2DLambda.KacWard
