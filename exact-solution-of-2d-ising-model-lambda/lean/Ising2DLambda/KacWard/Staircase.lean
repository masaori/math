/-
章「Onsager 閉形式への接続」の横断階段・平行階段・反復横断階段
（`def_winding_transverse_staircase`・`def_winding_parallel_staircase`・
`def_iterated_transverse_staircase`）が共有する、二相の階段と反復階段の具体版。

本文の階段はどれも `ℤ × ℤ` の有限列で、スカラー倍と和は成分ごとの整数演算である。
ここでも点の型を `ℤ × ℤ` に固定する。必要十分版は import しない。
-/
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- 二相の階段。`s ≤ H` なら `s • firstStep`、それ以外は `H • firstStep + (s - H) • secondStep`。 -/
def twoPhaseStaircase (H : ℕ) (firstStep secondStep : ℤ × ℤ) (s : ℕ) : ℤ × ℤ :=
  if s ≤ H then s • firstStep else H • firstStep + (s - H) • secondStep

/-- 平行階段の場合分け。`firstBeforeSecond` が真なら第一の歩を `H` 回・第二の歩を後に、
偽なら第二の歩を `V` 回・第一の歩を後に並べる。 -/
def orderedTwoPhaseStaircase (firstBeforeSecond : Prop) [Decidable firstBeforeSecond]
    (H V : ℕ) (firstStep secondStep : ℤ × ℤ) (s : ℕ) : ℤ × ℤ :=
  if firstBeforeSecond then
    twoPhaseStaircase H firstStep secondStep s
  else
    twoPhaseStaircase V secondStep firstStep s

/-- 反復階段 `base + q • period + path r`。`s = q n + r` は整数の除法（`q = s / n`、`r = s % n`）。 -/
def iteratedStaircase (n : ℕ) (path : ℕ → ℤ × ℤ) (period base : ℤ × ℤ) (s : ℕ) : ℤ × ℤ :=
  base + (s / n) • period + path (s % n)

end Ising2DLambda.KacWard
