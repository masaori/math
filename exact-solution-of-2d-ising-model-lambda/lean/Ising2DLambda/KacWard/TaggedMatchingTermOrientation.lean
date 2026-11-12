/-
「非零項は閉歩道ごとのねじれ・回転位相の積に分かれる」（claim_tagged_matching_cycle_weight）の
具体版のうち、項を向き付き対の列で書き直す段（本文の主鎖の二行目「昇順への向き直し」）。
展開 `gaugedPfaffian_taggedMatchingExpansion` の項は昇順対の上の積である。実際の完全マッチング D の
対を任意の向きで並べた列 l について、各対の寄与を l の向きで読むと、昇順へ直す符号 η の積だけが
前に出る。

  人手証明                                              このファイル
  長い標識の寄与は対の向きを変えると符号を変える        `gaugedLongContribution_swap`
  短い標識の寄与は対の向きを変えると符号を変える        `gaugedShortContribution_swap`
  昇順対の寄与 = η(p) · 向き付き対 p の寄与              `taggedContribution_ascendingPair`
  長い対の積と短い対の積を標識で読む一つの積へまとめる  `taggedMatchingTerm_labelledProduct`
  本文の向き直し                                        `taggedMatchingTerm_oriented`

二つの寄与の符号反転は、反対称化した端末行列の係数の反対称性（`gaugeLongCoefficient_skew`・
`gaugeShortCoefficient_skew`）から得る。必要十分版は呼ばない。住処は有限集合・ℤ・Qbar・Qbar[x] で、
ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.TaggedMatchingExpansion
import Ising2DLambda.KacWard.AlternatingCycleMatchingSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {L : ℕ}

/-- 長い標識の寄与は、対の向きを変えると符号を変える。𝖫_{f,e} = -𝖫_{e,f}。 -/
theorem gaugedLongContribution_swap (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) :
    gaugedLongContribution z s (p.2, p.1) = -gaugedLongContribution z s p := by
  calc
    gaugedLongContribution z s (p.2, p.1) =
        qbarConst (if p.1 = reversal p.2 then gaugePairWeight z s p.2 p.1 else 0) := rfl
    _ = qbarConst (-(if p.2 = reversal p.1 then gaugePairWeight z s p.1 p.2 else 0)) := by
      rw [gaugeLongCoefficient_skew z hz s p.2 p.1]
    _ = -qbarConst (if p.2 = reversal p.1 then gaugePairWeight z s p.1 p.2 else 0) :=
      Polynomial.C_neg
    _ = -gaugedLongContribution z s p := rfl

/-- 短い標識の寄与は、対の向きを変えると符号を変える。𝖲_{f,e} = -𝖲_{e,f}。 -/
theorem gaugedShortContribution_swap (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (p : OrientedEdge L × OrientedEdge L) :
    gaugedShortContribution z s (p.2, p.1) = -gaugedShortContribution z s p := by
  calc
    gaugedShortContribution z s (p.2, p.1) =
        Polynomial.X * qbarConst (if orientedSource p.1 = orientedSource p.2 ∧ p.1 ≠ p.2 then
          gaugePairWeight z s p.2 p.1 *
            ((twistSign s p.1 : Qbar) * rotationPhase z (reversal p.2) p.1) else 0) := rfl
    _ = Polynomial.X * qbarConst (-(if orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 then
          gaugePairWeight z s p.1 p.2 *
            ((twistSign s p.2 : Qbar) * rotationPhase z (reversal p.1) p.2) else 0)) := by
      rw [gaugeShortCoefficient_skew z hz s p.2 p.1]
    _ = Polynomial.X * -qbarConst (if orientedSource p.2 = orientedSource p.1 ∧ p.2 ≠ p.1 then
          gaugePairWeight z s p.1 p.2 *
            ((twistSign s p.2 : Qbar) * rotationPhase z (reversal p.1) p.2) else 0) := by
      rw [qbarConst, qbarConst, Polynomial.C_neg]
    _ = -gaugedShortContribution z s p := mul_neg _ _

/-- 標識の集合 t で読む寄与。昇順対 q が t に在れば短い標識、無ければ長い標識の寄与。 -/
noncomputable def taggedContribution (z : Qbar) (s : SpinStructure)
    (t : Finset (OrientedEdge L × OrientedEdge L)) (q : OrientedEdge L × OrientedEdge L) :
    Polynomial Qbar :=
  if q ∈ t then gaugedShortContribution z s q else gaugedLongContribution z s q

/-- 向き付き対 p の寄与。標識は p を昇順へ直した対が t に在るかで決め、値は p の向きで読む。 -/
noncomputable def orientedTaggedContribution (z : Qbar) (s : SpinStructure)
    (t : Finset (OrientedEdge L × OrientedEdge L)) (p : OrientedEdge L × OrientedEdge L) :
    Polynomial Qbar :=
  if ascendingPair p ∈ t then gaugedShortContribution z s p else gaugedLongContribution z s p

/-- 昇順へ直した対の寄与は、η(p) と向き付き対 p の寄与の積である。 -/
theorem taggedContribution_ascendingPair (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (t : Finset (OrientedEdge L × OrientedEdge L)) (p : OrientedEdge L × OrientedEdge L) :
    taggedContribution z s t (ascendingPair p) =
      qbarConst ((pairOrientation p : ℤ) : Qbar) * orientedTaggedContribution z s t p := by
  by_cases hlt : p.1 < p.2
  · have hasc : ascendingPair p = p := if_pos hlt
    calc
      taggedContribution z s t (ascendingPair p) = taggedContribution z s t p := by rw [hasc]
      _ = orientedTaggedContribution z s t p := by
        simp only [taggedContribution, orientedTaggedContribution, hasc]
      _ = qbarConst (((1 : ℤ) : Qbar)) * orientedTaggedContribution z s t p := by
        rw [Int.cast_one, qbarConst, Polynomial.C_1, one_mul]
      _ = qbarConst ((pairOrientation p : ℤ) : Qbar) * orientedTaggedContribution z s t p := by
        rw [pairOrientation, if_pos hlt]
  · have hasc : ascendingPair p = (p.2, p.1) := if_neg hlt
    have hswap : taggedContribution z s t (p.2, p.1) = -orientedTaggedContribution z s t p := by
      by_cases hmem : ascendingPair p ∈ t
      · rw [hasc] at hmem
        simp only [taggedContribution, orientedTaggedContribution, hasc, if_pos hmem]
        exact gaugedShortContribution_swap z hz s p
      · rw [hasc] at hmem
        simp only [taggedContribution, orientedTaggedContribution, hasc, if_neg hmem]
        exact gaugedLongContribution_swap z hz s p
    calc
      taggedContribution z s t (ascendingPair p) = taggedContribution z s t (p.2, p.1) := by
        rw [hasc]
      _ = -orientedTaggedContribution z s t p := hswap
      _ = qbarConst (((-1 : ℤ) : Qbar)) * orientedTaggedContribution z s t p := by
        rw [Int.cast_neg, Int.cast_one, qbarConst, Polynomial.C_neg, Polynomial.C_1, neg_one_mul]
      _ = qbarConst ((pairOrientation p : ℤ) : Qbar) * orientedTaggedContribution z s t p := by
        rw [pairOrientation, if_neg hlt]

/-- 本文の項の長い対の積と短い対の積は、昇順対の上で標識により読み分けた一つの積である。 -/
theorem taggedMatchingTerm_labelledProduct (z : Qbar) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D) :
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
      ∏ q ∈ matchingOrientedPairs D, taggedContribution z s t q := by
  calc
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
        (∏ q ∈ (matchingOrientedPairs D).filter (· ∈ t), gaugedShortContribution z s q) *
          (∏ q ∈ (matchingOrientedPairs D).filter (· ∉ t), gaugedLongContribution z s q) := by
      rw [Finset.filter_mem_eq_inter, Finset.inter_eq_right.mpr ht, Finset.filter_notMem_eq_sdiff,
        mul_comm]
    _ = ∏ q ∈ matchingOrientedPairs D, taggedContribution z s t q :=
      (Finset.prod_ite _ _).symm

/-- 本文の向き直し。D の対を任意の向きで並べた列 l について、項の寄与の積は
    η の積と、l の向きで読んだ寄与の積の積である。 -/
theorem taggedMatchingTerm_oriented (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure)
    (D : PerfectMatching (OrientedEdge L)) (t : Finset (OrientedEdge L × OrientedEdge L))
    (ht : t ⊆ matchingOrientedPairs D) (l : List (OrientedEdge L × OrientedEdge L))
    (hc : IsCompleteWord (matchingPairWord l))
    (hD : ∀ p ∈ l, ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val) :
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
      qbarConst (((l.map pairOrientation).prod : ℤ) : Qbar) *
        (l.map (orientedTaggedContribution z s t)).prod := by
  have hen := ascendingPairs_enumeration D l hc hD
  have hfin : matchingOrientedPairs D = (l.map ascendingPair).toFinset := by
    ext q
    rw [List.mem_toFinset]
    exact (hen.2 q).symm
  calc
    (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p) =
        ∏ q ∈ matchingOrientedPairs D, taggedContribution z s t q :=
      taggedMatchingTerm_labelledProduct z s D t ht
    _ = ((l.map ascendingPair).map (taggedContribution z s t)).prod := by
      rw [hfin, List.prod_toFinset _ hen.1]
    _ = (l.map (fun p => qbarConst ((pairOrientation p : ℤ) : Qbar) *
          orientedTaggedContribution z s t p)).prod := by
      rw [List.map_map]
      congr 1
      exact List.map_congr_left fun p _ => taggedContribution_ascendingPair z hz s t p
    _ = (l.map (fun p => qbarConst ((pairOrientation p : ℤ) : Qbar))).prod *
          (l.map (orientedTaggedContribution z s t)).prod := List.prod_map_mul
    _ = qbarConst (((l.map pairOrientation).prod : ℤ) : Qbar) *
          (l.map (orientedTaggedContribution z s t)).prod := by
      congr 1
      rw [Int.cast_list_prod, List.map_map, qbarConst, map_list_prod, List.map_map]
      rfl

end Ising2DLambda.KacWard
