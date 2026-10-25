import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue
open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- 処理済みの端点を前置列に残すことで、隣接交換を完全列挙へ適用する。 -/
private theorem orientationSignWithPrefix (S : Set J) (l : List (J × J)) :
    ∀ u : List J, IsCompleteWord (u ++ matchingPairWord l) →
      matchingWordSign (u ++ l.flatMap (fun p =>
        if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      (l.map (fun p => if p.1 ∈ S then (1 : ℤ) else -1)).prod *
        matchingWordSign (u ++ matchingPairWord l) := by
  classical
  induction l with
  | nil =>
      intro u _
      simp [matchingPairWord]
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

/-- 各対を昇順へ向け直すたびに、端点列の符号が一つ反転する。 -/
theorem matchingPairWordOrientationSign (l : List (J × J)) (S : Set J)
    (hcomplete : IsCompleteWord (matchingPairWord l)) :
    matchingWordSign (l.flatMap fun p => if p.1 ∈ S then [p.1, p.2] else [p.2, p.1]) =
      (l.map fun p => if p.1 ∈ S then (1 : ℤ) else -1).prod *
        matchingWordSign (matchingPairWord l) := by
  simpa using orientationSignWithPrefix S l [] (by simpa using hcomplete)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
