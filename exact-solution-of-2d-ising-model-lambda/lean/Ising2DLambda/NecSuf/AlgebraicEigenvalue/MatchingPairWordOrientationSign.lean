import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PerfectMatchingSign
import Mathlib.Algebra.Ring.Defs
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped Classical

variable {J R : Type*} [CommRing R]

/-- 処理済みの端点を前置列に残し、各対の反転を完全列挙上の隣接交換へ還元する。 -/
theorem orientationSignWithPrefix (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) → F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (S : Set J) (l : List (J × J)) :
    ∀ u : List J, IsCompleteWord (u ++ matchingPairWord l) →
      F (u ++ l.flatMap (fun p =>
        if p.1 ∈ S then [p.1, p.2] else [p.2, p.1])) =
      (l.map (fun p => if p.1 ∈ S then (1 : R) else -1)).prod *
        F (u ++ matchingPairWord l) := by
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
        have hsign := hswap u p.1 p.2 (matchingPairWord rest) hbase
        simp only [matchingPairWord, List.flatMap_cons, List.map_cons, List.prod_cons,
          if_neg hp] at hstep ⊢
        simp only [matchingPairWord] at hsign
        simp only [List.append_assoc, List.cons_append, List.nil_append] at hstep hsign ⊢
        rw [hstep, hsign]
        ring

/-- 各対を向け直すたびに端点列の値が一つ反転する。 -/
theorem matchingPairWordOrientationSign (F : List J → R)
    (hswap : ∀ (u : List J) (a b : J) (v : List J),
      IsCompleteWord (u ++ a :: b :: v) → F (u ++ b :: a :: v) = -F (u ++ a :: b :: v))
    (l : List (J × J)) (S : Set J)
    (hcomplete : IsCompleteWord (matchingPairWord l)) :
    F (l.flatMap fun p => if p.1 ∈ S then [p.1, p.2] else [p.2, p.1]) =
      (l.map fun p => if p.1 ∈ S then (1 : R) else -1).prod *
        F (matchingPairWord l) := by
  simpa using orientationSignWithPrefix F hswap S l [] (by simpa using hcomplete)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
