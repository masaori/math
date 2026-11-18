import Ising2DLambda.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 正錐の元は零でなく、代数閉体 Qbar の中に平方根を持つ。 -/
theorem positiveConeElement_hasQbarSquareRoot
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (a : Qbar) (ha : a ∈ C) :
    ∃ b : Qbar, b ≠ 0 ∧ b * b = a := by
  have haF : a ∈ F := hC.subset a ha
  have ha0 : a ≠ 0 := by
    intro haz
    exact (hC.trichotomy a haF).2.1 ⟨haz, ha⟩
  let p : Polynomial Qbar := Polynomial.X ^ 2 - Polynomial.C a
  have hp : p.degree ≠ 0 := by
    dsimp [p]
    rw [Polynomial.degree_X_pow_sub_C (by norm_num)]
    norm_num
  obtain ⟨b, hbroot⟩ := IsAlgClosed.exists_root p hp
  have hb : b * b = a := by
    have hzero : p.eval b = 0 := hbroot
    simp [p, pow_two] at hzero
    exact sub_eq_zero.mp hzero
  refine ⟨b, ?_, hb⟩
  intro hb0
  apply ha0
  simpa [hb0] using hb.symm

end Ising2DLambda.FisherZero
