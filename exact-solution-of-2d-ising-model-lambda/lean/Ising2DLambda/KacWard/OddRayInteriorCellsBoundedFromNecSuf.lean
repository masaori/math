/-
具体版が必要十分版の特殊化として得られることの導出。

具体版で示した四つの境界事実を、奇数支持の有限性だけを抽出した必要十分版へ渡す。
-/
import Ising2DLambda.KacWard.OddRayInteriorCellsBounded
import Ising2DLambda.NecSuf.KacWard.OddRayInteriorCellsBounded

namespace Ising2DLambda.KacWard

/-- `claim_odd_ray_interior_cells_bounded` を必要十分版から導く。 -/
theorem oddRayInteriorCells_finite_from_necSuf
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ)
    (hrow : ∀ k ≤ n, rMin ≤ row k ∧ row k ≤ rMax)
    (hcol : ∀ k < n, cMin ≤ col k ∧ col k ≤ cMax)
    (hclosed : row n = row 0)
    (hstep : ∀ k < n, row (k + 1) - row k = -1 ∨
      row (k + 1) - row k = 0 ∨ row (k + 1) - row k = 1) :
    (oddRayInteriorCells n row col).Finite := by
  exact Ising2DLambda.NecSuf.KacWard.odd_support_finite_necSuf
    (fun p => rightRayCrossingCount n row col p.1 p.2)
    rMin rMax cMin cMax
    (fun r c hr => rightRayCrossingCount_eq_zero_of_row_lt n row col rMin r c
      (fun k hk => (hrow k hk).1) hr)
    (fun r c hr => rightRayCrossingCount_eq_zero_of_row_ge n row col rMax r c
      (fun k hk => (hrow k hk).2) hr)
    (fun r c hc => rightRayCrossingCount_even_of_col_lt n row col cMin r c
      (fun k hk => (hcol k hk).1) hc hclosed hstep)
    (fun r c hc => rightRayCrossingCount_eq_zero_of_col_ge n row col cMax r c
      (fun k hk => (hcol k hk).2) hc)

end Ising2DLambda.KacWard
