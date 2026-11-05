import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 二方向の横断偶奇を入力した標準双対路の高さ。 -/
def standardDualHeight (L : ℕ) [NeZero L]
    (horizontalCross verticalCross : ZMod L → ZMod L → ℕ)
    (cell : ZMod L × ZMod L) : ℕ :=
  ((∑ c ∈ Finset.Icc 1 cell.2.val, verticalCross 0 (c : ZMod L)) +
    (∑ r ∈ Finset.Icc 1 cell.1.val, horizontalCross (r : ZMod L) cell.2)) % 2

end Ising2DLambda.NecSuf.KacWard
