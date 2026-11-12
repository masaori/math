/-
具体版 `taggedMatchingTerm_oriented` を必要十分版の特殊化として得る。
R = Qbar[x]、J は辞書式順序の向き付き辺、ℓ・𝔰 は長い標識・短い標識の寄与とし、
向きを変えたときの符号反転は `gaugedLongContribution_swap`・`gaugedShortContribution_swap` で満たす。
η の値の埋込みは、整数の像と定数多項式の一致（Polynomial.C の整数の像）で合わせる。
-/
import Ising2DLambda.KacWard.TaggedMatchingTermOrientation
import Ising2DLambda.NecSuf.KacWard.TaggedMatchingTermOrientation

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

theorem taggedMatchingTerm_oriented_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) (ht : t ⊆ matchingOrientedPairs D)
    (l : List (OrientedEdge L × OrientedEdge L)) (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val) :
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
      qbarConst (((l.map pairOrientation).prod : ℤ) : Qbar) *
        (l.map (orientedTaggedContribution z s t)).prod := by
  rw [NecSuf.KacWard.tagged_matching_term_oriented_necSuf (gaugedLongContribution z s)
    (gaugedShortContribution z s) (gaugedLongContribution_swap z hz s)
    (gaugedShortContribution_swap z hz s) D t ht l hc hD]
  congr 1
  rw [qbarConst, Polynomial.C_eq_intCast, Int.cast_list_prod, List.map_map]
  congr 1
  apply List.map_congr_left
  intro p _
  simp only [Function.comp, NecSuf.KacWard.pairOrientationIn, pairOrientation]
  split_ifs <;> simp
