/-
# `log(ab) = log a + log b`（具体版を必要十分版から導く）

具体版 `ClaimRealLogOfProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_map_mul` の
`G := ℝ`、`R := ℝ`、`f := Real.exp`、`L := Real.log`、`P y := 0 < y` の特殊化として得る。人手のラベルは `real_log_of_product`。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfProduct
import Ising2D.NecSuf.InverseOfAdditiveToMultiplicativeMap

namespace Ising2D

/-- `real_log_of_product` を `NecSuf.inv_map_mul` の特殊化として得る。 -/
theorem real_log_of_product_of_necSuf {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    0 < a * b ∧ Real.log (a * b) = Real.log a + Real.log b :=
  NecSuf.inv_map_mul Real.exp Real.log (fun y => 0 < y) Real.exp_add (fun _ hy => Real.exp_log hy)
    Real.log_exp (fun _ _ ha hb => mul_pos ha hb) ha hb

end Ising2D
