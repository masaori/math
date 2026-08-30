/-
必要十分版: 有限和を条件を満たす添字とその補集合へ分け、補集合の項を零にし、
残った各項へ既知の表示を代入する。

人手証明が使うのは有限集合、零元を持つ可換加法モノイド、補集合での零、
条件を満たす添字での項の表示だけである。置換、行列、多項式、閉路は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- 補集合で零になる有限和は、条件を満たす添字だけの既知の表示の和に等しい。 -/
theorem restrictedSum_replace_necSuf {I A : Type*} [Fintype I] [DecidableEq I]
    [AddCommMonoid A] (admissible : Finset I) (term value : I → A)
    (hzero : ∀ i ∉ admissible, term i = 0)
    (hvalue : ∀ i ∈ admissible, term i = value i) :
    (∑ i : I, term i) = ∑ i ∈ admissible, value i := by
  calc
    (∑ i : I, term i) = ∑ i ∈ admissible, term i := by
      symm
      exact Finset.sum_subset (Finset.subset_univ admissible)
        (fun i _ hi => hzero i hi)
    _ = ∑ i ∈ admissible, value i := by
      exact Finset.sum_congr rfl hvalue

end Ising2DLambda.NecSuf.KacWard
