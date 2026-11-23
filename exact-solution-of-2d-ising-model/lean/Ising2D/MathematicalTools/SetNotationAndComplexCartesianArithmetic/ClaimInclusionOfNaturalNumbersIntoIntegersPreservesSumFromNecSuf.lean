/-
# ℕ から ℤ への包含写像は和を保つ（具体版を必要十分版から導く）

具体版 `ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum.lean` の主張を、必要十分版
`Ising2D/NecSuf/MapAddOfRecAddOne.lean` の `R := ℤ`、`f := inclusionNNtoZZ` の特殊化として得る。
人手のラベルは `inclusion_nn_to_zz_preserves_sum`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersPreservesSum
import Ising2D.NecSuf.MapAddOfRecAddOne

namespace Ising2D

/-- `inclusion_nn_to_zz_preserves_sum` を `NecSuf.map_add_of_rec_add_one`（`R := ℤ`、`f := inclusionNNtoZZ`）の特殊化として得る。 -/
theorem inclusion_nn_to_zz_preserves_sum_of_necSuf (x y : ℕ) :
    inclusionNNtoZZ (x + y) = inclusionNNtoZZ x + inclusionNNtoZZ y :=
  NecSuf.map_add_of_rec_add_one inclusionNNtoZZ rfl (fun _ => rfl) add_zero add_assoc x y

end Ising2D
