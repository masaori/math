import Ising2DLambda.FisherZero.PositiveConeElementQbarSquareRoot
import Ising2DLambda.NecSuf.FisherZero.PositiveConeElementQbarSquareRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem positiveConeElement_hasQbarSquareRoot_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (a : Qbar) (ha : a ∈ C) :
    ∃ b : Qbar, b ≠ 0 ∧ b * b = a := by
  have hC0 : (0 : Qbar) ∉ C := by
    intro h0
    exact (hC.trichotomy 0 F.zero_mem).2.1 ⟨rfl, h0⟩
  have hsqrt : ∀ x : Qbar, x ∈ F → x ≠ 0 → ∃ b : Qbar, b * b = x := by
    intro x _ _
    obtain ⟨b, hb⟩ := IsAlgClosed.exists_eq_mul_self x
    exact ⟨b, hb.symm⟩
  exact Ising2DLambda.NecSuf.FisherZero.positiveConeElement_hasQbarSquareRoot
    (F : Set Qbar) C hC0 (by simp) hsqrt a ha (fun x hx => hC.subset x hx)

end Ising2DLambda.FisherZero
