/-
# 行列の反交換子（**具体版**）

対応する人手証明のラベル: `def_matrix_anticommutator`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_matrix_anticommutator`）。

人手は `X, W ∈ Mat(n,ℂ)` について `[X, W]_+ := XW + WX` と定める。Lean は添字の集合を有限型 `ι` に取る
（`TensorPow M` の添字 `Conf M` の行列にも同じ定義を使うため）。必要十分版は置かない（定義だけで計算を含まない）。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Complex.Basic

namespace Ising2D

open Matrix

/-- **`def_matrix_anticommutator`**: `[X, W]_+ := XW + WX`。 -/
def matAnticomm {ι : Type*} [Fintype ι] (X W : Matrix ι ι ℂ) : Matrix ι ι ℂ := X * W + W * X

theorem matAnticomm_def {ι : Type*} [Fintype ι] (X W : Matrix ι ι ℂ) :
    matAnticomm X W = X * W + W * X :=
  rfl

end Ising2D
