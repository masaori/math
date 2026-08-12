/-
「破れた辺の双対像の二つの巻き付き偶奇は零である」の具体版。
周期方向の閉路に沿う破れ指示子を二値の変化へ移し、一周で偶数回変わることを使う。
-/
import Ising2DLambda.FisherZero.DualBrokenEdgesEven
import Ising2DLambda.FisherZero.TorusHomologySector
import Ising2DLambda.NecSuf.FisherZero.DualBrokenEdgesWinding

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- `claim_dual_broken_edges_winding_zero` の具体版。 -/
theorem dualBrokenEdgeSet_winding_zero (L : ℕ) [NeZero L] (sigma : Config L) :
    torusHomologySector L (dualBrokenEdgeSet L sigma) = (0, 0) := by
  apply Prod.ext
  · change (∑ i : ZMod L,
      if edgeOfRow L false i (-1) ∈ dualBrokenEdgeSet L sigma then 1 else 0) = 0
    simp only [mem_dualBrokenEdgeSet_iff, dualEdgeEquiv_symm_horizontal,
      brokenEdgeSet, Finset.mem_filter, Finset.mem_univ, true_and,
      edgeOfRow_boundary0, edgeOfRow_boundary1_vertical]
    simpa [spinValueEquivBool, sub_add_cancel] using
      (Ising2DLambda.NecSuf.FisherZero.cyclic_change_parity_zero_necSuf
        spinValueEquivBool (fun i : ZMod L => sigma (i - 1, -1)) (Equiv.addRight 1))
  · change (∑ j : ZMod L,
      if edgeOfRow L true (-1) j ∈ dualBrokenEdgeSet L sigma then 1 else 0) = 0
    simp only [mem_dualBrokenEdgeSet_iff, dualEdgeEquiv_symm_vertical,
      brokenEdgeSet, Finset.mem_filter, Finset.mem_univ, true_and,
      edgeOfRow_boundary0, edgeOfRow_boundary1_horizontal]
    simpa [spinValueEquivBool, sub_add_cancel] using
      (Ising2DLambda.NecSuf.FisherZero.cyclic_change_parity_zero_necSuf
        spinValueEquivBool (fun j : ZMod L => sigma (-1, j - 1)) (Equiv.addRight 1))

end Ising2DLambda.FisherZero
