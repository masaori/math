/-
「交差形式は辺の台の互いに素な合併に分配する」の具体版 `evenEdgeChainIntersection_biUnion` が、
必要十分版 `finiteChainIntersection_biUnion_necSuf` の特殊化として得られることを示す導出版。
具体版の証明はこのファイルに依存しない。
-/
import Ising2DLambda.KacWard.EvenEdgeChainIntersectionDisjointUnion
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainIntersectionDisjointUnion

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L : ℕ} {ι κ : Type*}

/-- 横・縦の辺の寄与（係数の和の各項）。 -/
def horizontalEdgeContribution (L : ℕ) (e : Edge L) (i j : ZMod L) : ZMod 2 :=
  if e.val < L ^ 2 ∧ (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j then 1 else 0

/-- 縦辺の寄与。 -/
def verticalEdgeContribution (L : ℕ) (e : Edge L) (i j : ZMod L) : ZMod 2 :=
  if L ^ 2 ≤ e.val ∧ (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j then 1 else 0

/-- 具体的な交差形式は、辺の寄与を必要十分版の交差形式へ代入したものである（定義の対応）。 -/
theorem evenEdgeChainIntersection_eq_finiteChainIntersection_from_necSuf [NeZero L] (C D : Finset (Edge L)) :
    evenEdgeChainIntersection L C D =
      Ising2DLambda.NecSuf.KacWard.finiteChainIntersection
        (fun i : ZMod L => i - 1) (fun j : ZMod L => j + 1)
        (horizontalEdgeContribution L) (verticalEdgeContribution L) C D := by
  unfold evenEdgeChainIntersection Ising2DLambda.NecSuf.KacWard.finiteChainIntersection
    Ising2DLambda.NecSuf.KacWard.finiteChainCoefficient horizontalChainCoefficient
    verticalChainCoefficient horizontalEdgeContribution verticalEdgeContribution
  rfl

/-- 具体版が必要十分版 `finiteChainIntersection_biUnion_necSuf` の特殊化として得られること。 -/
theorem evenEdgeChainIntersection_biUnion_from_necSuf [NeZero L] [DecidableEq ι] [DecidableEq κ]
    (s : Finset ι) (F : ι → Finset (Edge L)) (hF : (s : Set ι).PairwiseDisjoint F)
    (t : Finset κ) (G : κ → Finset (Edge L)) (hG : (t : Set κ).PairwiseDisjoint G) :
    evenEdgeChainIntersection L (s.biUnion F) (t.biUnion G) =
      ∑ a ∈ s, ∑ b ∈ t, evenEdgeChainIntersection L (F a) (G b) := by
  simp only [evenEdgeChainIntersection_eq_finiteChainIntersection_from_necSuf]
  exact Ising2DLambda.NecSuf.KacWard.finiteChainIntersection_biUnion_necSuf _ _ _ _ s F hF t G hG

end Ising2DLambda.KacWard
