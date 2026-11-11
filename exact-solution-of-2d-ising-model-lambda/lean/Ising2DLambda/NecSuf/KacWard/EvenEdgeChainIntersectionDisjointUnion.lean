/-
「交差形式は辺の台の互いに素な合併に分配する」
（`claim_edge_distinct_crossing_elimination_parity` の証明の一行）の必要十分版。
具体版 `evenEdgeChainIntersection_biUnion` と同じ手順（係数の互いに素な分割 → 第一引数の分配 →
第二引数の分配）で、格子・辺の番号・𝔽₂ を使わない。使うのは次だけである。
- 値は非単位・非結合的な半環 `R`。積の左右の分配律と、有限和の並べ替え（加法の可換性）だけを使う。
  積の可換律・結合律・単位元・`1 + 1 = 0` は使わない。
- 辺は任意の型 `E`、辺鎖はその有限集合。係数は辺ごとの寄与 `wH`・`wV : E → I → J → R` の和で、
  寄与は任意の写像である（具体版では横・縦の標識と位置の指示関数）。
- 行・列の添字は有限集合 `I`・`J`、ずらしの写像 `previousRow`・`nextColumn` は任意の写像。
- 族は互いに素（`PairwiseDisjoint`）。同じ辺を二度数えないために要る。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Data.Fintype.Basic

namespace Ising2DLambda.NecSuf.KacWard

open Finset

variable {R E I J ι κ : Type*} [NonUnitalNonAssocSemiring R] [Fintype I] [Fintype J]

/-- 辺ごとの寄与の和で与えた、有限辺集合の係数。 -/
def finiteChainCoefficient (w : E → I → J → R) (C : Finset E) (i : I) (j : J) : R :=
  ∑ e ∈ C, w e i j

/-- 有限の行・列添字と、辺ごとの寄与から作る二つの辺鎖の係数だけを使う交差形式。 -/
def finiteChainIntersection (previousRow : I → I) (nextColumn : J → J)
    (wH wV : E → I → J → R) (C D : Finset E) : R :=
  ∑ i : I, ∑ j : J,
    (finiteChainCoefficient wH C i j * finiteChainCoefficient wV D (previousRow i) (nextColumn j) +
      finiteChainCoefficient wV C i j * finiteChainCoefficient wH D i j)

omit [Fintype I] [Fintype J] in
theorem finiteChainCoefficient_biUnion_necSuf [DecidableEq E] (w : E → I → J → R)
    (s : Finset ι) (F : ι → Finset E) (hF : (s : Set ι).PairwiseDisjoint F) (i : I) (j : J) :
    finiteChainCoefficient w (s.biUnion F) i j = ∑ a ∈ s, finiteChainCoefficient w (F a) i j := by
  unfold finiteChainCoefficient
  exact Finset.sum_biUnion hF

theorem finiteChainIntersection_biUnion_left_necSuf [DecidableEq E]
    (previousRow : I → I) (nextColumn : J → J) (wH wV : E → I → J → R)
    (s : Finset ι) (F : ι → Finset E) (hF : (s : Set ι).PairwiseDisjoint F) (D : Finset E) :
    finiteChainIntersection previousRow nextColumn wH wV (s.biUnion F) D =
      ∑ a ∈ s, finiteChainIntersection previousRow nextColumn wH wV (F a) D := by
  unfold finiteChainIntersection
  simp only [finiteChainCoefficient_biUnion_necSuf wH s F hF,
    finiteChainCoefficient_biUnion_necSuf wV s F hF, Finset.sum_mul,
    ← Finset.sum_add_distrib]
  conv_lhs => arg 2; ext i; rw [Finset.sum_comm]
  exact Finset.sum_comm

theorem finiteChainIntersection_biUnion_right_necSuf [DecidableEq E]
    (previousRow : I → I) (nextColumn : J → J) (wH wV : E → I → J → R) (C : Finset E)
    (t : Finset κ) (G : κ → Finset E) (hG : (t : Set κ).PairwiseDisjoint G) :
    finiteChainIntersection previousRow nextColumn wH wV C (t.biUnion G) =
      ∑ b ∈ t, finiteChainIntersection previousRow nextColumn wH wV C (G b) := by
  unfold finiteChainIntersection
  simp only [finiteChainCoefficient_biUnion_necSuf wH t G hG,
    finiteChainCoefficient_biUnion_necSuf wV t G hG, Finset.mul_sum,
    ← Finset.sum_add_distrib]
  conv_lhs => arg 2; ext i; rw [Finset.sum_comm]
  exact Finset.sum_comm

/-- `I(⋃_a F_a, ⋃_b G_b) = Σ_a Σ_b I(F_a, G_b)`（両族とも互いに素）。 -/
theorem finiteChainIntersection_biUnion_necSuf [DecidableEq E]
    (previousRow : I → I) (nextColumn : J → J) (wH wV : E → I → J → R)
    (s : Finset ι) (F : ι → Finset E) (hF : (s : Set ι).PairwiseDisjoint F)
    (t : Finset κ) (G : κ → Finset E) (hG : (t : Set κ).PairwiseDisjoint G) :
    finiteChainIntersection previousRow nextColumn wH wV (s.biUnion F) (t.biUnion G) =
      ∑ a ∈ s, ∑ b ∈ t, finiteChainIntersection previousRow nextColumn wH wV (F a) (G b) := by
  rw [finiteChainIntersection_biUnion_left_necSuf _ _ _ _ s F hF]
  exact Finset.sum_congr rfl fun a _ =>
    finiteChainIntersection_biUnion_right_necSuf _ _ _ _ _ t G hG

end Ising2DLambda.NecSuf.KacWard
