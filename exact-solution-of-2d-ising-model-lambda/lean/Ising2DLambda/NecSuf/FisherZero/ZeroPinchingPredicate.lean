/-
「零点と正の有理点の距離の二乗は零でない」の必要十分版。

証明に要るのは、距離が零なら二点が等しいことと、比較点が零点集合に属さないことだけである。
体、順序、距離の公式、有理数、代数的数、可算性は要求しない。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 零性から二点の一致が従い、一方が零点でなければ、零点からの距離は零でない。 -/
theorem distance_ne_zero_of_zero_implies_equal_necSuf
    {X D : Type} [Zero D]
    (distance : D) (zeroPoint comparisonPoint : X) (zeroSet : Set X)
    (hzeroPoint : zeroPoint ∈ zeroSet)
    (hzeroImpliesEqual : distance = 0 → zeroPoint = comparisonPoint)
    (hcomparisonNotMem : comparisonPoint ∉ zeroSet) :
    distance ≠ 0 := by
  intro hzero
  have hequal : zeroPoint = comparisonPoint := hzeroImpliesEqual hzero
  apply hcomparisonNotMem
  rw [← hequal]
  exact hzeroPoint

end Ising2DLambda.NecSuf.FisherZero
