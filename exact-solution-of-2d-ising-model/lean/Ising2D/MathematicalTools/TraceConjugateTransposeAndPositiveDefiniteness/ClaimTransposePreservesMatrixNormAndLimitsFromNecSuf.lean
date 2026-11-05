/-
# 転置は行列のノルムと行列の列の極限を保つ（具体版を必要十分版から導く）

具体版 `matrix_transpose_norm`・`matrix_transpose_tendsto` の主張を、必要十分版
`Ising2D/NecSuf/TransposePreservesMatrixNormAndLimits.lean` の `transpose_norm'`・`transpose_tendsto'` の
係数 `α := ℂ`、添字 `m, n := Fin n`、列の添字 `ι := ℕ`、フィルタ `atTop` の特殊化として得る。
人手のラベルは `transpose_preserves_matrix_norm`・`transpose_preserves_matrix_limits`。

`TensorPow M`（添字 `Conf M`）の系 `transpose_tendsto_tensorPow` も同じ必要十分版の特殊化として置く。具体版は添字が
`Fin n` の行列について述べてあり、`Conf M` の行列には当てはまらないためである（`ClaimTransposeOfMatrixProductFromNecSuf.lean` と同じ）。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTransposePreservesMatrixNormAndLimits
import Ising2D.NecSuf.TransposePreservesMatrixNormAndLimits
import Ising2D.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- `matrix_transpose_norm` を `NecSuf.transpose_norm'` の特殊化として得る。 -/
theorem matrix_transpose_norm_of_necSuf {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : ‖Aᵀ‖ = ‖A‖ :=
  NecSuf.transpose_norm' A

/-- `matrix_transpose_tendsto` を `NecSuf.transpose_tendsto'` の特殊化として得る。 -/
theorem matrix_transpose_tendsto_of_necSuf {n : ℕ} (A : ℕ → Matrix (Fin n) (Fin n) ℂ)
    (Alim : Matrix (Fin n) (Fin n) ℂ) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᵀ - Alimᵀ‖) atTop (𝓝 0) :=
  NecSuf.transpose_tendsto' A Alim h

/-- `transpose_preserves_matrix_limits` の `TensorPow M` での系（`NecSuf.transpose_tendsto'` の添字 `Conf M` の特殊化）。 -/
theorem transpose_tendsto_tensorPow {M : ℕ} (A : ℕ → TensorPow M) (Alim : TensorPow M)
    (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᵀ - Alimᵀ‖) atTop (𝓝 0) :=
  NecSuf.transpose_tendsto' A Alim h

end Ising2D
