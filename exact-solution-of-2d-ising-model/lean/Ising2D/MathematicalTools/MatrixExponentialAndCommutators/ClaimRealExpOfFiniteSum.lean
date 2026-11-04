/-
# 実数の有限和の exp は exp の有限積（具体版）

正本: `structured-latex/content/003_exp_linear_map.ts`
（`exp_linear_map_claim_real_exp_of_finite_sum`、ラベル **`real_exp_of_finite_sum`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `m = 1` の 2 行（`def_finite_sum_of_real_numbers` → `def_finite_product_of_real_numbers` を右辺から左辺へ） | `real_exp_of_finite_sum` の `0` の節の `calc` の 2 段 |
| `m → m+1` の 4 行（`def_finite_sum_of_real_numbers` → `scalar_exp_product`（`K → ℝ`）を右辺から左辺へ → 帰納法の仮定 → `def_finite_product_of_real_numbers` を右辺から左辺へ） | `m + 1` の節の `calc` の 4 段 |

- 人手の `x_1, …, x_m`（`m ≥ 1`）は Lean の `x : Fin (m + 1) → ℝ` である（人手の `m` は Lean の `m + 1`。添字は 0 始まりで、人手の `j` は `j - 1`）。
- 人手の有限和 `Σ_{j=1}^{m} x_j`（`def_finite_sum_of_real_numbers`）と有限積 `Π_{j=1}^{m} y_j`（`def_finite_product_of_real_numbers`）は
  Lean の `∑ j, x j`・`∏ j, y j`（`Finset.sum`・`Finset.prod`）である。定義の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`、
  `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` で読む。
- 人手の `exp : ℝ → ℝ` は `def_scalar_exp`（行列の exp の 1 行 1 列の成分）で、Lean はこれを mathlib の `Real.exp` で表す
  （`def_scalar_exp` の Lean の具体版は無い）。同じ理由で、人手が引く `scalar_exp_product` は mathlib の `Real.exp_add` で表す
  （`ClaimRealExpPositive.lean` と同じ扱い）。mathlib の有限和の指数法則 `Real.exp_sum` は使わない。

必要十分版は `Ising2D/NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean`、具体版をその系として導くのは
`ClaimRealExpOfFiniteSumFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D

/-- **人手 `real_exp_of_finite_sum`**: `exp(Σ_{j=1}^{m} x_j) = Π_{j=1}^{m} exp(x_j)`（人手の `m` は Lean の `m + 1`）。 -/
theorem real_exp_of_finite_sum :
    ∀ (m : ℕ) (x : Fin (m + 1) → ℝ), Real.exp (∑ j, x j) = ∏ j, Real.exp (x j)
  | 0, x =>
    calc Real.exp (∑ j, x j)
        = Real.exp (x 0) := by rw [Fin.sum_univ_one]                         -- `def_finite_sum_of_real_numbers`
      _ = ∏ j, Real.exp (x j) := (Fin.prod_univ_one (fun j => Real.exp (x j))).symm -- `def_finite_product_of_real_numbers`（`r_j → exp(x_j)`）を右辺から左辺へ
  | m + 1, x =>
    calc Real.exp (∑ j, x j)
        = Real.exp ((∑ j : Fin (m + 1), x (Fin.castSucc j)) + x (Fin.last (m + 1))) := by
          rw [Fin.sum_univ_castSucc]                                          -- `def_finite_sum_of_real_numbers`
      _ = Real.exp (∑ j : Fin (m + 1), x (Fin.castSucc j)) * Real.exp (x (Fin.last (m + 1))) :=
          Real.exp_add _ _                                                    -- `scalar_exp_product`（`K → ℝ`。Lean は mathlib の `Real.exp_add`）を右辺から左辺へ
      _ = (∏ j : Fin (m + 1), Real.exp (x (Fin.castSucc j))) * Real.exp (x (Fin.last (m + 1))) := by
          rw [real_exp_of_finite_sum m (fun j => x (Fin.castSucc j))]         -- 帰納法の仮定
      _ = ∏ j, Real.exp (x j) := (Fin.prod_univ_castSucc (fun j => Real.exp (x j))).symm -- `def_finite_product_of_real_numbers`（`r_j → exp(x_j)`）を右辺から左辺へ

end Ising2D
