/-
# 半正定値双線型形式の Cauchy–Schwarz の不等式（具体版）

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_005_claim_psd_cauchy_schwarz`、ラベル **`psd_cauchy_schwarz`**）

必要十分版: `Ising2D.NecSuf.psd_cauchy_schwarz`
（`Ising2D/NecSuf/PsdCauchySchwarz.lean`）

本ファイルの `Ising2D.psd_cauchy_schwarz` は、人手証明と 1 対 1 に対応する形
（`P ∈ Mat(n, ℝ)` が対称かつ半正定値、`x, y ∈ ℝ^n`）で主張を立て、
必要十分版の系として導出している。
人手の `q(t)` の展開の 6 行目が引く `real_bilinear_value_of_symmetric_matrix_is_symmetric` は、
具体版 `Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric`（`ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean`）を
必要十分版の対称性の仮定として渡す。`q(t)` の展開の残りの行と場合分けは、必要十分版の `bilin_quadratic_expand` と
`psd_cauchy_schwarz` の中にあり、人手の鎖と 1 対 1 の具体版はまだ無い。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **半正定値対称双線型形式に対する Cauchy–Schwarz の不等式**（人手証明 `psd_cauchy_schwarz`）。

`P ∈ Mat(n, ℝ)` が対称かつ半正定値（`∀ x, xᵀPx ≥ 0`）ならば、
任意の `x, y ∈ ℝ^n` について `(yᵀPx)² ≤ (xᵀPx)(yᵀPy)`。 -/
theorem psd_cauchy_schwarz {P : Matrix n n ℝ} (hP : P.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ P *ᵥ x) (x y : n → ℝ) :
    (y ⬝ᵥ P *ᵥ x) ^ 2 ≤ (x ⬝ᵥ P *ᵥ x) * (y ⬝ᵥ P *ᵥ y) := by
  have h := NecSuf.psd_cauchy_schwarz (matBilin P)
    (fun u v => real_bilinear_value_of_symmetric_matrix_is_symmetric P hP u v)  -- `real_bilinear_value_of_symmetric_matrix_is_symmetric`
    (fun u => hpsd u) x y
  simpa using h

end Ising2D
