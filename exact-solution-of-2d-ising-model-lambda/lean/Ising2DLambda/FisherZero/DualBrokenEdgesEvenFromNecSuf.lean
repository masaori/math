/-
必要十分版へ実際の格子の端点数・四辺・四スピンを渡す導出。
局所計数と各辺の符号を具体的な定義から供給する。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesEven
import Ising2DLambda.NecSuf.FisherZero.DualBrokenEdgesEven

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 四境界の必要十分版を、破れた辺の双対像の実際の端点数へ特殊化する。 -/
theorem dualBrokenEdgeSet_isEven_from_necSuf (L : ℕ) [NeZero L] (sigma : Config L) :
    IsEvenEdgeSubset L (dualBrokenEdgeSet L sigma) := by
  classical
  rintro ⟨i, j⟩
  let q (e : Edge L) : ℕ := if e ∈ brokenEdgeSet L sigma then 1 else 0
  apply Ising2DLambda.NecSuf.FisherZero.four_signs_even_necSuf
    (-1 : ℤ) (sigma (i - 1, j - 1)).1 (sigma (i - 1, j)).1
    (sigma (i, j)).1 (sigma (i, j - 1)).1
    _ (q (edgeOfRow L true (i - 1) j)) (q (edgeOfRow L false i (j - 1)))
    (q (edgeOfRow L true (i - 1) (j - 1)))
    (q (edgeOfRow L false (i - 1) (j - 1)))
  · norm_num
  · norm_num
  · exact dualBrokenEdgeSet_incidenceCount L sigma i j
  · simpa only [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
      edgeOfRow_boundary1_vertical, sub_add_cancel] using brokenEdge_pow_sign L sigma (edgeOfRow L true (i - 1) j)
  · simpa only [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
      edgeOfRow_boundary1_vertical, sub_add_cancel] using brokenEdge_pow_sign L sigma (edgeOfRow L false i (j - 1))
  · simpa only [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
      edgeOfRow_boundary1_vertical, sub_add_cancel] using brokenEdge_pow_sign L sigma (edgeOfRow L true (i - 1) (j - 1))
  · simpa only [edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal,
      edgeOfRow_boundary1_vertical, sub_add_cancel] using brokenEdge_pow_sign L sigma (edgeOfRow L false (i - 1) (j - 1))
  all_goals exact spinValue_square _

end Ising2DLambda.FisherZero
