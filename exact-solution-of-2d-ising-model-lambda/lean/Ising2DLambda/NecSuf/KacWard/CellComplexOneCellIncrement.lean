/-
「一セルを追加したときの Euler 数の増分」の必要十分版。

格子から切り離すと、必要なのは頂点集合と辺集合が一セル追加でそれぞれ合併に分かれ、
追加セルが頂点と辺を四つずつ持つこと、および有限集合の包除だけである。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/-- 一要素の追加で二つの付随有限集合が合併に分かれるときの Euler 数の増分。 -/
theorem cellComplex_oneCellIncrement_necSuf
    {Cell Vertex Edge : Type*}
    [DecidableEq Cell] [DecidableEq Vertex] [DecidableEq Edge]
    (cells : Finset Cell) (x : Cell)
    (vertices : Finset Cell → Finset Vertex)
    (edges : Finset Cell → Finset Edge)
    (hx : x ∉ cells)
    (hverticesInsert : vertices (insert x cells) = vertices cells ∪ vertices {x})
    (hedgesInsert : edges (insert x cells) = edges cells ∪ edges {x})
    (hverticesSingleton : (vertices {x}).card = 4)
    (hedgesSingleton : (edges {x}).card = 4) :
    (((vertices (insert x cells)).card : ℤ) - ((edges (insert x cells)).card : ℤ) +
        ((insert x cells).card : ℤ)) =
      (((vertices cells).card : ℤ) - ((edges cells).card : ℤ) + (cells.card : ℤ)) + 1 +
        ((edges cells ∩ edges {x}).card : ℤ) -
        ((vertices cells ∩ vertices {x}).card : ℤ) := by
  have hverticesCard :
      (vertices (insert x cells)).card + (vertices cells ∩ vertices {x}).card =
        (vertices cells).card + 4 := by
    rw [hverticesInsert, Finset.card_union_add_card_inter, hverticesSingleton]
  have hedgesCard :
      (edges (insert x cells)).card + (edges cells ∩ edges {x}).card =
        (edges cells).card + 4 := by
    rw [hedgesInsert, Finset.card_union_add_card_inter, hedgesSingleton]
  have hcellsCard : (insert x cells).card = cells.card + 1 :=
    Finset.card_insert_of_notMem hx
  exact_mod_cast (by omega :
    (((vertices (insert x cells)).card : ℤ) - ((edges (insert x cells)).card : ℤ) +
        ((insert x cells).card : ℤ)) =
      (((vertices cells).card : ℤ) - ((edges cells).card : ℤ) + (cells.card : ℤ)) + 1 +
        ((edges cells ∩ edges {x}).card : ℤ) -
        ((vertices cells ∩ vertices {x}).card : ℤ))

end Ising2DLambda.NecSuf.KacWard
