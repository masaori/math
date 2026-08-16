/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の補足。

列 $S_q=(L\mapsto(\#V_L,\lambda(Z_L(q))))$ の第一成分 $\#V_L$（箱の点の個数）は $q$ を含まず、
$\#V_L=L^3$ である。したがって $S_q$ と $S_{q'}$ の第一成分は $q,q'$ に依らず常に一致し、
第三歩の後半で第一成分の一致を仮定に含めなかったことが正当化される。
-/
import Mathlib.Data.Fintype.BigOperators
import Ising3DCut.NullModel.BrokenComplement

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 箱の点の個数は `L ^ 3`。`q` を含まない量である。 -/
theorem card_site (L : ℕ) : Fintype.card (Site L) = L ^ 3 := by
  rw [Fintype.card_congr siteEquiv]
  simp [Fintype.card_pi, Fintype.card_fin]

end Ising3DCut.LimitQuantity
