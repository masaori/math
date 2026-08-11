/-
「冪の差の因数分解の商の、もとの根における値」の具体版が、
必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPowDiffQuotientRootValue
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowDiffQuotientRootValue

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版へ Qbar[t]、Qbar、代入写像を入れた特殊化である。 -/
theorem qbarPowDiffQuotientRootValue_from_necSuf (w : Qbar) (n : ℕ) :
    qbarPolyEval w (qbarPolyPowDiffSum w (n + 1))
      = ∑ _i ∈ Finset.range (n + 1), w ^ n := by
  apply NecSuf.AlgebraicEigenvalue.pow_diff_quotient_root_value_necSuf
    (P := QbarPoly) (R := Qbar)
    (K := qbarPolyPowDiffSum w) (c := qbarConst)
    (x := Polynomial.X) (φ := qbarPolyEval w) (w := w)
  · rfl
  · intro k
    rw [qbarPolyPowDiffSum]
  · intro a b
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_add]
  · intro a b
    simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
  · simp [qbarPolyEval_eq_eval, qbarConst]
  · exact qbarPolyEvalIndeterminatePow w

end Ising2DLambda.AlgebraicEigenvalue
