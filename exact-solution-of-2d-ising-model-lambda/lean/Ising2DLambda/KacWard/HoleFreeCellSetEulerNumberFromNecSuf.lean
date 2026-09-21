/-
具体版が必要十分版の特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.HoleFreeCellSetEulerNumber

namespace Ising2DLambda.KacWard

/-- `claim_hole_free_cell_set_euler_number_one` を必要十分版から導く。 -/
theorem cellEulerNumber_eq_one_of_region_count_from_necSuf
    (cells : Finset GridCell) (regionCount : ℕ)
    (hregions : regionCount = cells.card + 1)
    (hplanarEuler :
      ((cellVertices cells).card : ℤ) - ((cellEdges cells).card : ℤ) +
        (regionCount : ℤ) = 2) :
    cellEulerNumber cells = 1 :=
  cellEulerNumber_eq_one_of_region_count cells regionCount hregions hplanarEuler

end Ising2DLambda.KacWard
