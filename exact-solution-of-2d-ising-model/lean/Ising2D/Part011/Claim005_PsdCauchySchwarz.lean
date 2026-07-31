/-
# 半正定値双線型形式の Cauchy–Schwarz の不等式（具体版）

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_005_claim_psd_cauchy_schwarz`、ラベル **`psd_cauchy_schwarz`**）

必要十分版: `Ising2D.NecSuf.psd_cauchy_schwarz`
（`Ising2D/NecSuf/PsdCauchySchwarz.lean`）

本ファイルの `Ising2D.psd_cauchy_schwarz` は、人手証明と 1 対 1 に対応する形
（`P ∈ Mat(n, ℝ)` が対称かつ半正定値、`x, y ∈ ℝ^n`）で主張を立て、
必要十分版の系として導出している。
-/
import Ising2D.Part011.Basic

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
    (fun u v => dotProduct_mulVec_comm hP u v) (fun u => hpsd u) x y
  simpa using h

end Ising2D
