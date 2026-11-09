/-
面数を仮定した旧経路の導出。現在の本文の証明には対応しない。
-/
import Ising2DLambda.KacWard.HoleFreeCellSetEulerNumber

namespace Ising2DLambda.KacWard

/-- 旧経路の補題を必要十分版から導く。 -/
theorem cellEulerNumber_eq_one_of_region_count_from_necSuf
    (cells : Finset GridCell) (regionCount : ℕ)
    (hregions : regionCount = cells.card + 1)
    (hplanarEuler :
      ((cellVertices cells).card : ℤ) - ((cellEdges cells).card : ℤ) +
        (regionCount : ℤ) = 2) :
    cellEulerNumber cells = 1 :=
  cellEulerNumber_eq_one_of_region_count cells regionCount hregions hplanarEuler

end Ising2DLambda.KacWard
