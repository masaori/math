/-
「破れた辺の双対像は偶部分グラフである」の具体版。
人手証明と同じく、一つの格子面の四辺に沿うスピン積で局所破れ数の偶数性を示す。
-/
import Ising2DLambda.FisherZero.DualEdgeMap
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

/-- 配位の破れた辺集合を双対辺写像で送った像。 -/
noncomputable def dualBrokenEdgeSet (L : ℕ) [NeZero L] (σ : Config L) : Finset (Edge L) :=
  (brokenEdgeSet L σ).image (dualEdgeEquiv L)

@[simp] lemma dualEdgeEquiv_horizontal (L : ℕ) [NeZero L] (i j : ZMod L) :
    dualEdgeEquiv L (edgeOfRow L false i j) = edgeOfRow L true i (j + 1) := by
  rw [show edgeOfRow L false i j = edgeEquiv L (Sum.inl (i, j)) from rfl]
  change edgeEquiv L (dualEdgeCoordinatesEquiv L ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inl (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

@[simp] lemma dualEdgeEquiv_vertical (L : ℕ) [NeZero L] (i j : ZMod L) :
    dualEdgeEquiv L (edgeOfRow L true i j) = edgeOfRow L false (i + 1) j := by
  rw [show edgeOfRow L true i j = edgeEquiv L (Sum.inr (i, j)) from rfl]
  change edgeEquiv L (dualEdgeCoordinatesEquiv L ((edgeEquiv L).symm
    (edgeEquiv L (Sum.inr (i, j))))) = _
  rw [(edgeEquiv L).symm_apply_apply]
  rfl

end Ising2DLambda.FisherZero
