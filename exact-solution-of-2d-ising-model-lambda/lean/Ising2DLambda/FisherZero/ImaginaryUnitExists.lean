/-
「代数的数には平方が負の単位元になる元がある」（ラベル `claim_imaginary_unit_exists`）の具体版。
人手証明と同じく、二次係数が非零な多項式 `g = t^2 + 1` に代数閉性を適用し、
取った根の等式を評価写像の十二段の鎖で `ω * ω = -1` へ移す。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `claim_imaginary_unit_exists` の具体版。 -/
theorem imaginaryUnit_exists : ∃ omega : Qbar, omega * omega = -1 := by
  let g : QbarPoly := Polynomial.X ^ 2 + qbarConst 1
  -- 係数の五段: ac_2(g) = ac_2(t^2) + ac_2(1^) = 1 + 0 = 1。
  have hCoeff : g.coeff 2 = 1 := by
    calc
      g.coeff 2 = (Polynomial.X ^ 2 + qbarConst 1).coeff 2 := rfl
      _ = (Polynomial.X ^ 2).coeff 2 + (qbarConst 1).coeff 2 := by
            rw [Polynomial.coeff_add]
      _ = 1 + (qbarConst 1).coeff 2 := by
            rw [qbarPolyIndeterminatePowerCoefficient]
            simp
      _ = 1 + 0 := by simp [qbarConst, Polynomial.coeff_one]
      _ = 1 := by rw [add_zero]
  have hCoeffNe : g.coeff 2 ≠ 0 := by rw [hCoeff]; exact one_ne_zero
  have hDegreeNe : g.degree ≠ 0 := by
    intro hDegreeZero
    have hLower : (((2 : ℕ) : WithBot ℕ)) ≤ g.degree :=
      Polynomial.le_degree_of_ne_zero hCoeffNe
    rw [hDegreeZero] at hLower
    exact (by omega : ¬ (2 : ℕ) ≤ 0) (by exact_mod_cast hLower)
  -- 代数閉性による根。
  obtain ⟨omega, hEval⟩ := IsAlgClosed.exists_root g hDegreeNe
  have hRoot : qbarPolyEval omega g = 0 := by
    rw [qbarPolyEval_eq_eval]
    exact hEval
  refine ⟨omega, ?_⟩
  -- 評価の十二段。
  calc
    omega * omega
        = qbarPolyEval omega Polynomial.X * qbarPolyEval omega Polynomial.X := by
            simp [qbarPolyEval_eq_eval]
    _ = qbarPolyEval omega (Polynomial.X * Polynomial.X) := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
    _ = qbarPolyEval omega (Polynomial.X ^ 1 * Polynomial.X) := by rw [pow_one]
    _ = qbarPolyEval omega (Polynomial.X ^ 2) := by
          rw [pow_succ (Polynomial.X : QbarPoly) 1]
    _ = qbarPolyEval omega (Polynomial.X ^ 2) + 0 := by rw [add_zero]
    _ = qbarPolyEval omega (Polynomial.X ^ 2) + ((1 : Qbar) + (-1)) := by
          rw [add_neg_cancel]
    _ = qbarPolyEval omega (Polynomial.X ^ 2) +
          (qbarPolyEval omega (qbarConst 1) + (-1)) := by
            simp [qbarPolyEval_eq_eval, qbarConst]
    _ = (qbarPolyEval omega (Polynomial.X ^ 2) +
          qbarPolyEval omega (qbarConst 1)) + (-1) := by rw [add_assoc]
    _ = qbarPolyEval omega (Polynomial.X ^ 2 + qbarConst 1) + (-1) := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]
    _ = qbarPolyEval omega g + (-1) := by rfl
    _ = 0 + (-1) := by rw [hRoot]
    _ = -1 := by rw [zero_add]

end Ising2DLambda.FisherZero
