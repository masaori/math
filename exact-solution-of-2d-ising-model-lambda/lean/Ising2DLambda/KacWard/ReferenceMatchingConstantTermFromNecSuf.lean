/-
「基準マッチングの長い標識の項は一である」の具体版が必要十分版の特殊化として得られることの記録。
符号の段は J = 向き付き辺・D = 𝒟₀・l = 辺番号順の列挙、重みの段は G = Qbar・p = 方向の指数・
q = ねじれの指数、項の段は K = Qbar・R = Qbar[x]・C = 定数多項式・a = 各辺の二向きの対と取る。
-/
import Ising2DLambda.KacWard.ReferenceMatchingConstantTerm
import Ising2DLambda.NecSuf.KacWard.ReferenceMatchingConstantTerm

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign sign_one)

/-- 昇順の全元列が定める置換は恒等置換である。 -/
theorem referenceBaseWord_permutation_eq_one {J : Type*} [Fintype J] [LinearOrder J] :
    matchingWordPermutation (matchingBaseWord J) matchingBaseWord_complete = 1 := by
  ext x
  obtain ⟨k, hk⟩ := List.mem_iff_get.mp (matchingBaseWord_complete.2 x)
  rw [← hk, matchingWordPermutation_apply_get]
  rfl

theorem referenceLongMatching_sign_from_necSuf (L : ℕ) :
    perfectMatchingSign (referenceLongMatching L) = 1 := by
  have hc := matchingEnumeration_complete _ _ (referenceLongEnumeration_spec L)
  have hbase : matchingPairWord (referenceLongEnumeration L) =
      matchingBaseWord (OrientedEdge L) := by
    simpa [matchingBaseWord] using
      Ising2DLambda.NecSuf.KacWard.sorted_complete_word_eq_base
        (matchingPairWord (referenceLongEnumeration L))
        (referenceLongPairWord_sortedLT L) hc.2
  calc
    perfectMatchingSign (referenceLongMatching L) =
        matchingWordSign (matchingPairWord (referenceLongEnumeration L)) :=
      (perfectMatchingSign_enumeration_independent _ _ (referenceLongEnumeration_spec L)).symm
    _ = matchingWordSign (matchingBaseWord (OrientedEdge L)) := by rw [hbase]
    _ = sign (fun x y : OrientedEdge L => x < y)
          (matchingWordPermutation (matchingBaseWord (OrientedEdge L))
            matchingBaseWord_complete) := matchingWordSign_eq _ _
    _ = sign (fun x y : OrientedEdge L => x < y) 1 := by
      rw [referenceBaseWord_permutation_eq_one]
    _ = 1 := Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign_one _
      Ising2DLambda.NecSuf.KacWard.trichotomous_of_linearOrder

theorem referenceLong_gaugePairWeight_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) (e : Edge L) :
    gaugePairWeight z s ((e, false) : OrientedEdge L) ((e, true) : OrientedEdge L) = 1 := by
  have hp : directionGaugeExponent ((e, true) : OrientedEdge L) =
      directionGaugeExponent ((e, false) : OrientedEdge L) - 2 := by
    simp only [directionGaugeExponent, directionStandardRepresentative_referenceLong]
    ring
  exact Ising2DLambda.NecSuf.KacWard.reference_pair_weight_necSuf z
    (diagonalGauge_root_ne_zero z hz) directionGaugeExponent (twistGaugeExponent s)
    ((e, false) : OrientedEdge L) ((e, true) : OrientedEdge L) rfl hp

theorem referenceMatching_constantTerm_from_necSuf {L : ℕ} (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    matchingSignPolynomial (referenceLongMatching L) *
        ((-1 : Polynomial Qbar) ^ (∅ : Finset (OrientedEdge L × OrientedEdge L)).card *
          (∏ p ∈ matchingOrientedPairs (referenceLongMatching L) \ ∅,
            gaugedLongContribution z s p) *
          (∏ p ∈ (∅ : Finset (OrientedEdge L × OrientedEdge L)),
            gaugedShortContribution z s p)) = 1 :=
  Ising2DLambda.NecSuf.KacWard.reference_term_necSuf Polynomial.C
    (perfectMatchingSign (referenceLongMatching L)) (referenceLongMatching_sign_from_necSuf L)
    _ referenceLongPair (referenceLongPair_injective L) (referenceLongMatching_orientedPairs L)
    (fun p => p.2 = reversal p.1) (fun p => gaugePairWeight z s p.1 p.2)
    (gaugedShortContribution z s) (fun _ => rfl)
    (fun e => referenceLong_gaugePairWeight_from_necSuf z hz s e)

end Ising2DLambda.KacWard
