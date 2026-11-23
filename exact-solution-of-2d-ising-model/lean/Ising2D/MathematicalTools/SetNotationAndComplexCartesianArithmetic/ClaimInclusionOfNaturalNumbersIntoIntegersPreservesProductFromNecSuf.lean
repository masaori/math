/-
# ℕ から ℤ への包含写像は積を保つ（具体版を必要十分版から導く）

具体版 `ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/MapMulOfRecAddOne.lean` の `R := ℤ`、`f := inclusionNNtoZZ` の特殊化として得る。
左から 0 を掛けると 0 になることは、具体版と同じく `int_zero_times_is_zero` を渡す。
人手のラベルは `inclusion_nn_to_zz_preserves_product`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesProduct
import Ising2D.NecSuf.MapMulOfRecAddOne

namespace Ising2D

/-- `inclusion_nn_to_zz_preserves_product` を `NecSuf.map_mul_of_rec_add_one`（`R := ℤ`、`f := inclusionNNtoZZ`）の特殊化として得る。 -/
theorem inclusion_nn_to_zz_preserves_product_of_necSuf (x y : ℕ) :
    inclusionNNtoZZ (x * y) = inclusionNNtoZZ x * inclusionNNtoZZ y :=
  NecSuf.map_mul_of_rec_add_one inclusionNNtoZZ rfl (fun _ => rfl) add_zero add_assoc
    int_zero_times_is_zero mul_comm mul_one mul_add x y

end Ising2D
