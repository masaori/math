/-
「横断消去の帰納法は位相と切断線偶奇と交差形式を保つ」（`claim_edge_distinct_crossing_elimination_parity`）の
証明の一行「交差形式の分配」
`I_L(C_A,C_B) = Σ_{i=1}^{p} Σ_{j=1}^{q} I_L(C_{α_i},C_{β_j})`（`C_A`・`C_B` は互いに素な台 `C_{α_i}`・`C_{β_j}` の合併）
の具体版。交差形式は `def_even_edge_chain_intersection` の `evenEdgeChainIntersection`、
辺鎖は辺の有限集合 `Finset (Edge L)` で、係数は `horizontalChainCoefficient`・`verticalChainCoefficient`。
住処は 𝔽₂ = `ZMod 2` と有限集合で、ℝ / ℂ は現れない。

人手証明との対応:
- 「辺の台の互いに素な分割」: 互いに素な辺集合の合併の係数は各辺集合の係数の和である
  （`horizontalChainCoefficient_biUnion`・`verticalChainCoefficient_biUnion`。有限和の互いに素な分割）。
- 「各項が二つの辺鎖の係数の積なので、二つの引数のそれぞれについて有限和に分配する」:
  第一引数は `evenEdgeChainIntersection_biUnion_left`、第二引数は `evenEdgeChainIntersection_biUnion_right`。
- 二つを順に代入した本文の等式: `evenEdgeChainIntersection_biUnion`。
- 二つの集合の場合（二本 `C_A`・`C_B` の分割に使う形）: `evenEdgeChainIntersection_union_left`・
  `evenEdgeChainIntersection_union_right`。
-/
import Ising2DLambda.KacWard.EvenEdgeChainIntersection

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial

variable {L : ℕ} {ι κ : Type*}

/-- 互いに素な辺集合族の合併の横辺係数は、各辺集合の横辺係数の和である。 -/
theorem horizontalChainCoefficient_biUnion [DecidableEq ι] (s : Finset ι)
    (F : ι → Finset (Edge L)) (hF : (s : Set ι).PairwiseDisjoint F) (i j : ZMod L) :
    horizontalChainCoefficient L (s.biUnion F) i j =
      ∑ a ∈ s, horizontalChainCoefficient L (F a) i j := by
  unfold horizontalChainCoefficient
  exact Finset.sum_biUnion hF

/-- 互いに素な辺集合族の合併の縦辺係数は、各辺集合の縦辺係数の和である。 -/
theorem verticalChainCoefficient_biUnion [DecidableEq ι] (s : Finset ι)
    (F : ι → Finset (Edge L)) (hF : (s : Set ι).PairwiseDisjoint F) (i j : ZMod L) :
    verticalChainCoefficient L (s.biUnion F) i j =
      ∑ a ∈ s, verticalChainCoefficient L (F a) i j := by
  unfold verticalChainCoefficient
  exact Finset.sum_biUnion hF

/-- 第一引数の分配: `I_L(⋃_{a∈s} F_a, D) = Σ_{a∈s} I_L(F_a, D)`（`F_a` は互いに素）。 -/
theorem evenEdgeChainIntersection_biUnion_left [NeZero L] [DecidableEq ι] (s : Finset ι)
    (F : ι → Finset (Edge L)) (hF : (s : Set ι).PairwiseDisjoint F) (D : Finset (Edge L)) :
    evenEdgeChainIntersection L (s.biUnion F) D =
      ∑ a ∈ s, evenEdgeChainIntersection L (F a) D := by
  calc evenEdgeChainIntersection L (s.biUnion F) D
      = ∑ i : ZMod L, ∑ j : ZMod L,
          ((∑ a ∈ s, horizontalChainCoefficient L (F a) i j) *
              verticalChainCoefficient L D (i - 1) (j + 1) +
            (∑ a ∈ s, verticalChainCoefficient L (F a) i j) *
              horizontalChainCoefficient L D i j) := by
        unfold evenEdgeChainIntersection
        simp only [horizontalChainCoefficient_biUnion s F hF,
          verticalChainCoefficient_biUnion s F hF]
    _ = ∑ i : ZMod L, ∑ j : ZMod L, ∑ a ∈ s,
          (horizontalChainCoefficient L (F a) i j *
              verticalChainCoefficient L D (i - 1) (j + 1) +
            verticalChainCoefficient L (F a) i j * horizontalChainCoefficient L D i j) := by
        simp only [Finset.sum_mul, ← Finset.sum_add_distrib]
    _ = ∑ a ∈ s, evenEdgeChainIntersection L (F a) D := by
        unfold evenEdgeChainIntersection
        conv_lhs => arg 2; ext i; rw [Finset.sum_comm]
        exact Finset.sum_comm

/-- 第二引数の分配: `I_L(C, ⋃_{b∈t} G_b) = Σ_{b∈t} I_L(C, G_b)`（`G_b` は互いに素）。 -/
theorem evenEdgeChainIntersection_biUnion_right [NeZero L] [DecidableEq κ] (C : Finset (Edge L))
    (t : Finset κ) (G : κ → Finset (Edge L)) (hG : (t : Set κ).PairwiseDisjoint G) :
    evenEdgeChainIntersection L C (t.biUnion G) =
      ∑ b ∈ t, evenEdgeChainIntersection L C (G b) := by
  calc evenEdgeChainIntersection L C (t.biUnion G)
      = ∑ i : ZMod L, ∑ j : ZMod L,
          (horizontalChainCoefficient L C i j *
              (∑ b ∈ t, verticalChainCoefficient L (G b) (i - 1) (j + 1)) +
            verticalChainCoefficient L C i j *
              (∑ b ∈ t, horizontalChainCoefficient L (G b) i j)) := by
        unfold evenEdgeChainIntersection
        simp only [horizontalChainCoefficient_biUnion t G hG,
          verticalChainCoefficient_biUnion t G hG]
    _ = ∑ i : ZMod L, ∑ j : ZMod L, ∑ b ∈ t,
          (horizontalChainCoefficient L C i j *
              verticalChainCoefficient L (G b) (i - 1) (j + 1) +
            verticalChainCoefficient L C i j * horizontalChainCoefficient L (G b) i j) := by
        simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    _ = ∑ b ∈ t, evenEdgeChainIntersection L C (G b) := by
        unfold evenEdgeChainIntersection
        conv_lhs => arg 2; ext i; rw [Finset.sum_comm]
        exact Finset.sum_comm

/-- 本文の等式 `I_L(⋃_a F_a, ⋃_b G_b) = Σ_a Σ_b I_L(F_a, G_b)`。
第一引数の分配の後に、各項へ第二引数の分配を代入する。 -/
theorem evenEdgeChainIntersection_biUnion [NeZero L] [DecidableEq ι] [DecidableEq κ]
    (s : Finset ι) (F : ι → Finset (Edge L)) (hF : (s : Set ι).PairwiseDisjoint F)
    (t : Finset κ) (G : κ → Finset (Edge L)) (hG : (t : Set κ).PairwiseDisjoint G) :
    evenEdgeChainIntersection L (s.biUnion F) (t.biUnion G) =
      ∑ a ∈ s, ∑ b ∈ t, evenEdgeChainIntersection L (F a) (G b) := by
  calc evenEdgeChainIntersection L (s.biUnion F) (t.biUnion G)
      = ∑ a ∈ s, evenEdgeChainIntersection L (F a) (t.biUnion G) :=
        evenEdgeChainIntersection_biUnion_left s F hF _
    _ = ∑ a ∈ s, ∑ b ∈ t, evenEdgeChainIntersection L (F a) (G b) :=
        Finset.sum_congr rfl fun a _ => evenEdgeChainIntersection_biUnion_right _ t G hG

/-- 二つの互いに素な辺集合の合併の第一引数: `I_L(C₁ ∪ C₂, D) = I_L(C₁, D) + I_L(C₂, D)`。 -/
theorem evenEdgeChainIntersection_union_left [NeZero L] (C₁ C₂ D : Finset (Edge L))
    (h : Disjoint C₁ C₂) :
    evenEdgeChainIntersection L (C₁ ∪ C₂) D =
      evenEdgeChainIntersection L C₁ D + evenEdgeChainIntersection L C₂ D := by
  have hu : C₁ ∪ C₂ = (univ : Finset Bool).biUnion (fun b => if b then C₁ else C₂) := by
    ext e; simp
  have hd : ((univ : Finset Bool) : Set Bool).PairwiseDisjoint
      (fun b => if b then C₁ else C₂) := by
    intro a _ b _ hab
    cases a <;> cases b <;> simp_all [Function.onFun, disjoint_comm]
  rw [hu, evenEdgeChainIntersection_biUnion_left _ _ hd, Fintype.sum_bool]
  simp

/-- 二つの互いに素な辺集合の合併の第二引数: `I_L(C, D₁ ∪ D₂) = I_L(C, D₁) + I_L(C, D₂)`。 -/
theorem evenEdgeChainIntersection_union_right [NeZero L] (C D₁ D₂ : Finset (Edge L))
    (h : Disjoint D₁ D₂) :
    evenEdgeChainIntersection L C (D₁ ∪ D₂) =
      evenEdgeChainIntersection L C D₁ + evenEdgeChainIntersection L C D₂ := by
  have hu : D₁ ∪ D₂ = (univ : Finset Bool).biUnion (fun b => if b then D₁ else D₂) := by
    ext e; simp
  have hd : ((univ : Finset Bool) : Set Bool).PairwiseDisjoint
      (fun b => if b then D₁ else D₂) := by
    intro a _ b _ hab
    cases a <;> cases b <;> simp_all [Function.onFun, disjoint_comm]
  rw [hu, evenEdgeChainIntersection_biUnion_right _ _ _ hd, Fintype.sum_bool]
  simp

end Ising2DLambda.KacWard
