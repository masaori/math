/-
# 成分が非負の実数の行列 `P` について `x^⊤Px ≤ u^⊤Pu`（`u_k := |x_k|`）

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_at_most_value_at_absolute_vector`（ラベル **`real_bilinear_value_at_most_value_at_absolute_vector`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: 各 `k` の `\|Σ_l x_kP_klx_l\| ≤ Σ_l\|x_kP_klx_l\|`（`finite_sum_of_real_numbers_triangle_inequality`） | `abs_real_bilinear_row_le_row_abs_sum` |
| 準備: `P_kl ≥ 0` なので `\|P_kl\| = P_kl`（`def_real_absolute_value` の `q ≥ 0` の場合） | `abs_of_nonneg (hP k l)` |
| 主張の 9 行の鎖 | `real_bilinear_value_at_most_value_at_absolute_vector` の `calc` の 9 段 |

- 人手の `x^⊤Px`（`def_real_bilinear_value` の `Σ_kΣ_l (x_kP_kl)x_l`）は Lean の `x ⬝ᵥ P *ᵥ x` で、
  `dotProduct_mulVec_eq_real_bilinear_value`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`）が人手の和の形へ開く。
- 人手の和の添字 `{1, …, n}` は Lean では有限型 `n` で、有限和の主張は `_fintype` 版を引く。
- 人手の `u` は Lean の `fun k => |x k|` である。

必要十分版は `Ising2D.NecSuf.bilinear_value_at_most_value_at_absolute_vector'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`）である。
係数を、加法について全順序と両立する可換群で、`0 ≤ a` を左から掛けて `≤` を保ち、乗法が結合的な環 `R` へ上げ、本ファイルの `calc` の 9 段と同じ並びで示す。
具体版がその `R → ℝ` の特殊化として得られることは `real_bilinear_value_at_most_value_at_absolute_vector_of_necSuf`
（`ClaimRealBilinearValueAtMostValueAtAbsoluteVectorFromNecSuf.lean`）に置く。
`NecSuf/PermMatrix.lean` の `quad_le_quad_absVec` は、`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 の前の形の形式化の記録（`NecSuf/EvenSectorUpperBound.lean`）と
`(−)` セクターの記録（`NecSuf/PermSector.lean`・`RoutesNotAdopted/MinusSector/ClaimAbsVectorMovesToEvenSector.lean`）の部品で、係数が ℝ に固定されているので、この主張の必要十分版には当てない。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 人手 `real_bilinear_value_at_most_value_at_absolute_vector` の証明の準備: 各 `k` で
`|Σ_l x_kP_klx_l| ≤ Σ_l |x_kP_klx_l|`。 -/
theorem abs_real_bilinear_row_le_row_abs_sum (P : Matrix n n ℝ) (x : n → ℝ) (k : n) :
    |∑ l, x k * P k l * x l| ≤ ∑ l, |x k * P k l * x l| :=
  finite_sum_of_real_numbers_triangle_inequality_fintype _          -- `finite_sum_of_real_numbers_triangle_inequality`（`a_l → x_kP_klx_l`）

/-- **人手 `real_bilinear_value_at_most_value_at_absolute_vector`**: すべての `k, l` で `P_kl ≥ 0` なら、
`u_k := |x_k|` について `x^⊤Px ≤ u^⊤Pu`（人手の 9 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_at_most_value_at_absolute_vector (P : Matrix n n ℝ)
    (hP : ∀ k l, 0 ≤ P k l) (x : n → ℝ) :
    x ⬝ᵥ P *ᵥ x ≤ (fun k => |x k|) ⬝ᵥ P *ᵥ (fun k => |x k|) :=
  calc x ⬝ᵥ P *ᵥ x
      ≤ |x ⬝ᵥ P *ᵥ x| := real_number_is_at_most_its_absolute_value _  -- `real_number_is_at_most_its_absolute_value`（`q → x^⊤Px`）
    _ = |∑ k, ∑ l, x k * P k l * x l| := by
        rw [dotProduct_mulVec_eq_real_bilinear_value]                -- `def_real_bilinear_value`（`y → x`）
    _ ≤ ∑ k, |∑ l, x k * P k l * x l| :=
        finite_sum_of_real_numbers_triangle_inequality_fintype _     -- `finite_sum_of_real_numbers_triangle_inequality`（`a_k → Σ_l x_kP_klx_l`）
    _ ≤ ∑ k, ∑ l, |x k * P k l * x l| :=
        finite_sum_of_real_numbers_is_monotone_fintype _ _
          (abs_real_bilinear_row_le_row_abs_sum P x)                 -- `finite_sum_of_real_numbers_is_monotone`。各 `k` の大小は準備の不等式
    _ = ∑ k, ∑ l, |x k * P k l| * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          real_abs_of_product (x k * P k l) (x l)                    -- `real_abs_of_product`（`a → x_kP_kl`、`b → x_l`）を各項へ
    _ = ∑ k, ∑ l, |x k| * |P k l| * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [real_abs_of_product (x k) (P k l)]                     -- `real_abs_of_product`（`a → x_k`、`b → P_kl`）を各項へ
    _ = ∑ k, ∑ l, |x k| * P k l * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [abs_of_nonneg (hP k l)]                                -- `|P_kl| = P_kl`（準備。`def_real_absolute_value` の `q ≥ 0` の場合）を各項へ
    _ = ∑ k, ∑ l, (fun k => |x k|) k * P k l * (fun k => |x k|) l :=
        rfl                                                          -- `u_k := |x_k|` を各項へ
    _ = (fun k => |x k|) ⬝ᵥ P *ᵥ (fun k => |x k|) :=
        (dotProduct_mulVec_eq_real_bilinear_value _ _ P).symm        -- `def_real_bilinear_value`（`x → u`、`y → u`）を右辺から左辺へ

end Ising2D
