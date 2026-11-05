/-
# 転置は行列のノルムと行列の列の極限を保つ（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTransposePreservesMatrixNormAndLimits.lean`
（人手 `transpose_preserves_matrix_norm`・`transpose_preserves_matrix_limits`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_transpose_norm` の 4 段（ノルムの定義 → 転置の定義を各項へ → 有限和の順序の入れ替え → ノルムの定義） | `transpose_norm'` の同じ 4 段 |
| `matrix_transpose_tendsto` の各 `N` の 2 段（差の転置 → 転置はノルムを保つ）と、列の書き換え | `transpose_tendsto'` の同じ段 |

## 何が効いているか / 効いていないか

- 係数の型 `α` は、Frobenius ノルムが定まるための `SeminormedAddCommGroup` だけを仮定する。
  `ℂ` であること、乗法、体であることは効いていない。セミノルムで足り、`‖x‖ = 0 → x = 0` も効いていない。
  この型クラスの公理（三角不等式・加法群であること）も証明の段には効いておらず、mathlib の Frobenius ノルムが
  定義されるためにだけ要る。証明が使うのは、成分のノルムの値と、差の成分ごとの定義（`Sub`）だけである。
- 行列は正方である必要がなく、添字は任意の有限型 `m`・`n` でよい（`Fin n` の番号付けは効いていない）。
  有限であることは、ノルムの定義の和が有限和であるために要る。
- ノルムの段で効いているのは、ノルムが成分ごとの値の二重の有限和で書けることと、`ℝ` の有限和の順序を入れ替えられることだけである。
- 極限の段で効いているのは、差の転置が転置の差であること（`transpose_sub_matrix'`。差の成分ごとの定義）と、ノルムの段だけである。
  列の添字が `ℕ` であることも効かず、任意のフィルタでの収束について同じ手順で通る。
-/
import Ising2D.NecSuf.TransposeOfMatrixSums
import Mathlib.Analysis.Matrix.Normed

namespace Ising2D.NecSuf

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusSeminormedAddCommGroup

/-- **転置はノルムを保つ**（具体版 `matrix_transpose_norm`）。 -/
theorem transpose_norm' {m n α : Type*} [Fintype m] [Fintype n] [SeminormedAddCommGroup α]
    (A : Matrix m n α) : ‖Aᵀ‖ = ‖A‖ :=
  calc ‖Aᵀ‖
      = (∑ k, ∑ l, ‖Aᵀ k l‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := Matrix.frobenius_norm_def _
    _ = (∑ k, ∑ l, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by simp only [Matrix.transpose_apply]
    _ = (∑ l, ∑ k, ‖A l k‖ ^ (2 : ℝ)) ^ (1 / 2 : ℝ) := by rw [Finset.sum_comm]
    _ = ‖A‖ := (Matrix.frobenius_norm_def A).symm

/-- **転置は極限を保つ**（具体版 `matrix_transpose_tendsto`）。 -/
theorem transpose_tendsto' {m n α ι : Type*} [Fintype m] [Fintype n] [SeminormedAddCommGroup α]
    {l : Filter ι} (A : ι → Matrix m n α) (Alim : Matrix m n α)
    (h : Tendsto (fun N => ‖A N - Alim‖) l (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᵀ - Alimᵀ‖) l (𝓝 0) := by
  have heq : ∀ N, ‖(A N)ᵀ - Alimᵀ‖ = ‖A N - Alim‖ := fun N =>
    calc ‖(A N)ᵀ - Alimᵀ‖
        = ‖(A N - Alim)ᵀ‖ := by rw [transpose_sub_matrix']
      _ = ‖A N - Alim‖ := transpose_norm' _
  rw [funext heq]
  exact h

end Ising2D.NecSuf
