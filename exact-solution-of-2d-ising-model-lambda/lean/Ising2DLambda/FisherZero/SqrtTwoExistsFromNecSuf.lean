/-
具体版が必要十分版の特殊化であることの導出。
多項式の係数・評価・冪の法則と、代数閉性による根の存在を与える。
-/
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.NecSuf.FisherZero.SqrtTwoExists

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `claim_sqrt_two_exists` の具体版を必要十分版から導く。 -/
theorem sqrtTwo_exists_from_necSuf : ∃ s : Qbar, s * s = 2 := by
  apply Ising2DLambda.NecSuf.FisherZero.sqrt_two_exists_necSuf
      (constant := qbarConst) (X := (Polynomial.X : QbarPoly))
      (coeff := Polynomial.coeff) (eval := qbarPolyEval)
      (a := (2 : Qbar)) (b := (-2 : Qbar))
  · exact neg_add_cancel _
  · intro p q n
    exact Polynomial.coeff_add p q n
  · intro n
    rw [qbarPolyIndeterminatePowerCoefficient]
    simp
  · intro c n hn
    simp [qbarConst, Polynomial.coeff_C, hn]
  · exact one_ne_zero
  · intro p n hn hCoeffNe
    have hDegreeNe : p.degree ≠ 0 := by
      intro hDegreeZero
      have hLower : (n : WithBot ℕ) ≤ p.degree :=
        Polynomial.le_degree_of_ne_zero hCoeffNe
      rw [hDegreeZero] at hLower
      have hLeZero : n ≤ 0 := by exact_mod_cast hLower
      exact hn (Nat.eq_zero_of_le_zero hLeZero)
    obtain ⟨s, hs⟩ := IsAlgClosed.exists_root p hDegreeNe
    refine ⟨s, ?_⟩
    rw [qbarPolyEval_eq_eval]
    exact hs
  · intro s
    simp [qbarPolyEval_eq_eval]
  · intro s p q
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
  · exact pow_one
  · exact pow_succ
  · intro s c
    simp [qbarPolyEval_eq_eval, qbarConst]
  · intro s p q
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]

end Ising2DLambda.FisherZero
