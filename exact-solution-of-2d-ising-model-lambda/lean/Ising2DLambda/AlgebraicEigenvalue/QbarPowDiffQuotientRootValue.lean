/-
「冪の差の因数分解の商の、もとの根における値」の具体版。
人手証明と同じく、正の指数についての帰納法で証明する。幾何級数の
閉形式には委ねず、K の漸化式を評価し、同じ項の有限和へ一項を足す鎖を書く。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- aev_w(K_{n+1}(w)) は w^n を n+1 個足した有限和に等しい。 -/
theorem qbarPowDiffQuotientRootValue (w : Qbar) (n : ℕ) :
    qbarPolyEval w (qbarPolyPowDiffSum w (n + 1))
      = ∑ _i ∈ Finset.range (n + 1), w ^ n := by
  induction n with
  | zero =>
      calc
        qbarPolyEval w (qbarPolyPowDiffSum w (0 + 1))
            = qbarPolyEval w (qbarPolyPowDiffSum w 0 * qbarConst w
                + Polynomial.X ^ 0) := by rfl
        _ = qbarPolyEval w (0 * qbarConst w + Polynomial.X ^ 0) := by
              rw [qbarPolyPowDiffSum]
        _ = qbarPolyEval w (0 + Polynomial.X ^ 0) := by rw [zero_mul]
        _ = qbarPolyEval w (Polynomial.X ^ 0) := by rw [zero_add]
        _ = w ^ 0 := qbarPolyEvalIndeterminatePow w 0
        _ = ∑ _i ∈ Finset.range (0 + 1), w ^ 0 := by simp
  | succ n ih =>
      calc
        qbarPolyEval w (qbarPolyPowDiffSum w ((n + 1) + 1))
            = qbarPolyEval w (qbarPolyPowDiffSum w (n + 1) * qbarConst w
                + Polynomial.X ^ (n + 1)) := by rw [qbarPolyPowDiffSum]
        _ = qbarPolyEval w (qbarPolyPowDiffSum w (n + 1) * qbarConst w)
              + qbarPolyEval w (Polynomial.X ^ (n + 1)) := by
                simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]
        _ = qbarPolyEval w (qbarPolyPowDiffSum w (n + 1))
              * qbarPolyEval w (qbarConst w)
              + qbarPolyEval w (Polynomial.X ^ (n + 1)) := by
                simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
        _ = qbarPolyEval w (qbarPolyPowDiffSum w (n + 1)) * w
              + qbarPolyEval w (Polynomial.X ^ (n + 1)) := by
                simp [qbarPolyEval_eq_eval, qbarConst]
        _ = qbarPolyEval w (qbarPolyPowDiffSum w (n + 1)) * w
              + w ^ (n + 1) := by rw [qbarPolyEvalIndeterminatePow]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ n) * w + w ^ (n + 1) := by
              rw [ih]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ n * w) + w ^ (n + 1) := by
              rw [Finset.sum_mul]
        _ = (∑ _i ∈ Finset.range (n + 1), w ^ (n + 1)) + w ^ (n + 1) := by
              simp only [pow_succ]
        _ = ∑ _i ∈ Finset.range ((n + 1) + 1), w ^ (n + 1) := by
              conv_rhs => rw [Finset.sum_range_succ]

end Ising2DLambda.AlgebraicEigenvalue
