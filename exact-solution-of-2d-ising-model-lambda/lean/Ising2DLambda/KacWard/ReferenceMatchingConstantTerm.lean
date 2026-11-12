/-
「基準マッチングの長い標識の項は一である」（claim_reference_matching_constant_term）の具体版。
実際の基準完全マッチング（referenceLongPairs）、辞書式順序 orientedEdgeLinearOrder、
重み gaugePairWeight と長い寄与 gaugedLongContribution について、本文の三つの式鎖を順に示す。

  人手証明                                        このファイル
  各辺の二向きの隣接対を辺番号順に並べた列挙        `referenceLongEnumeration_spec`
  端点列は昇順の全元列に一致する                    `referenceLongPairWord_eq_base`
  sgn(D₀) = sgn(id) = 1                            `referenceLongMatching_sign`
  w_{(e,0),(e,1)} の四等号                          `referenceLong_gaugePairWeight`
  長い寄与の三等号                                  `referenceLong_longContribution`
  M_{D₀,∅}(x) の三等号                              `referenceMatching_constantTerm`

必要十分版は呼ばない。住処は有限集合・ℤ・Qbar・Qbar[x] で、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.TaggedMatchingExpansion
import Ising2DLambda.KacWard.ReferenceLongMatching
import Mathlib.Data.List.Sort

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign inversionCount orderedPairs)

/-- 本文の基準完全マッチング 𝒟₀ を、完全マッチングの型の元として置く。 -/
def referenceLongMatching (L : ℕ) : PerfectMatching (OrientedEdge L) :=
  ⟨referenceLongPairs L, referenceLongMatching_isPerfectMatching L⟩

/-- 辺 e の二向きの昇順対 ((e,0),(e,1))。 -/
def referenceLongPair {L : ℕ} (e : Edge L) : OrientedEdge L × OrientedEdge L :=
  ((e, false), (e, true))

lemma referenceLongPair_injective (L : ℕ) :
    Function.Injective (referenceLongPair (L := L)) := by
  intro e f h
  exact congrArg Prod.fst (congrArg Prod.fst h)

/-- 各辺の二向きは辞書式順序で (e,0) ≺ (e,1) と並ぶ。 -/
lemma referenceLongPair_lt {L : ℕ} (e : Edge L) :
    (referenceLongPair e).1 < (referenceLongPair e).2 :=
  (orientedEdge_lt_iff L _ _).mpr (Or.inr ⟨rfl, Bool.false_lt_true⟩)

/-- 𝒟₀ の昇順対は、各辺の二向きの対に限る。 -/
theorem referenceLongMatching_orientedPairs (L : ℕ) :
    matchingOrientedPairs (referenceLongMatching L) = univ.image referenceLongPair := by
  classical
  ext p
  simp only [matchingOrientedPairs, mem_filter, mem_univ, true_and, mem_image]
  constructor
  · rintro ⟨hlt, f, hf⟩
    have hrev : p.2 = reversal p.1 := by
      rcases Set.pair_eq_pair_iff.mp hf with h | h
      · rw [h.1, h.2]
      · rw [h.1, h.2, reversal_involutive]
    have hdir : p.1.2 = false := by
      rw [hrev] at hlt
      rcases (orientedEdge_lt_iff L _ _).mp hlt with h | h
      · exact absurd h (lt_irrefl _)
      · revert h
        cases p.1.2 <;> simp [reversal]
    refine ⟨p.1.1, ?_⟩
    rcases p with ⟨⟨e, d⟩, q⟩
    simp only at hdir hrev
    subst hdir
    rw [hrev]
    rfl
  · rintro ⟨e, rfl⟩
    exact ⟨referenceLongPair_lt e, (e, false), rfl⟩

/-- 本文の列挙: 各辺の二向きの隣接対を辺番号順に並べた列。 -/
def referenceLongEnumeration (L : ℕ) : List (OrientedEdge L × OrientedEdge L) :=
  (List.finRange (2 * L ^ 2)).map referenceLongPair

/-- この列は基準完全マッチングの列挙である。 -/
theorem referenceLongEnumeration_spec (L : ℕ) :
    IsMatchingEnumeration (referenceLongMatching L) (referenceLongEnumeration L) := by
  refine ⟨(List.nodup_finRange _).map (referenceLongPair_injective L), fun p => ?_⟩
  rw [referenceLongMatching_orientedPairs]
  simp only [referenceLongEnumeration, List.mem_map, mem_image, mem_univ, true_and]
  exact ⟨fun ⟨a, _, h⟩ => ⟨a, h⟩, fun ⟨a, h⟩ => ⟨a, List.mem_finRange a, h⟩⟩

/-- 列挙の端点列は辞書式順序で狭義増加である。 -/
theorem referenceLongPairWord_sortedLT (L : ℕ) :
    (matchingPairWord (referenceLongEnumeration L)).SortedLT := by
  rw [List.sortedLT_iff_pairwise, matchingPairWord, referenceLongEnumeration,
    List.flatMap_map, List.pairwise_flatMap]
  refine ⟨fun e _ => ?_, ?_⟩
  · simpa using referenceLongPair_lt e
  · refine (List.sortedLT_finRange (2 * L ^ 2)).pairwise.imp ?_
    intro e f hef x hx y hy
    simp only [referenceLongPair, List.mem_cons, List.not_mem_nil, or_false] at hx hy
    refine (orientedEdge_lt_iff L x y).mpr (Or.inl ?_)
    rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;> exact hef

/-- 端点列は昇順の全元列に一致する。 -/
theorem referenceLongPairWord_eq_base (L : ℕ) :
    matchingPairWord (referenceLongEnumeration L) = matchingBaseWord (OrientedEdge L) := by
  have hc := matchingEnumeration_complete _ _ (referenceLongEnumeration_spec L)
  exact (referenceLongPairWord_sortedLT L).eq_of_mem_iff (Finset.sortedLT_sort univ)
    (fun x => iff_of_true (hc.2 x) (matchingBaseWord_complete.2 x))

/-- 昇順の全元列が定める置換は恒等置換である。 -/
theorem matchingWordPermutation_baseWord {J : Type*} [Fintype J] [LinearOrder J] :
    matchingWordPermutation (matchingBaseWord J) matchingBaseWord_complete = 1 := by
  ext x
  obtain ⟨k, hk⟩ := List.mem_iff_get.mp (matchingBaseWord_complete.2 x)
  rw [← hk, matchingWordPermutation_apply_get]
  rfl

/-- 恒等置換の符号は一。恒等置換は昇順の対の順序を入れ替えないので、転倒数は零である。 -/
lemma sign_identity_eq_one {J : Type*} [Fintype J] [LinearOrder J] :
    sign (fun x y : J => x < y) (1 : Equiv.Perm J) = 1 := by
  have hinv : inversionCount (fun x y : J => x < y) (1 : Equiv.Perm J) = 0 := by
    rw [inversionCount, Finset.card_eq_zero, Finset.filter_eq_empty_iff]
    intro p hp
    have hlt : p.1 < p.2 := by simpa [orderedPairs] using hp
    exact lt_asymm hlt
  rw [sign, hinv, pow_zero]

/-- 本文の符号の二等号。sgn(𝒟₀) = sgn(id) = 1。 -/
theorem referenceLongMatching_sign (L : ℕ) :
    perfectMatchingSign (referenceLongMatching L) = 1 := by
  calc
    perfectMatchingSign (referenceLongMatching L) =
        matchingWordSign (matchingPairWord (referenceLongEnumeration L)) :=
      (perfectMatchingSign_enumeration_independent _ _ (referenceLongEnumeration_spec L)).symm
    _ = matchingWordSign (matchingBaseWord (OrientedEdge L)) := by
      rw [referenceLongPairWord_eq_base]
    _ = sign (fun x y : OrientedEdge L => x < y)
          (matchingWordPermutation (matchingBaseWord (OrientedEdge L))
            matchingBaseWord_complete) := matchingWordSign_eq _ _
    _ = sign (fun x y : OrientedEdge L => x < y) 1 := by
      rw [matchingWordPermutation_baseWord]
    _ = 1 := sign_identity_eq_one

/-- 方向代表は横辺で (0,2)、縦辺で (1,3) なので、反転した向きの代表は二だけ大きい。 -/
lemma directionStandardRepresentative_referenceLong {L : ℕ} (e : Edge L) :
    directionStandardRepresentative (directionNumber ((e, true) : OrientedEdge L)) =
      directionStandardRepresentative (directionNumber ((e, false) : OrientedEdge L)) + 2 := by
  by_cases hk : e.val < L ^ 2 <;> simp [directionNumber, hk] <;> rfl

/-- 本文の重みの四等号。w_{(e,0),(e,1)} = ζ₈^{2 + r(dir(e,0)) - r(dir(e,1))} = ζ₈⁰ = 1。 -/
theorem referenceLong_gaugePairWeight {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : Edge L) :
    gaugePairWeight z s ((e, false) : OrientedEdge L) ((e, true) : OrientedEdge L) = 1 := by
  have hnz := diagonalGauge_root_ne_zero z hz
  let r0 := directionStandardRepresentative (directionNumber ((e, false) : OrientedEdge L))
  let r1 := directionStandardRepresentative (directionNumber ((e, true) : OrientedEdge L))
  let q := twistGaugeExponent s ((e, false) : OrientedEdge L)
  have hq : twistGaugeExponent s ((e, true) : OrientedEdge L) = q := rfl
  calc
    gaugePairWeight z s ((e, false) : OrientedEdge L) ((e, true) : OrientedEdge L) =
        z ^ (2 : ℕ) * ((z ^ (-q) * z ^ r0) * (z ^ (-r1) * z ^ q)) := by
      simp only [gaugePairWeight, diagonalGaugeInverseWeight, diagonalGaugeWeight,
        directionGaugeExponent, hq, neg_neg, r0, r1, q]
    _ = z ^ ((2 : ℤ) + r0 - r1) := by
      rw [← zpow_natCast z 2, ← zpow_add₀ hnz (-q), ← zpow_add₀ hnz (-r1), ← zpow_add₀ hnz,
        ← zpow_add₀ hnz]
      congr 1
      ring
    _ = z ^ (0 : ℤ) := by
      congr 1
      simp only [r0, r1, directionStandardRepresentative_referenceLong]
      ring
    _ = 1 := zpow_zero z

/-- 本文の長い寄与の三等号。𝖫_{(e,0),(e,1)} = C(w) = C(1) = 1。 -/
theorem referenceLong_longContribution {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : Edge L) :
    gaugedLongContribution z s (referenceLongPair e) = 1 := by
  calc
    gaugedLongContribution z s (referenceLongPair e) =
        qbarConst (gaugePairWeight z s ((e, false) : OrientedEdge L)
          ((e, true) : OrientedEdge L)) := by
      rw [gaugedLongContribution]
      exact congrArg qbarConst
        (if_pos (rfl : (referenceLongPair e).2 = reversal (referenceLongPair e).1))
    _ = qbarConst 1 := by rw [referenceLong_gaugePairWeight z hz s e]
    _ = 1 := Polynomial.C_1

/-- 本文の主張。`gaugedPfaffian_taggedMatchingExpansion` の (𝒟₀, ∅) の項は一である。 -/
theorem referenceMatching_constantTerm {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    matchingSignPolynomial (referenceLongMatching L) *
        ((-1 : Polynomial Qbar) ^ (∅ : Finset (OrientedEdge L × OrientedEdge L)).card *
          (∏ p ∈ matchingOrientedPairs (referenceLongMatching L) \ ∅,
            gaugedLongContribution z s p) *
          (∏ p ∈ (∅ : Finset (OrientedEdge L × OrientedEdge L)),
            gaugedShortContribution z s p)) = 1 := by
  calc
    matchingSignPolynomial (referenceLongMatching L) *
        ((-1 : Polynomial Qbar) ^ (∅ : Finset (OrientedEdge L × OrientedEdge L)).card *
          (∏ p ∈ matchingOrientedPairs (referenceLongMatching L) \ ∅,
            gaugedLongContribution z s p) *
          (∏ p ∈ (∅ : Finset (OrientedEdge L × OrientedEdge L)),
            gaugedShortContribution z s p)) =
        Polynomial.C ((perfectMatchingSign (referenceLongMatching L) : ℤ) : Qbar) *
          ∏ e : Edge L, gaugedLongContribution z s (referenceLongPair e) := by
      rw [card_empty, pow_zero, sdiff_empty, prod_empty, one_mul, mul_one,
        referenceLongMatching_orientedPairs,
        prod_image (fun a _ b _ h => referenceLongPair_injective L h)]
      rfl
    _ = Polynomial.C (((1 : ℤ) : Qbar)) * ∏ _e : Edge L, (1 : Polynomial Qbar) := by
      rw [referenceLongMatching_sign]
      congr 1
      exact Finset.prod_congr rfl fun e _ => referenceLong_longContribution z hz s e
    _ = 1 := by simp

end Ising2DLambda.KacWard
