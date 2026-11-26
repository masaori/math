/- `Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordSignMap` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairWordSignMap
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordSignMap

namespace Ising2DLambda.AlgebraicEigenvalue

open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
open Ising2DLambda.AlgebraicEigenvalue.IndependentFiniteOrderedSign (finiteOrderedSign)

variable {J : Type*} [Fintype J] [LinearOrder J]

private theorem wordPermutation_eq_necSuf (v : List J) (hv : IsCompleteWord v) :
    matchingWordPermutation v hv =
      NecSuf.AlgebraicEigenvalue.completeWordPermutation (matchingBaseWord J) v
        matchingBaseWord_complete hv := by
  classical
  ext x
  obtain ⟨k, hk⟩ := List.mem_iff_get.mp (matchingBaseWord_complete.2 x)
  rw [← hk, matchingWordPermutation_apply_get]
  simp [NecSuf.AlgebraicEigenvalue.completeWordPermutation,
    List.Nodup.getEquivOfForallMemList, finCongr, matchingBaseWord_complete.1]

/-- The general word argument specializes to the actual matching pair. -/
theorem matchingPairWordSignMap_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (w : List J) (hw : ∀ i ∈ w, i ∈ matchingPairColor τ υ)
    (hcomplete : IsCompleteWord (w.flatMap (fun i => [i, τ.val i]))) :
    matchingWordSign (w.flatMap (fun i => [τ.val i, υ.val (τ.val i)])) =
      sign (fun x y : J => x < y) (matchingPairPermutation τ υ) *
        matchingWordSign (w.flatMap (fun i => [i, τ.val i])) := by
  classical
  rw [← matchingPairWordMap τ υ w hw]
  have hb : NecSuf.AlgebraicEigenvalue.IsCompleteWord (matchingBaseWord J) :=
    matchingBaseWord_complete
  have hf : NecSuf.AlgebraicEigenvalue.IsCompleteWord
      (w.flatMap (fun i => [i, τ.val i])) := hcomplete
  have h := NecSuf.AlgebraicEigenvalue.matchingPairWordSignMap_necSuf
    (matchingBaseWord J) _ hb hf (matchingPairPermutation τ υ)
  have hm := completeWord_map (w.flatMap (fun i => [i, τ.val i])) hcomplete
    (matchingPairPermutation τ υ)
  rw [matchingWordSign_eq _ hm, matchingWordSign_eq _ hcomplete]
  rw [wordPermutation_eq_necSuf _ hm, wordPermutation_eq_necSuf _ hcomplete]
  simpa [
    IndependentFiniteOrderedSign.finiteOrderedSign,
    IndependentFiniteOrderedSign.finiteOrderedInversionCount,
    IndependentFiniteOrderedSign.finiteOrderedPairs,
    NecSuf.AlgebraicEigenvalue.sign,
    NecSuf.AlgebraicEigenvalue.inversionCount,
    NecSuf.AlgebraicEigenvalue.orderedPairs] using h

end Ising2DLambda.AlgebraicEigenvalue
