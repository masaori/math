/-
章「固有値の代数性」の「多項式の値は係数の有限和で書ける」の具体版。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_evaluation_coefficient_sum`）に対応する。

  人手証明                                          このファイル
  第 1 の等号（単項式の有限和への分解）             `qbarPolyMonomialDecomposition`
  第 2 の等号（和を保つことを繰り返し当てる）       `qbarPolyEvalSumRange`（帰納法を自分で書く）
  第 3 の等号（積を保つことを各項へ）               `Polynomial.eval_mul`
  第 4 の等号（aev_w(â) = a を各項へ）              `Polynomial.eval_C`
  第 5 の等号（aev_w(t^k) = w^k を各項へ）          `qbarPolyEvalIndeterminatePow`

mathlib の `Polynomial.eval_finset_sum` / `map_sum`（第 2 の等号そのもの）へは委ねず、
和の長さについての帰納法を自分で書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（係数と代入点は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の第 2 の等号。`aev_w` は範囲にわたる有限和を有限和へ写す
（`def_qbar_poly_evaluation` の「和を保つ」約束を有限和へ繰り返し当てたもの）。 -/
theorem qbarPolyEvalSumRange (w : Qbar) (g : ℕ → QbarPoly) (m : ℕ) :
    qbarPolyEval w (∑ k ∈ Finset.range m, g k)
      = ∑ k ∈ Finset.range m, qbarPolyEval w (g k) := by
  induction m with
  | zero =>
      -- 空の和は零元であり、aev_w は零元を保つ（定義の約束）。
      simp [qbarPolyEval_eq_eval]
  | succ m ih =>
      -- 最後の項を切り出し、aev_w が 2 項の和を保つこと（定義の約束）と帰納法の仮定を当てる。
      rw [Finset.sum_range_succ, Finset.sum_range_succ, ← ih,
        qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
        Polynomial.eval_add]

/-- 人手証明の本体。`n` 次より上の係数が零である多項式の値は係数の有限和で書ける
（`claim_qbar_evaluation_coefficient_sum`）。 -/
theorem qbarPolyEvalCoefficientSum (w : Qbar) (f : QbarPoly) (n : ℕ)
    (h : ∀ k : ℕ, n < k → f.coeff k = 0) :
    qbarPolyEval w f = ∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k := by
  calc qbarPolyEval w f
      -- 第 1 の等号（単項式の有限和への分解）。
      = qbarPolyEval w
          (∑ k ∈ Finset.range (n + 1), (qbarConst (f.coeff k)) * Polynomial.X ^ k) := by
        conv_lhs => rw [qbarPolyMonomialDecomposition f n h]
    -- 第 2 の等号（和を保つことを有限和へ繰り返し当てる）。
    _ = ∑ k ∈ Finset.range (n + 1),
          qbarPolyEval w ((qbarConst (f.coeff k)) * Polynomial.X ^ k) :=
        qbarPolyEvalSumRange w _ (n + 1)
    -- 第 3 の等号（積を保つことを各項へ同時に当てる）。
    _ = ∑ k ∈ Finset.range (n + 1),
          qbarPolyEval w (qbarConst (f.coeff k)) * qbarPolyEval w (Polynomial.X ^ k) := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [qbarPolyEval_eq_eval, qbarPolyEval_eq_eval, qbarPolyEval_eq_eval,
          Polynomial.eval_mul]
    -- 第 4 の等号（aev_w(â) = a を各項へ同時に当てる）。
    _ = ∑ k ∈ Finset.range (n + 1), f.coeff k * qbarPolyEval w (Polynomial.X ^ k) := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [qbarPolyEval_eq_eval, qbarConst, Polynomial.eval_C]
    -- 第 5 の等号（aev_w(t^k) = w^k を各項へ同時に当てる）。
    _ = ∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [qbarPolyEvalIndeterminatePow]

end Ising2DLambda.AlgebraicEigenvalue
