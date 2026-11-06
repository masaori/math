/-
# 平方の大小から非負の実数の大小へ（具体版を必要十分版から導く）

人手 `nonnegative_real_order_from_squares` の具体版（`ClaimNonnegativeRealOrderFromSquares.lean`）を、必要十分版
`Ising2D/NecSuf/NonnegativeOrderFromSquares.lean` の `R := ℝ` の特殊化として得る。冪 `^2` を `u·u` へ開く段（`sq`）は
具体版の 1 行目・4 行目に当たり、必要十分版には無いのでここで補う。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimNonnegativeRealOrderFromSquares
import Ising2D.NecSuf.NonnegativeOrderFromSquares

namespace Ising2D

/-- `nonnegative_real_order_from_squares` を `NecSuf.order_from_squares'`（`R := ℝ`）の特殊化として得る。 -/
theorem nonnegative_real_order_from_squares_of_necSuf {u v : ℝ} (_hu : 0 ≤ u) (hv : 0 ≤ v)
    (h : u ^ 2 ≤ v ^ 2) : u ≤ v :=
  NecSuf.order_from_squares' hv (by rw [← sq, ← sq]; exact h)

end Ising2D
