/-
# 行列の積は列ごとに作用する（具体版を必要十分版から導く）

具体版 `ClaimMatColumnwise.lean` の主張を、必要十分版 `Ising2D/NecSuf/MatColumnwise.lean` の
`NecSuf.mul_cols_eq_cols_mulVec` の係数 `ℂ`、添字 `Fin m`・`Fin n`・`Fin p` の特殊化として得る。人手のラベルは `mat_columnwise`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatColumnwise
import Ising2D.NecSuf.MatColumnwise
import Ising2D.Basic

namespace Ising2D

open Matrix

/-- `mat_columnwise` を `NecSuf.mul_cols_eq_cols_mulVec`（係数 `ℂ`、添字 `Fin`）の特殊化として得る。 -/
theorem matrix_mul_columns_of_necSuf {m n p : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) (b : Fin p → Fin n → ℂ) :
    A * Matrix.of (fun j k => b k j) = Matrix.of (fun i k => (A *ᵥ b k) i) :=
  NecSuf.mul_cols_eq_cols_mulVec A b

/-- `mat_columnwise` の `TensorPow M` での系（`m, n, p → 2^{M_col}`。添字は `Conf M`）。 -/
theorem mul_columns_tensorPow {M : ℕ} (A : TensorPow M) (b : Conf M → Conf M → ℂ) :
    A * Matrix.of (fun j k => b k j) = Matrix.of (fun i k => (A *ᵥ b k) i) :=
  NecSuf.mul_cols_eq_cols_mulVec A b

end Ising2D
