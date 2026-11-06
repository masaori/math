/-
# 成分がすべて実数の行列（定義）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_definition_matrix_with_real_entries`、ラベル **`def_matrix_with_real_entries`**）

- 人手の `B ∈ Mat(m, n, ℂ)` の成分の番号 `p ∈ {1, …, m}`・`q ∈ {1, …, n}` は、Lean では行と列の添字の型 `α`・`β` の元である。
  `TensorPow M` の行列（人手の `Mat(2^M, ℂ)`）は添字が `Conf M` なので、添字の型を `Fin m`・`Fin n` に固定しない。
- 人手の `r_ℂ`（`inclusion_rr_to_cc`）は Lean の `(r : ℂ)` である。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Complex.Basic

namespace Ising2D

/-- **人手 `def_matrix_with_real_entries`**: すべての `p, q` について `B_{pq} = r_ℂ` を満たす `r ∈ ℝ` がある。 -/
def MatrixHasRealEntries {α β : Type*} (B : Matrix α β ℂ) : Prop :=
  ∀ p q, ∃ r : ℝ, B p q = (r : ℂ)

end Ising2D
