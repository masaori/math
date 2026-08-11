/-
「多項式の値は係数の有限和で書ける」の具体版が、必要十分版の特殊化として得られることの導出。

必要十分版が新しく問うのは第 2 の等号（和を保つ写像を有限和へ繰り返し当てること）だけである。
第 1 の等号は前の段（単項式の有限和への分解）、第 3〜5 の等号は定義の約束と前の段
（代入は不定元の冪を代数的数の冪へ写す）であり、いずれも既に必要十分版を持つか約束である。
ここでは M を Qbar[t]、N を Qbar、写像を aev_w に取る。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalCoefficientSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.FiniteSumMap

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 具体版は、零元と 2 項の和を保つ写像が有限和を保つという必要十分版の特殊化である。 -/
theorem qbarPolyEvalCoefficientSum_from_necSuf (w : Qbar) (f : QbarPoly) (n : ℕ)
    (h : ∀ k : ℕ, n < k → f.coeff k = 0) :
    qbarPolyEval w f = ∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k := by
  have h0 : qbarPolyEval w (0 : QbarPoly) = 0 := by
    rw [qbarPolyEval_eq_eval, Polynomial.eval_zero]
  have hadd : ∀ f g : QbarPoly,
      qbarPolyEval w (f + g) = qbarPolyEval w f + qbarPolyEval w g := by
    intro f g
    rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
      Polynomial.eval_add]
  calc qbarPolyEval w f
      = qbarPolyEval w
          (∑ k ∈ Finset.range (n + 1), (qbarConst (f.coeff k)) * Polynomial.X ^ k) := by
        conv_lhs => rw [qbarPolyMonomialDecomposition f n h]
    _ = ∑ k ∈ Finset.range (n + 1),
          qbarPolyEval w ((qbarConst (f.coeff k)) * Polynomial.X ^ k) :=
        NecSuf.AlgebraicEigenvalue.finite_sum_map_necSuf
          (qbarPolyEval w) h0 hadd _ (n + 1)
    _ = ∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [qbarPolyEval_eq_eval, Polynomial.eval_mul, ← qbarPolyEval_eq_eval,
          ← qbarPolyEval_eq_eval, qbarPolyEvalIndeterminatePow,
          qbarPolyEval_eq_eval, qbarConst, Polynomial.eval_C]

end Ising2DLambda.AlgebraicEigenvalue
