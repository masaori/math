/-
# 実対称な複素行列（定義）

正本: `structured-latex/content/009_eigenvalues_of_V.ts`
（`eigenvalues_of_V_definition_real_symmetric_complex_matrix`、ラベル **`def_real_symmetric_complex_matrix`**）

- 人手の `A ∈ Mat(n, ℂ)` の成分の番号 `{1, …, n}` は、Lean では添字の型 `n` の元である。
  `TensorPow M` の行列（人手の `Mat(2^M, ℂ)`）は添字が `Conf M` なので、添字の型を `Fin n` に固定しない
  （`MatrixHasRealEntries` と同じ扱い）。
- 人手の「成分がすべて実数」（`def_matrix_with_real_entries`）は `MatrixHasRealEntries`、
  転置（`def_matrix_transpose`）は mathlib の `Matrix.transpose`（`Aᵀ k l = A l k` が定義から `rfl`）である。
- 人手 `def_real_symmetric_matrix`（`011_max_eigenvalue.ts`。`Mat(n, ℝ)` の元が対称であること）とは台集合が違う別の定義である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries

namespace Ising2D

open Matrix

/-- **人手 `def_real_symmetric_complex_matrix`**: 成分がすべて実数で、`A^⊤ = A` である。 -/
def MatrixIsRealSymmetric {n : Type*} (A : Matrix n n ℂ) : Prop :=
  MatrixHasRealEntries A ∧ Aᵀ = A

end Ising2D
