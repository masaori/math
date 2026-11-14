/-
「反対称化した行列の Pfaffian は符号付き偶部分グラフ多項式に等しい」（`claim_pfaffian_signed_even_subgraph`）の
式鎖の一行目から四行目の具体版。実際の反対称行列 `K^as`（`gaugedTerminalMatrix L z s`）について

  `Pf(K^as) = Σ_{P ∈ 𝒲_L} χ_{a,b}(h(P), v(P)) x^{|P|}`

を、本文の式鎖の順に示す。`h(P), v(P)` は補辺 `P` の切断線偶奇 `edgeSetSeamParities P` で、
巻き付き偶奇への書き換え（式鎖の五行目から）はここでは行わない。

  人手証明                                               このファイル・引く具体版
  一行目（claim_tagged_matching_expansion）               `gaugedPfaffian_taggedMatchingExpansion`
  一行目の二重和を、標識の集合が対に含まれる組の和へ      `Finset.sum_finset_product`
  二行目: 零の項を落とす                                  `Finset.sum_filter_ne_zero`
  二行目: 補辺ごとの再添字付け
    （claim_tagged_matching_even_complement）             `taggedMatching_even_complement`
  三行目（claim_tagged_matching_quadratic_crossing_weight
    と分配則）                                           `taggedMatchingTerm_quadraticCrossingWeight`
  四行目（claim_local_pairing_signed_sum）                `nonzeroTaggedMatchings_signed_crossing_sum_eq_one`

住処は有限集合・`ℤ`・`Qbar`・`Qbar[X]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.TaggedMatchingExpansion
import Ising2DLambda.KacWard.TaggedMatchingEvenComplement
import Ising2DLambda.KacWard.TaggedMatchingQuadraticCrossingWeight
import Ising2DLambda.KacWard.LocalPairingCrossingCount

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero
open scoped Classical

variable {L : ℕ} [NeZero L]

/-- 標識付き完全マッチング `(D, T)` の項 `M_{D,T}(x)`（`claim_tagged_matching_expansion` の和の各項）。 -/
noncomputable def taggedMatchingTerm (z : Qbar) (s : SpinStructure)
    (x : PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L)) :
    Polynomial Qbar :=
  matchingSignPolynomial x.1 *
    ((-1 : Polynomial Qbar) ^ x.2.card *
      (∏ p ∈ matchingOrientedPairs x.1 \ x.2, gaugedLongContribution z s p) *
      (∏ p ∈ x.2, gaugedShortContribution z s p))

/-- 標識の集合 `T` が `D` の対に含まれる組 `(D, T)` 全体。 -/
noncomputable def labelledMatchings (L : ℕ) :
    Finset (PerfectMatching (OrientedEdge L) × Finset (OrientedEdge L × OrientedEdge L)) :=
  (univ ×ˢ univ).filter fun x => x.2 ⊆ matchingOrientedPairs x.1

/-- 補辺 `P` の二次符号 `χ_{a,b}(h(P), v(P)) ∈ {±1} ⊂ Qbar`（`h, v` は切断線偶奇）。 -/
noncomputable def seamQuadraticSign (s : SpinStructure) (P : Finset (Edge L)) : Qbar :=
  ((torusQuadraticSign s.1 s.2
    (decide ((edgeSetSeamParities P).1 = 1))
    (decide ((edgeSetSeamParities P).2 = 1)) : ℤ) : Qbar)

/-- `claim_pfaffian_signed_even_subgraph` の式鎖の一行目から四行目:
    `Pf(K^as) = Σ_{P ∈ 𝒲_L} χ_{a,b}(h(P), v(P)) x^{|P|}`。 -/
theorem gaugedPfaffian_eq_seamSignedEvenSubgraphSum (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
        qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card := by
  calc qbarPolynomialPfaffian (gaugedTerminalMatrix L z s)
      = ∑ D : PerfectMatching (OrientedEdge L),
          ∑ t ∈ (matchingOrientedPairs D).powerset, taggedMatchingTerm z s (D, t) :=
        -- 一行目: `claim_tagged_matching_expansion`
        gaugedPfaffian_taggedMatchingExpansion L z s
    _ = ∑ x ∈ labelledMatchings L, taggedMatchingTerm z s x := by
        -- 二重和を、標識の集合が対に含まれる組 `(D, T)` の和へ書き直す
        symm
        apply Finset.sum_finset_product
        intro x
        simp [labelledMatchings]
    _ = ∑ x ∈ (labelledMatchings L).filter (fun x => taggedMatchingTerm z s x ≠ 0),
          taggedMatchingTerm z s x := by
        -- 二行目: 零の項は和に寄与しない
        exact (Finset.sum_filter_ne_zero _).symm
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          ∑ x ∈ ((labelledMatchings L).filter (fun x => taggedMatchingTerm z s x ≠ 0)).filter
              (fun x => taggedComplementEdges x.1 x.2 = P),
            taggedMatchingTerm z s x := by
        -- 二行目: 非零項の補辺は偶部分グラフ（`claim_tagged_matching_even_complement`）なので、
        -- 補辺ごとの有限和へ再添字付けする
        refine (Finset.sum_fiberwise_of_maps_to (fun x hx => ?_) _).symm
        obtain ⟨hxl, hx0⟩ := Finset.mem_filter.mp hx
        have ht : x.2 ⊆ matchingOrientedPairs x.1 := (Finset.mem_filter.mp hxl).2
        exact Finset.mem_filter.mpr
          ⟨Finset.mem_univ _, taggedMatching_even_complement z s x.1 x.2 ht hx0⟩
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          ∑ x ∈ nonzeroTaggedMatchings z s P, taggedMatchingTerm z s x := by
        -- 二行目の内側の和の範囲は、補辺が `P` の非零項全体
        apply Finset.sum_congr rfl
        intro P _
        apply Finset.sum_congr _ (fun _ _ => rfl)
        ext x
        simp [labelledMatchings, nonzeroTaggedMatchings, taggedMatchingTerm, and_assoc]
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          ∑ x ∈ nonzeroTaggedMatchings z s P,
            qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card *
              qbarConst (((-1 : ℤ) ^ shortPairCrossingNumber x.2 : ℤ) : Qbar) := by
        -- 三行目: `claim_tagged_matching_quadratic_crossing_weight`
        apply Finset.sum_congr rfl
        intro P _
        apply Finset.sum_congr rfl
        intro x hx
        obtain ⟨_, ht, hterm, hP⟩ := Finset.mem_filter.mp hx
        rw [taggedMatchingTerm, taggedMatchingTerm_quadraticCrossingWeight x.1 x.2 z hz s ht hterm,
          hP, seamQuadraticSign, qbarConst, qbarConst, qbarConst, Polynomial.C_mul]
        push_cast
        ring
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card *
            qbarConst (((∑ x ∈ nonzeroTaggedMatchings z s P,
              (-1 : ℤ) ^ shortPairCrossingNumber x.2 : ℤ)) : Qbar) := by
        -- 三行目: 分配則で補辺の重みを外へ出す
        apply Finset.sum_congr rfl
        intro P _
        rw [← Finset.mul_sum]
        simp only [qbarConst, Int.cast_sum, map_sum]
    _ = ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
          qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card := by
        -- 四行目: `claim_local_pairing_signed_sum`（各偶部分グラフの上の符号の和は一）
        apply Finset.sum_congr rfl
        intro P hP
        rw [nonzeroTaggedMatchings_signed_crossing_sum_eq_one z hz s P (Finset.mem_filter.mp hP).2,
          Int.cast_one]
        simp [qbarConst]

end Ising2DLambda.KacWard
