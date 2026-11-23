/-
# ℕ から ℤ への包含写像の像は 0 以上（具体版を必要十分版から導く）

具体版 `ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative.lean` の主張を、必要十分版
`Ising2D/NecSuf/ZeroLeOfRecAddOne.lean` の `R := ℤ`、`f := inclusionNNtoZZ` の特殊化として得る。
人手のラベルは `inclusion_nn_to_zz_image_is_nonnegative`。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimInclusionOfNaturalNumbersIntoIntegersImageIsNonnegative
import Ising2D.NecSuf.ZeroLeOfRecAddOne

namespace Ising2D

/-- `inclusion_nn_to_zz_image_is_nonnegative` を `NecSuf.zero_le_of_rec_add_one`（`R := ℤ`、`f := inclusionNNtoZZ`）の特殊化として得る。 -/
theorem inclusion_nn_to_zz_image_is_nonnegative_of_necSuf (n : ℕ) : (0 : ℤ) ≤ inclusionNNtoZZ n :=
  NecSuf.zero_le_of_rec_add_one inclusionNNtoZZ rfl (fun _ => rfl) int_zero_at_most_one
    (fun _ _ t h => add_le_add_left h t) zero_add add_comm n

end Ising2D
