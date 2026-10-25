import Ising2DLambda.AlgebraicEigenvalue.MatchingPairOrientationProduct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairWordOrientationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 完全マッチングの対を一つずつ処理する。既処理の端点は前置列に残す。 -/
private theorem matchingOrientationSignAux (S : Set J) (l : List (J × J)) :
    ∀ u : List J, IsCompleteWord (u ++ matchingPairWord l) →
      matchingWordSign (u ++ l.flatMap (fun p =>
        if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      (l.map (fun p => if p.1 ∈ S then (1 : ℤ) else -1)).prod *
        matchingWordSign (u ++ matchingPairWord l) := by
  classical
  induction l with
  | nil => intro u _; simp [matchingPairWord]
  | cons p rest ih =>
      intro u hcomplete
      have hbase : IsCompleteWord (u ++ p.1 :: p.2 :: matchingPairWord rest) := by
        simpa [matchingPairWord] using hcomplete
      by_cases hp : p.1 ∈ S
      · have hstep := ih (u ++ [p.1, p.2]) (by simpa using hbase)
        simpa [matchingPairWord, hp, List.append_assoc] using hstep
      · have hswapped := completeWord_swap u p.1 p.2 (matchingPairWord rest) hbase
        have hstep := ih (u ++ [p.2, p.1]) (by simpa using hswapped)
        have hswap := matchingWordSign_swap u p.1 p.2 (matchingPairWord rest) hbase
        simp only [matchingPairWord, List.flatMap_cons, List.map_cons, List.prod_cons,
          if_neg hp] at hstep ⊢
        simp only [matchingPairWord] at hswap
        simp only [List.append_assoc, List.cons_append, List.nil_append] at hstep hswap ⊢
        rw [hstep, hswap]
        ring

/-- 実際の昇順マッチングの符号へ、選んだ側から書いた端点列の符号を直す。 -/
theorem matchingPairWordOrientationSign (D : PerfectMatching J) (S : Set J) :
    matchingWordSign ((matchingCanonicalEnumeration D).flatMap (fun p =>
      if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      ((matchingCanonicalEnumeration D).map (fun p =>
        if p.1 ∈ S then (1 : ℤ) else -1)).prod * perfectMatchingSign D := by
  have h := matchingOrientationSignAux S (matchingCanonicalEnumeration D) []
    (by simpa using matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))
  simpa [perfectMatchingSign] using h

/-- 必要十分版は完全列挙した端点列に適用できる。 -/
theorem matchingPairWordOrientationSign_from_necSuf (D : PerfectMatching J) (S : Set J) :
    matchingWordSign ((matchingCanonicalEnumeration D).flatMap (fun p =>
      if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      ((matchingCanonicalEnumeration D).map (fun p =>
        if p.1 ∈ S then (1 : ℤ) else -1)).prod * perfectMatchingSign D := by
  exact NecSuf.AlgebraicEigenvalue.matchingPairWordOrientationSign _ _
    (matchingEnumeration_complete D _ (matchingCanonicalEnumeration_spec D))

end Ising2DLambda.AlgebraicEigenvalue
