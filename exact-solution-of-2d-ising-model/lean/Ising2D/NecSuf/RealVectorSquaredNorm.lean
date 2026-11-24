/-
# 実ベクトルのノルムの二乗 `‖x‖² = xᵀx`（**必要十分版**の側の定義）

具体版の同じ定義は `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`
の `Ising2D.vecNormSq` である（対応する人手の項目は無い補助の定義）。具体版の `vecNormSq` とこのファイルの
`vecNormSq'` が同じ値であることは、具体版と同じフォルダの `RealMatrixBilinearFormAndNormFromNecSuf.lean` が述べる。

## 何が効いているか / 効いていないか

| 具体版 | 必要十分版 | 仮定 |
| --- | --- | --- |
| `vecNormSq`（`x ⬝ᵥ x`） | `vecNormSq'`（同じ式） | なし（具体版と同じ） |
| `vecNormSq_eq_sum` | `vecNormSq'_eq_sum`（同じ式の展開） | なし（具体版と同じ） |

* 添字の型 `n` が有限であること（`[Fintype n]`）は和を取るための定義の条件で、具体版と同じである。削れる仮定は無い。
* このファイルを置くのは、ノルムの二乗を使う必要十分版（`PermMatrix.lean` の `vecNormSq_absVec`）が
  具体版の定義を参照せずに済むようにするためである（具体版と必要十分版は互いを参照しない。`lean/README.md`）。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Real.Basic

namespace Ising2D.NecSuf

variable {n : Type*} [Fintype n]

/-- `‖x‖² = xᵀx`（具体版 `Ising2D.vecNormSq` と同じ式）。 -/
def vecNormSq' (x : n → ℝ) : ℝ := x ⬝ᵥ x

/-- `‖x‖² = Σ_i x_i²`（具体版 `Ising2D.vecNormSq_eq_sum` と同じ展開）。 -/
theorem vecNormSq'_eq_sum (x : n → ℝ) : vecNormSq' x = ∑ i, x i ^ 2 := by
  simp [vecNormSq', dotProduct, sq]

end Ising2D.NecSuf
