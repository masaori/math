/-
具体版が必要十分版の特殊化であることの導出。
人手証明の二次係数・代数閉性・評価写像の十一段をそのまま渡す。
-/
import Ising2DLambda.FisherZero.SqrtTwoExists
import Ising2DLambda.NecSuf.FisherZero.SqrtTwoExists

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `claim_sqrt_two_exists` の具体版を必要十分版から導く。 -/
theorem sqrtTwo_exists_from_necSuf : ∃ s : Qbar, s * s = 2 := by
  let g : QbarPoly := Polynomial.X ^ 2 + qbarConst (-2)
  apply Ising2DLambda.NecSuf.FisherZero.sqrt_two_exists_necSuf
      (coeffStart := g.coeff 2)
      (coeffAfterAdd := (Polynomial.X ^ 2).coeff 2 + (qbarConst (-2)).coeff 2)
      (coeffAfterPower := 1 + (qbarConst (-2)).coeff 2)
      (coeffAfterConst := 1 + 0)
      (coeffFinal := (1 : Qbar))
      (rootValue := fun s : Qbar => qbarPolyEval s g)
      (lhs := fun s : Qbar => s * s)
      (afterEvalFactors := fun s =>
        qbarPolyEval s Polynomial.X * qbarPolyEval s Polynomial.X)
      (afterEvalProduct := fun s => qbarPolyEval s (Polynomial.X * Polynomial.X))
      (afterPower := fun s => qbarPolyEval s (Polynomial.X ^ 2))
      (afterZero := fun s => qbarPolyEval s (Polynomial.X ^ 2) + 0)
      (afterInverse := fun s => qbarPolyEval s (Polynomial.X ^ 2) + ((-2 : Qbar) + 2))
      (afterConst := fun s => qbarPolyEval s (Polynomial.X ^ 2) +
        (qbarPolyEval s (qbarConst (-2)) + 2))
      (afterAssociation := fun s =>
        (qbarPolyEval s (Polynomial.X ^ 2) + qbarPolyEval s (qbarConst (-2))) + 2)
      (afterEvalAdd := fun s =>
        qbarPolyEval s (Polynomial.X ^ 2 + qbarConst (-2)) + 2)
      (afterDefinition := fun s => qbarPolyEval s g + 2)
      (afterRoot := fun _ => (0 : Qbar) + 2)
      (target := (2 : Qbar))
  · simp only [g, Polynomial.coeff_add]
  · rw [qbarPolyIndeterminatePowerCoefficient]
    simp
  · simp [qbarConst]
  · rw [add_zero]
  · exact one_ne_zero
  · intro hCoeff hCoeffNe
    have hDegreeNe : g.degree ≠ 0 := by
      intro hDegreeZero
      have hLower : (((2 : ℕ) : WithBot ℕ)) ≤ g.degree :=
        Polynomial.le_degree_of_ne_zero (hCoeff ▸ hCoeffNe)
      rw [hDegreeZero] at hLower
      exact (by omega : ¬ (2 : ℕ) ≤ 0) (by exact_mod_cast hLower)
    obtain ⟨s, hs⟩ := IsAlgClosed.exists_root g hDegreeNe
    refine ⟨s, ?_⟩
    rw [qbarPolyEval_eq_eval]
    exact hs
  · intro s
    simp [qbarPolyEval_eq_eval]
  · intro s
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
  · intro s
    rw [pow_two]
  · intro s
    rw [add_zero]
  · intro s
    norm_num
  · intro s
    simp [qbarPolyEval_eq_eval, qbarConst]
  · intro s
    rw [add_assoc]
  · intro s
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]
  · intro s
    rfl
  · intro s hs
    rw [hs]
  · intro s
    rw [zero_add]

end Ising2DLambda.FisherZero
