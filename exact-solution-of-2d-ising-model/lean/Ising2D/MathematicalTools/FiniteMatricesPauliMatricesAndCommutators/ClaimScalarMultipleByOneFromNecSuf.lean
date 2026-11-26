/-
# 行列の 1 倍は元の行列（具体版を必要十分版から導く）

具体版 `ClaimScalarMultipleByOne.lean` の主張を、必要十分版 `Ising2D/NecSuf/OneSmulMatrix.lean` の
係数・スカラー `ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。`ho := one_mul`（人手の「`1_ℂ` は `ℂ` の積の単位元」）を渡す。
人手のラベルは `scalar_multiple_by_one`。

`TensorPow M`（添字 `Conf M`）の具体版 `ClaimTensorPowScalarMultipleByOne.lean` の主張 `one_smul_tensorPow` も、
同じ必要十分版の添字 `Conf M` の特殊化として得る（`one_smul_tensorPow_of_necSuf`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOne
import Ising2D.NecSuf.OneSmulMatrix
import Ising2D.Basic

namespace Ising2D

/-- `matrix_one_smul` を `NecSuf.one_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_one_smul_of_necSuf {m n : ℕ} (A : Matrix (Fin m) (Fin n) ℂ) : (1 : ℂ) • A = A :=
  NecSuf.one_smul_matrix' (fun x : ℂ => one_mul x) A

/-- 具体版 `one_smul_tensorPow`（`scalar_multiple_by_one` の `TensorPow M` での具体版）を
`NecSuf.one_smul_matrix'` の添字 `Conf M` の特殊化として得る。 -/
theorem one_smul_tensorPow_of_necSuf {M : ℕ} (A : TensorPow M) : (1 : ℂ) • A = A :=
  NecSuf.one_smul_matrix' (fun x : ℂ => one_mul x) A

end Ising2D
