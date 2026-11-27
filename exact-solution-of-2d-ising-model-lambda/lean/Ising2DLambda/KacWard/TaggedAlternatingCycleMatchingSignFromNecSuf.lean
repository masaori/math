/-
具体版 `taggedAlternatingCycles_matching_sign` の符号の等式を、接続の段の必要十分版の特殊化として得る。
J は辞書式順序の向き付き辺、D₀ は基準完全マッチング、A は実際の標識付き対称差の活動点、
τ, υ は実際の短い・長い対合、F は転倒符号による端点列の符号 `matchingWordSign`、R = ℤ とする。
A の外で二つの相手が一致することは `inactive_mate_eq_reference`、隣接交換の符号反転は
`matchingWordSign_swap`、sgn(D) の平方が一であることは `perfectMatchingSign_eq_one_or_neg_one` で満たす。
-/
import Ising2DLambda.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.TaggedAlternatingCycleMatchingSign
import Ising2DLambda.KacWard.PairChunksFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
attribute [local instance] Classical.propDecidable

theorem taggedAlternatingCycles_matching_sign_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (t : Finset (OrientedEdge L × OrientedEdge L)) :
    perfectMatchingSign D * perfectMatchingSign (referenceLongMatching L) =
      (-1) ^ (taggedCycleMinima D t).card *
        ((taggedCycleWords D t).map
          (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
  have hsD : perfectMatchingSign D * perfectMatchingSign D = 1 := by
    rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> simp [h]
  have hτ : ∀ i, ((concreteShortInvolution D t).val i).1 = perfectMatchingMate D i.1 :=
    fun _ => rfl
  have hυ : ∀ i, ((concreteLongInvolution D t).val i).1 =
      perfectMatchingMate (referenceLongMatching L) i.1 := fun _ => rfl
  have h := NecSuf.KacWard.tagged_alternating_cycles_matching_sign_necSuf (R := ℤ)
    matchingWordSign matchingWordSign_swap D (referenceLongMatching L)
    (concreteTaggedActiveVertices D t) (concreteShortInvolution D t) (concreteLongInvolution D t)
    hτ hυ (fun e he => (inactive_mate_eq_reference D t e he).1) hsD
  have hminimum :
      NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum
          (concreteShortInvolution D t) (concreteLongInvolution D t) =
        matchingPairComponentMinimum
          (concreteShortInvolution D t) (concreteLongInvolution D t) := by
    funext i
    rfl
  have hm : NecSuf.KacWard.cycleMinimaOf
      (matchingPairComponentMinimum
        (concreteShortInvolution D t) (concreteLongInvolution D t)) = taggedCycleMinima D t := by
    ext x
    simp [NecSuf.KacWard.mem_cycleMinimaOf, taggedCycleMinima]
  have hw : NecSuf.KacWard.cycleWordsOf
      (NecSuf.AlgebraicEigenvalue.matchingPairComponentMinimum
        (concreteShortInvolution D t) (concreteLongInvolution D t))
      (finitePermutationMinimalPeriod (matchingPairPermutation
        (concreteShortInvolution D t) (concreteLongInvolution D t)))
      (finiteMapIterate (matchingPairPermutation
        (concreteShortInvolution D t) (concreteLongInvolution D t)))
      Subtype.val = taggedCycleWords D t := by
    unfold NecSuf.KacWard.cycleWordsOf taggedCycleWords
    rw [hminimum, hm]
    rfl
  have hη : NecSuf.KacWard.pairOrientationIn ℤ =
      (pairOrientation : OrientedEdge L × OrientedEdge L → ℤ) := rfl
  rw [hw, hminimum, hm, hη] at h
  simp only [pairChunks_eq_consecutivePairs] at h
  exact h

end Ising2DLambda.KacWard
