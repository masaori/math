/-
具体版 `taggedMatchingTerm_quadraticCrossingWeight` を必要十分版
`tagged_matching_quadratic_crossing_weight_necSuf` の特殊化として得る。
K = Qbar、R = Qbar[x]、C = 定数多項式、閉路の族 = 交互閉路の最小元の集合、
φ = 閉路のねじれ符号・回転位相の積、ψ = 閉歩道の二次符号と横断数の符号とし、
前提は具体版の補題（閉路ごとの因子、閉路族の二次符号の積、横断対の分割、台の非交和）で満たす。
-/
import Ising2DLambda.KacWard.TaggedMatchingQuadraticCrossingWeight
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingQuadraticCrossingWeight

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

theorem taggedMatchingTerm_quadraticCrossingWeight_from_necSuf {L : ℕ} [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0) :
    matchingSignPolynomial D *
        ((-1 : Polynomial Qbar) ^ t.card *
          (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
          (∏ p ∈ t, gaugedShortContribution z s p)) =
      qbarConst (((torusQuadraticSign s.1 s.2
          (decide ((edgeSetSeamParities (taggedComplementEdges D t)).1 = 1))
          (decide ((edgeSetSeamParities (taggedComplementEdges D t)).2 = 1)) : ℤ) : Qbar) *
        (-1 : Qbar) ^ shortPairCrossingNumber t) *
      Polynomial.X ^ (taggedComplementEdges D t).card := by
  have hseam := taggedCycleSeam_sum_mod D t z s ht hterm
  have hfam := taggedCycleFamily_quadraticSign D t z s ht hterm s.1 s.2
  rw [hseam.1, hseam.2] at hfam
  have hlist : ∀ (F : TaggedActive D t → Polynomial Qbar) (l : List (TaggedActive D t)),
      l.Nodup → l.toFinset = taggedCycleMinima D t →
        (l.map F).prod = ∏ m ∈ (taggedCycleMinima D t).attach, F m.1 := by
    intro F l hnd hl
    rw [Finset.prod_attach (taggedCycleMinima D t) F, ← hl, List.prod_toFinset F hnd]
  exact Ising2DLambda.NecSuf.KacWard.tagged_matching_quadratic_crossing_weight_necSuf
    Polynomial.C Polynomial.X (taggedCycleMinima D t).attach (fun m => taggedCycleLength D t m.1)
    (fun m => taggedCyclePhase z s D t m.1)
    (fun m => ((torusQuadraticSign s.1 s.2
        (decide ((taggedCycleWalkData D t z s ht hterm m).seam.1 = 1))
        (decide ((taggedCycleWalkData D t z s ht hterm m).seam.2 = 1)) : ℤ) : Qbar) *
      (-1 : Qbar) ^ (taggedCycleWalkData D t z s ht hterm m).crossing)
    _ _ _ _ _
    (by rw [taggedMatchingTerm_cycleWeight z hz s D t ht hterm]
        exact hlist _ _ (by convert Finset.sort_nodup (taggedCycleMinima D t) (· ≤ ·))
          (by convert Finset.sort_toFinset (taggedCycleMinima D t) (· ≤ ·)))
    (fun m _ => taggedCyclePhase_quadraticSign_minimum D t hz s ht hterm m)
    hfam (shortPairCrossingNumber_cycleSplit D t z s ht hterm)
    (taggedComplementEdges_card D t z s ht hterm)

end Ising2DLambda.KacWard
