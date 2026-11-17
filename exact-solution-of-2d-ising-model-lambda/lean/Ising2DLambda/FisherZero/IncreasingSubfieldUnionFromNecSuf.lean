import Ising2DLambda.FisherZero.IncreasingSubfieldUnion
import Ising2DLambda.NecSuf.FisherZero.IncreasingSubfieldUnion

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体列に特殊化した結果は具体版と同じ台を持つ。 -/
theorem increasingSubfieldUnion_from_necSuf
    (F : ℕ → Subfield Qbar) (hmono : Monotone F) :
    (increasingSubfieldUnion F hmono : Set Qbar) =
      (Ising2DLambda.NecSuf.FisherZero.increasingSubfieldUnion F hmono : Set Qbar) := by
  ext z
  rfl

end Ising2DLambda.FisherZero
