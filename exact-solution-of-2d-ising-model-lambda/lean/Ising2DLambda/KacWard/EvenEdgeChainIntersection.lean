import Ising2DLambda.KacWard.Basic
import Ising2DLambda.NecSuf.KacWard.EvenEdgeChainIntersection

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

/-- 有限辺鎖の横辺 `(i,j)` の係数。辺長一でも辺番号の横縦標識を使う。 -/
def horizontalChainCoefficient (L : ℕ) (C : Finset (Edge L))
    (i j : ZMod L) : ZMod 2 :=
  ∑ e ∈ C, if e.val < L ^ 2 ∧
      (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j
    then 1 else 0

/-- 有限辺鎖の縦辺 `(i,j)` の係数。 -/
def verticalChainCoefficient (L : ℕ) (C : Finset (Edge L))
    (i j : ZMod L) : ZMod 2 :=
  ∑ e ∈ C, if L ^ 2 ≤ e.val ∧
      (edgeRow L e : ZMod L) = i ∧ (edgeColumn L e : ZMod L) = j
    then 1 else 0

/-- `def_even_edge_chain_intersection` の具体版。 -/
def evenEdgeChainIntersection (L : ℕ) [NeZero L]
    (C D : Finset (Edge L)) : ZMod 2 :=
  ∑ i : ZMod L, ∑ j : ZMod L,
    (horizontalChainCoefficient L C i j *
        verticalChainCoefficient L D (i - 1) (j + 1) +
      verticalChainCoefficient L C i j * horizontalChainCoefficient L D i j)

/-- 具体的な辺係数を必要十分な有限添字の交差形式へ代入する。 -/
theorem evenEdgeChainIntersection_from_necSuf (L : ℕ) [NeZero L]
    (C D : Finset (Edge L)) :
    evenEdgeChainIntersection L C D =
      Ising2DLambda.NecSuf.KacWard.finiteEdgeChainIntersection
        (fun i : ZMod L => i - 1) (fun j : ZMod L => j + 1)
        (horizontalChainCoefficient L C) (verticalChainCoefficient L C)
        (horizontalChainCoefficient L D) (verticalChainCoefficient L D) := rfl

end Ising2DLambda.KacWard
