/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.CyclicTurningVanishes
import Ising2DLambda.NecSuf.KacWard.CyclicTurningVanishes

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem directionResidueProjection_from_necSuf (n : ℤ) :
    directionResidueProjection n =
      Ising2DLambda.NecSuf.KacWard.residueProjection 4 n := rfl

/-- 具体版が必要十分版の特殊化として得られることの記録。`A = ZMod 4`（加法群なので
左簡約を持つ）、`φ` を整数キャスト（`Int.cast_zero` と `Int.cast_add` が
π₄ の零の保存と加法性）と取れば、必要十分版がこの主張を与える。 -/
theorem cyclic_total_turning_vanishes_from_necSuf (d : ZMod 4) (turns : List Turn)
    (closing : Turn)
    (hclosed :
      (turns.map turnValue).foldl (fun (a : ZMod 4) (n : ℤ) => a + (n : ZMod 4)) d
        + ((turnValue closing : ℤ) : ZMod 4) = d) :
    (((turns.map turnValue).sum + turnValue closing : ℤ) : ZMod 4) = 0 :=
  closed_walk_additive_vanishes_necSuf (fun n : ℤ => (n : ZMod 4))
    Int.cast_zero Int.cast_add d (turns.map turnValue) (turnValue closing) hclosed

end Ising2DLambda.KacWard
