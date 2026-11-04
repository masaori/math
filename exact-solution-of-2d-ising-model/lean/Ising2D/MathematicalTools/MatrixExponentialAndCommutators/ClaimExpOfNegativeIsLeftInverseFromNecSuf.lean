/-
# `exp(-A)exp(A) = I`（具体版を必要十分版から導く）

具体版 `ClaimExpOfNegativeIsLeftInverse.lean` の主張を、必要十分版 `Ising2D/NecSuf/ExpNegMulExp.lean` の
係数 `𝔸 := ℂ`、添字 `Fin n` の特殊化として得る。人手のラベルは `exp_of_negative_is_left_inverse`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfNegativeIsLeftInverse
import Ising2D.NecSuf.ExpNegMulExp
import Ising2D.Representation

namespace Ising2D

/-- `matrixExp_neg_mul_matrixExp` を `NecSuf.matrixExp_neg_mul_matrixExp'`（係数 `ℂ`、添字 `Fin n`）の特殊化として得る。 -/
theorem matrixExp_neg_mul_matrixExp_of_necSuf {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) :
    NormedSpace.exp (-A) * NormedSpace.exp A = 1 :=
  NecSuf.matrixExp_neg_mul_matrixExp' A

/-- `exp_of_negative_is_left_inverse` の `TensorPow M` での系（`NecSuf.matrixExp_neg_mul_matrixExp'` の添字 `Conf M` の特殊化）。 -/
theorem matExp_neg_mul_matExp_tensorPow {M : ℕ} (A : TensorPow M) : matExp (-A) * matExp A = 1 :=
  NecSuf.matrixExp_neg_mul_matrixExp' A

end Ising2D
