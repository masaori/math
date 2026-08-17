/-
`claim_positive_rational_mesh_width` の具体版を、必要十分版
`exists_meshWidth_square_lt_necSuf` の K := Q への特殊化として導出する。
-/
import Ising2DLambda.CriticalExponent.PositiveRationalMeshWidth
import Ising2DLambda.NecSuf.CriticalExponent.PositiveRationalMeshWidth

namespace Ising2DLambda.CriticalExponent

/-- 具体版は必要十分版の特殊化として得られる。 -/
theorem positiveRational_exists_meshWidth_square_lt_from_necSuf
    (delta : ℚ) (hDelta : 0 < delta) :
    ∃ N : ℕ, 1 ≤ N ∧
      0 < (1 / (N : ℚ)) ∧
      (1 / (N : ℚ)) * (1 / (N : ℚ)) < delta := by
  exact Ising2DLambda.NecSuf.CriticalExponent.exists_meshWidth_square_lt_necSuf
    delta hDelta

end Ising2DLambda.CriticalExponent
