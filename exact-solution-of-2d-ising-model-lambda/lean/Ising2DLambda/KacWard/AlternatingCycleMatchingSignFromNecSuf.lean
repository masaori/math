/-
具体版 `alternatingCycleWords_matching_sign` を必要十分版の特殊化として得る。
F は転倒符号による端点列の符号 `matchingWordSign`、R = ℤ、D₀ は基準完全マッチング、
J は辞書式順序の向き付き辺とする。隣接交換の符号反転は `matchingWordSign_swap`、
sgn(D) の平方が一であることは `perfectMatchingSign_eq_one_or_neg_one` で満たす。
-/
import Ising2DLambda.KacWard.AlternatingCycleMatchingSign
import Ising2DLambda.NecSuf.KacWard.AlternatingCycleMatchingSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem alternatingCycleWords_matching_sign_from_necSuf {L : ℕ}
    (D : PerfectMatching (OrientedEdge L))
    (cs : List (List (OrientedEdge L))) (P : List (OrientedEdge L × OrientedEdge L))
    (hev : ∀ c ∈ cs, c ≠ [] ∧ Even c.length)
    (hc : IsCompleteWord (cs.flatten ++ matchingPairWord P))
    (hD : ∀ c ∈ cs, ∀ p ∈ consecutivePairs c,
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val)
    (h₀ : ∀ c ∈ cs, ∀ p ∈ consecutivePairs (c.rotate 1),
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val)
    (hP : ∀ p ∈ P, p.1 < p.2 ∧ ({p.1, p.2} : Set (OrientedEdge L)) ∈ D.val ∧
      ({p.1, p.2} : Set (OrientedEdge L)) ∈ (referenceLongMatching L).val) :
    perfectMatchingSign D * perfectMatchingSign (referenceLongMatching L) =
      (-1) ^ cs.length *
        (cs.map (fun c => cycleShortOrientation c * cycleReferenceOrientation c)).prod := by
  have hsD : perfectMatchingSign D * perfectMatchingSign D = 1 := by
    rcases perfectMatchingSign_eq_one_or_neg_one D with h | h <;> simp [h]
  exact NecSuf.KacWard.alternating_cycle_matching_sign_necSuf (R := ℤ) matchingWordSign
    matchingWordSign_swap D (referenceLongMatching L) cs P hev hc hD h₀ hP hsD

end Ising2DLambda.KacWard
