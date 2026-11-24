/-
# ℕ から ℤ への包含写像は順序を保つ（具体版を必要十分版から導く）

具体版 `ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrder.lean` の主張を、必要十分版
`Ising2D/NecSuf/LeOfMapAddOfNonneg.lean` の `R := ℤ`、`f := inclusionNNtoZZ` の特殊化として得る。
人手のラベルは `inclusion_nn_to_zz_preserves_order`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesOrder
import Ising2D.NecSuf.LeOfMapAddOfNonneg

namespace Ising2D

/-- `inclusion_nn_to_zz_preserves_order` を `NecSuf.le_of_map_add_of_nonneg`（`R := ℤ`、`f := inclusionNNtoZZ`）の特殊化として得る。 -/
theorem inclusion_nn_to_zz_preserves_order_of_necSuf (x y : ℕ) (hxy : x ≤ y) :
    inclusionNNtoZZ x ≤ inclusionNNtoZZ y :=
  NecSuf.le_of_map_add_of_nonneg inclusionNNtoZZ inclusion_nn_to_zz_preserves_sum
    inclusion_nn_to_zz_image_is_nonnegative zero_add add_comm (fun _ _ t h => add_le_add_left h t) x y hxy

end Ising2D
