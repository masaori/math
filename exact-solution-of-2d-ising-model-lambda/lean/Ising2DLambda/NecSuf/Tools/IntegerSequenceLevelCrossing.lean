/-
「隣接差が高々 1 の整数列の水準横断数の恒等式」の必要十分版。

人手証明の望遠鏡和で実際に使う性質だけを取り出す。任意の加法可換群の列 `g` について、
隣接差の有限和は終点と始点の差に等しい。整数の順序、隣接差条件、横断数はこの段では
本質でなく、具体版が各隣接差を上横断・下横断の指示値へ同定するときだけ使う。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.Tools

open BigOperators

/-- 隣接差の有限和は終点と始点の差に等しい。 -/
theorem adjacent_difference_sum_necSuf {A : Type*} [AddCommGroup A]
    (g : ℕ → A) (n : ℕ) :
    (∑ k ∈ Finset.range n, (g (k + 1) - g k)) = g n - g 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      abel

end Ising2DLambda.NecSuf.Tools
