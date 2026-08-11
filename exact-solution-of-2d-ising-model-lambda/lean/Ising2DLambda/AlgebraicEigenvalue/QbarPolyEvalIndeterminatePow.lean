/-
章「固有値の代数性」の「代入は不定元の冪を代数的数の冪へ写す」の具体版。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_evaluation_indeterminate_pow`）に対応する。

  人手証明                                      このファイル
  出発点の第 1 の等号（t^0 = 1）                `pow_zero`
  出発点の第 2 の等号（aev_w(1) = 1）           `Polynomial.eval_one`
  出発点の第 3 の等号（w^0 = 1）                `pow_zero`
  一歩の第 1 の等号（t^{n+1} = t^n t）          `pow_succ`
  一歩の第 2 の等号（代入が積を保つ）           `Polynomial.eval_mul`
  一歩の第 3 の等号（帰納法の仮定）             `ih`
  一歩の第 4 の等号（aev_w(t) = w）             `Polynomial.eval_X`
  一歩の第 5 の等号（w^{n+1} = w^n w）          `pow_succ`

mathlib の `map_pow` と `Polynomial.eval_pow`（主張そのもの）へは委ねず、帰納法を自分で書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに R / C は現れない（係数と代入点は Q の代数閉包の元、指数は N）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyMonomialDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の定義 `aev_w` は mathlib の係数環を動かさない評価と一致する。 -/
theorem qbarPolyEval_eq_eval (w : Qbar) (f : QbarPoly) :
    qbarPolyEval w f = Polynomial.eval w f := by
  rw [qbarPolyEval, Polynomial.eval_eq_sum]
  rfl

/-- 人手証明の本体。`aev_w(t^n) = w^n`（`claim_qbar_evaluation_indeterminate_pow`）。 -/
theorem qbarPolyEvalIndeterminatePow (w : Qbar) (n : ℕ) :
    qbarPolyEval w (Polynomial.X ^ n) = w ^ n := by
  induction n with
  | zero =>
      calc qbarPolyEval w (Polynomial.X ^ 0)
          = qbarPolyEval w 1 := by rw [pow_zero]
        _ = 1 := by rw [qbarPolyEval_eq_eval, Polynomial.eval_one]
        _ = w ^ 0 := (pow_zero _).symm
  | succ n ih =>
      calc qbarPolyEval w (Polynomial.X ^ (n + 1))
          = qbarPolyEval w (Polynomial.X ^ n * Polynomial.X) := by rw [pow_succ]
        _ = qbarPolyEval w (Polynomial.X ^ n) * qbarPolyEval w Polynomial.X := by
          rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
            Polynomial.eval_mul]
        _ = w ^ n * qbarPolyEval w Polynomial.X := by rw [ih]
        _ = w ^ n * w := by rw [qbarPolyEval_eq_eval, Polynomial.eval_X]
        _ = w ^ (n + 1) := (pow_succ _ _).symm

end Ising2DLambda.AlgebraicEigenvalue
