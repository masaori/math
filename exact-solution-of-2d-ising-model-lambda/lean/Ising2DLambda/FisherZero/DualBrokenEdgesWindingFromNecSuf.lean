/-
有限置換上の自然数の二値変化の必要十分版を、実際の二つの格子方向へ特殊化する。
双対原像の計算で得た自然数の指示子へ、配位・二値符号化・巡回置換を供給する。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesWinding
import Ising2DLambda.NecSuf.FisherZero.DualBrokenEdgesWinding

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 必要十分版から得る、破れた辺の双対像の巻き付き偶奇の消滅。 -/
theorem dualBrokenEdgeSet_winding_zero_from_necSuf (L : ℕ) [NeZero L]
    (sigma : Config L) :
    torusHomologySector L (dualBrokenEdgeSet L sigma) = (0, 0) := by
  apply Prod.ext
  · apply Fin.ext
    calc
      _ = (∑ i : ZMod L, if edgeOfRow L true i (-1) ∈ brokenEdgeSet L sigma
          then (1 : ℕ) else 0) % 2 := horizontalWindingParity_dualBrokenEdgeSet_val L sigma
      _ = (∑ i : ZMod L, if sigma (i, -1) = sigma (i + 1, -1)
          then (0 : ℕ) else 1) % 2 := by
        simp only [brokenEdgeSet, mem_filter, mem_univ, true_and,
          edgeOfRow_boundary0, edgeOfRow_boundary1_vertical, ite_not]
      _ = 0 := Ising2DLambda.NecSuf.FisherZero.cyclic_change_parity_zero_necSuf
        spinBinaryCode spinBinaryCode_injective
        (fun i : ZMod L => sigma (i, -1)) (Equiv.addRight 1)
  · apply Fin.ext
    calc
      _ = (∑ j : ZMod L, if edgeOfRow L false (-1) j ∈ brokenEdgeSet L sigma
          then (1 : ℕ) else 0) % 2 := verticalWindingParity_dualBrokenEdgeSet_val L sigma
      _ = (∑ j : ZMod L, if sigma (-1, j) = sigma (-1, j + 1)
          then (0 : ℕ) else 1) % 2 := by
        simp only [brokenEdgeSet, mem_filter, mem_univ, true_and,
          edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal, ite_not]
      _ = 0 := Ising2DLambda.NecSuf.FisherZero.cyclic_change_parity_zero_necSuf
        spinBinaryCode spinBinaryCode_injective
        (fun j : ZMod L => sigma (-1, j)) (Equiv.addRight 1)

end Ising2DLambda.FisherZero
