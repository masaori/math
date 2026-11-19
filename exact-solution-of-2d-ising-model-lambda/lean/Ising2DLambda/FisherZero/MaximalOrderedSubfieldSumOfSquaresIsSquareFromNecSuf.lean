import Ising2DLambda.FisherZero.MaximalOrderedSubfieldSumOfSquaresIsSquare
import Ising2DLambda.NecSuf.FisherZero.MaximalOrderedSubfieldSumOfSquaresIsSquare

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem maximalOrderedSubfield_sumOfSquares_isSquare_from_necSuf
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a b : Qbar) (ha : a ∈ R) (hb : b ∈ R) :
    ∃ c : Qbar, c ∈ R ∧ c * c = a * a + b * b := by
  let S : Set R := {x | (x : Qbar) ∈ C}
  have hs : ∀ x : R, x ≠ 0 → x * x ∈ S := by
    intro x hx
    exact mul_self_mem_of_isSubfieldPositiveCone R C hC x x.property
      (by intro h; exact hx (Subtype.ext h))
  have hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S := by
    intro x y hx hy
    exact hC.add_mem _ _ hx hy
  have hroot : ∀ x : R, x ∈ S → ∃ y : R, y * y = x := by
    intro x hx
    obtain ⟨y, hy, _, heq⟩ := maximalOrderedSubfield_positive_isSquare R C hC hmax x hx
    exact ⟨⟨y, hy⟩, Subtype.ext heq⟩
  obtain ⟨c, hc⟩ := Ising2DLambda.NecSuf.FisherZero.sumOfSquares_isSquare_of_positiveRoots
    S hs hadd hroot ⟨a, ha⟩ ⟨b, hb⟩
  exact ⟨c, c.property, congrArg (fun z : R => (z : Qbar)) hc⟩

end Ising2DLambda.FisherZero
