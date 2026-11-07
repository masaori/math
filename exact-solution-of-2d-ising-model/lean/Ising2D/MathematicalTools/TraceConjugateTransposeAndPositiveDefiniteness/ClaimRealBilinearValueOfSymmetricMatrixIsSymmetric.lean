/-
# 対称な実数の行列 `P` について `u^⊤Pv = v^⊤Pu`

正本: `structured-latex/content/011_max_eigenvalue.ts`

* `maxeig_claim_real_bilinear_value_of_symmetric_matrix_is_symmetric`（ラベル **`real_bilinear_value_of_symmetric_matrix_is_symmetric`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 主張の 7 行の鎖 | `real_bilinear_value_of_symmetric_matrix_is_symmetric` の `calc` の 7 段 |

- 人手の `x^⊤Py`（`def_real_bilinear_value` の `Σ_kΣ_l (x_kP_kl)y_l`）は Lean の `x ⬝ᵥ P *ᵥ y` で、
  `dotProduct_mulVec_eq_real_bilinear_value`（`RealMatrixBilinearFormAndNorm.lean`）が人手の和の形へ開く。
- 人手の「`P` が対称」（`def_real_symmetric_matrix` の `P_kl = P_lk`）は Lean の `Matrix.IsSymm`（`P^⊤ = P`）で、
  成分の等式は `Matrix.IsSymm.apply` が与える。
- 人手の和の添字 `{1, …, n}` は Lean では有限型 `n` で、二重和の順序の入れ替えは `_fintype` 版を引く。
- 人手 `psd_cauchy_schwarz` の `q(t)` の展開の 6 行目はこの主張を引き、その具体版 `Ising2D.psd_cauchy_schwarz`
  （`ClaimPsdCauchySchwarz.lean`）も本ファイルの定理を引く。

必要十分版は `Ising2D.NecSuf.bilinear_value_of_symmetric_matrix_is_symmetric'`
（`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean`）である。係数を非単位的な可換半環へ上げ、本ファイルの `calc` の
7 段と同じ並びで示す。具体版がその `R → ℝ` の特殊化として得られることは
`real_bilinear_value_of_symmetric_matrix_is_symmetric_of_necSuf`（`ClaimRealBilinearValueOfSymmetricMatrixIsSymmetricFromNecSuf.lean`）に置く。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n]

/-- **人手 `real_bilinear_value_of_symmetric_matrix_is_symmetric`**: `P` が対称なら、すべての `u, v` で
`u^⊤Pv = v^⊤Pu`（人手の 7 行の鎖と 1 対 1）。 -/
theorem real_bilinear_value_of_symmetric_matrix_is_symmetric (P : Matrix n n ℝ) (hP : P.IsSymm)
    (u v : n → ℝ) :
    u ⬝ᵥ P *ᵥ v = v ⬝ᵥ P *ᵥ u :=
  calc u ⬝ᵥ P *ᵥ v
      = ∑ k, ∑ l, u k * P k l * v l :=
        dotProduct_mulVec_eq_real_bilinear_value u v P                -- `def_real_bilinear_value`（`x → u`、`y → v`）
    _ = ∑ k, ∑ l, u k * P l k * v l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [hP.apply l k]                                          -- `def_real_symmetric_matrix`（`P_kl = P_lk`）を各項へ
    _ = ∑ k, ∑ l, v l * (u k * P l k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          mul_comm (u k * P l k) (v l)                               -- ℝ の乗法の可換則 `(u_kP_lk)v_l = v_l(u_kP_lk)` を各項へ
    _ = ∑ k, ∑ l, v l * (P l k * u k) :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [mul_comm (u k) (P l k)]                                -- ℝ の乗法の可換則 `u_kP_lk = P_lku_k` を各項へ
    _ = ∑ k, ∑ l, v l * P l k * u k :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
          (mul_assoc (v l) (P l k) (u k)).symm                       -- ℝ の乗法の結合則を各項へ
    _ = ∑ l, ∑ k, v l * P l k * u k :=
        finite_double_sum_of_real_numbers_interchange_fintype
          (fun k l => v l * P l k * u k)                             -- `finite_double_sum_of_real_numbers_interchange`（`c_{k,l} → (v_lP_lk)u_k`）
    _ = v ⬝ᵥ P *ᵥ u :=
        (dotProduct_mulVec_eq_real_bilinear_value v u P).symm        -- `def_real_bilinear_value`（`x → v`、`y → u`）を右辺から左辺へ

end Ising2D
