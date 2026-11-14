import Ising2DLambda.KacWard.PfaffianComplementFiberSum
import Ising2DLambda.NecSuf.KacWard.PfaffianComplementFiberSum

/-!
具体版 `gaugedPfaffian_eq_seamSignedEvenSubgraphSum`（`claim_pfaffian_signed_even_subgraph` の式鎖の
一行目から四行目）を、必要十分版 `sum_eq_sum_over_complements_of_fiber_signs` を
項の集合 `labelledMatchings L`・補辺の集合 `𝒲_L`・項 `taggedMatchingTerm z s`・補辺 `taggedComplementEdges`・
重み `χ_{a,b}(h(P), v(P)) x^{|P|}`・符号 `(-1)^{t(D,T)}` に特殊化して得る導出版。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero
open scoped Classical

variable {L : ℕ} [NeZero L]

theorem gaugedPfaffian_eq_seamSignedEvenSubgraphSum_from_necSuf (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      ∑ P ∈ (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L),
        qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card := by
  have hexp : qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      ∑ x ∈ labelledMatchings L, taggedMatchingTerm z s x := by
    rw [gaugedPfaffian_taggedMatchingExpansion L z s]
    symm
    apply Finset.sum_finset_product
    intro x
    simp [labelledMatchings]
  rw [hexp]
  refine Ising2DLambda.NecSuf.KacWard.sum_eq_sum_over_complements_of_fiber_signs
    (labelledMatchings L) ((univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L))
    (taggedMatchingTerm z s) (fun x => taggedComplementEdges x.1 x.2)
    (fun P => qbarConst (seamQuadraticSign s P) * Polynomial.X ^ P.card)
    (fun x => qbarConst (((-1 : ℤ) ^ shortPairCrossingNumber x.2 : ℤ) : Qbar))
    ?_ ?_ ?_
  · intro x hx hx0
    exact Finset.mem_filter.mpr ⟨Finset.mem_univ _,
      taggedMatching_even_complement z s x.1 x.2 (Finset.mem_filter.mp hx).2 hx0⟩
  · intro x hx hx0
    rw [taggedMatchingTerm, taggedMatchingTerm_quadraticCrossingWeight x.1 x.2 z hz s
      (Finset.mem_filter.mp hx).2 hx0, seamQuadraticSign, qbarConst, qbarConst, qbarConst,
      Polynomial.C_mul]
    push_cast
    ring
  · intro P hP
    rw [Finset.sum_congr (s₂ := nonzeroTaggedMatchings z s P) (by
      ext x
      simp [labelledMatchings, nonzeroTaggedMatchings, taggedMatchingTerm]) (fun _ _ => rfl)]
    simp only [qbarConst]
    rw [← map_sum, ← Int.cast_sum,
      nonzeroTaggedMatchings_signed_crossing_sum_eq_one z hz s P (Finset.mem_filter.mp hP).2,
      Int.cast_one, Polynomial.C_1]

end Ising2DLambda.KacWard
