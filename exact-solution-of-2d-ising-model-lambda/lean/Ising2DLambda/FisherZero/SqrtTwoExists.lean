/-
「二の平方根の存在」の具体版。
人手証明と同じく、二次係数が非零な多項式 `g = t^2 - 2` に代数閉性を適用し、
取った根の等式を評価写像の十一段の鎖で `s * s = 2` へ移す。
住処は Qbar であり、R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `claim_sqrt_two_exists` の具体版。 -/
theorem sqrtTwo_exists : ∃ s : Qbar, s * s = 2 := by
  let g : QbarPoly := Polynomial.X ^ 2 + qbarConst (-2)
  have hCoeff : g.coeff 2 = 1 := by
    calc
      g.coeff 2
          = (Polynomial.X ^ 2).coeff 2 + (qbarConst (-2)).coeff 2 := by
              simp only [g, Polynomial.coeff_add]
      _ = 1 + (qbarConst (-2)).coeff 2 := by
            rw [qbarPolyIndeterminatePowerCoefficient]
            simp
      _ = 1 + 0 := by simp [qbarConst]
      _ = 1 := by rw [add_zero]
  have hCoeffNe : g.coeff 2 ≠ 0 := by rw [hCoeff]; exact one_ne_zero
  have hDegreeNe : g.degree ≠ 0 := by
    intro hDegreeZero
    have hLower : (((2 : ℕ) : WithBot ℕ)) ≤ g.degree :=
      Polynomial.le_degree_of_ne_zero hCoeffNe
    rw [hDegreeZero] at hLower
    exact (by omega : ¬ (2 : ℕ) ≤ 0) (by exact_mod_cast hLower)
  obtain ⟨s, hsEval⟩ := IsAlgClosed.exists_root g hDegreeNe
  have hsRoot : qbarPolyEval s g = 0 := by
    rw [qbarPolyEval_eq_eval]
    exact hsEval
  refine ⟨s, ?_⟩
  calc
    s * s
        = qbarPolyEval s Polynomial.X * qbarPolyEval s Polynomial.X := by
            simp [qbarPolyEval_eq_eval]
    _ = qbarPolyEval s (Polynomial.X * Polynomial.X) := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
    _ = qbarPolyEval s (Polynomial.X ^ 2) := by rw [pow_two]
    _ = qbarPolyEval s (Polynomial.X ^ 2) + 0 := by rw [add_zero]
    _ = qbarPolyEval s (Polynomial.X ^ 2) + ((-2 : Qbar) + 2) := by norm_num
    _ = qbarPolyEval s (Polynomial.X ^ 2) +
          (qbarPolyEval s (qbarConst (-2)) + 2) := by
            simp [qbarPolyEval_eq_eval, qbarConst]
    _ = (qbarPolyEval s (Polynomial.X ^ 2) +
          qbarPolyEval s (qbarConst (-2))) + 2 := by rw [add_assoc]
    _ = qbarPolyEval s (Polynomial.X ^ 2 + qbarConst (-2)) + 2 := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]
    _ = qbarPolyEval s g + 2 := by rfl
    _ = 0 + 2 := by rw [hsRoot]
    _ = 2 := by rw [zero_add]

end Ising2DLambda.FisherZero
