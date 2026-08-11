/-
「代入は不定元の冪を代数的数の冪へ写す」の具体版が、必要十分版の特殊化として得られることの導出。

必要十分版は、直前の「定数として送る写像は冪を冪へ写す」と共有する。
どちらも、両側の冪の約束と、写像が単位元と積を保つことだけを使う同じ帰納法だからである。
ここでは M を Qbar[t]、N を Qbar、写像を aev_w に取る。

住処: ここに R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarConstEmbeddingPow

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は、単位元と積を保つ写像が冪を保つという必要十分版の特殊化である。 -/
theorem qbarPolyEvalIndeterminatePow_from_necSuf (w : Qbar) (n : ℕ) :
    qbarPolyEval w (Polynomial.X ^ n) = w ^ n := by
  have h1 : qbarPolyEval w (1 : QbarPoly) = 1 := by
    rw [qbarPolyEval_eq_eval, Polynomial.eval_one]
  have hmul : ∀ f g : QbarPoly,
      qbarPolyEval w (f * g) = qbarPolyEval w f * qbarPolyEval w g := by
    intro f g
    rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
      Polynomial.eval_mul]
  calc qbarPolyEval w (Polynomial.X ^ n)
      = qbarPolyEval w Polynomial.X ^ n :=
        NecSuf.AlgebraicEigenvalue.constant_embedding_pow_necSuf
          (M := QbarPoly) (N := Qbar)
          (fun a => pow_zero a) (fun a k => pow_succ a k)
          (fun b => pow_zero b) (fun b k => pow_succ b k)
          (qbarPolyEval w) h1 hmul Polynomial.X n
    _ = w ^ n := by rw [qbarPolyEval_eq_eval, Polynomial.eval_X]

end Ising2DLambda.AlgebraicEigenvalue
