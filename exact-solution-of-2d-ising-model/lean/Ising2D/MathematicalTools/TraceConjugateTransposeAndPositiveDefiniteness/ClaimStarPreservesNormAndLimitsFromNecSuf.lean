/-
# 共役転置の積・線型結合の法則と、共役転置は行列のノルムと行列の列の極限を保つこと（具体版を必要十分版から導く）

具体版 `matrix_conjTranspose_mul`・`matrix_conjTranspose_add_smul`・`matrix_conjTranspose_norm`・`matrix_conjTranspose_tendsto` の主張を、
必要十分版 `Ising2D/NecSuf/StarPreservesNormAndLimits.lean` の係数 `R, α := ℂ`、添字 `Fin n`、列の添字 `ι := ℕ`、フィルタ `atTop` の
特殊化として得る。人手のラベルは `star_preserves_norm_and_limits`。
共役の仮定には、人手の `complex_conjugate_of_sum`（`hsum`、`hadd` は `m = 2`）・`complex_conjugate_of_product`（`hmul`）・
`complex_conjugate_of_difference`（`hsub`）の具体版を `star` の形・添字 `Fin n` へ読み替えた `complex_conjugate_star_finite_sum`・
`complex_conjugate_star_add`・`complex_conjugate_star_mul`・`complex_conjugate_star_sub`（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifferenceStarForm.lean`）を渡す。
`abs_of_complex_conjugate`（`hnorm`）は具体版と同じく、Lean の具体版が無いので mathlib の `norm_star` を渡す。

`TensorPow M`（添字 `Conf M`）の系 `conjTranspose_mul_tensorPow`・`conjTranspose_tendsto_tensorPow` も同じ必要十分版の特殊化として置く。
具体版は添字が `Fin n` の行列について述べてあり、`Conf M` の行列には当てはまらないためである
（`ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf.lean` と同じ）。この系の `hsum`（添字 `Conf M` の和）には、
添字を `finFunctionFinEquiv` で `Fin (2^M)` へ付け替えて当てる `complex_conjugate_star_sum_conf` を渡す。使う側は人手 `exp_of_hermitian_is_hermitian` の具体版（`ClaimExpOfHermitianIsHermitian.lean`）である。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimStarPreservesNormAndLimits
import Ising2D.NecSuf.StarPreservesNormAndLimits
import Ising2D.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

/-- `matrix_conjTranspose_mul` を `NecSuf.conjTranspose_mul_matrix'` の特殊化として得る。 -/
theorem matrix_conjTranspose_mul_of_necSuf {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) : (A * B)ᴴ = Bᴴ * Aᴴ :=
  NecSuf.conjTranspose_mul_matrix' (complex_conjugate_star_finite_sum n) complex_conjugate_star_mul A B

/-- `matrix_conjTranspose_add_smul` を `NecSuf.conjTranspose_add_smul_matrix'` の特殊化として得る。 -/
theorem matrix_conjTranspose_add_smul_of_necSuf {n : ℕ} (α β : ℂ) (A B : Matrix (Fin n) (Fin n) ℂ) :
    (α • A + β • B)ᴴ = star α • Aᴴ + star β • Bᴴ :=
  NecSuf.conjTranspose_add_smul_matrix' complex_conjugate_star_add complex_conjugate_star_mul α β A B

/-- `matrix_conjTranspose_norm` を `NecSuf.conjTranspose_norm'` の特殊化として得る。 -/
theorem matrix_conjTranspose_norm_of_necSuf {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : ‖Aᴴ‖ = ‖A‖ :=
  NecSuf.conjTranspose_norm' norm_star A

/-- `matrix_conjTranspose_tendsto` を `NecSuf.conjTranspose_tendsto'` の特殊化として得る。 -/
theorem matrix_conjTranspose_tendsto_of_necSuf {n : ℕ} (A : ℕ → Matrix (Fin n) (Fin n) ℂ)
    (Alim : Matrix (Fin n) (Fin n) ℂ) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᴴ - Alimᴴ‖) atTop (𝓝 0) :=
  NecSuf.conjTranspose_tendsto' norm_star complex_conjugate_star_sub A Alim h

/-- `star_preserves_norm_and_limits` (1) の第 1 式の `TensorPow M` での系（`NecSuf.conjTranspose_mul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem conjTranspose_mul_tensorPow {M : ℕ} (A B : TensorPow M) : (A * B)ᴴ = Bᴴ * Aᴴ :=
  NecSuf.conjTranspose_mul_matrix' (complex_conjugate_star_sum_conf M) complex_conjugate_star_mul A B

/-- `star_preserves_norm_and_limits` (3) の `TensorPow M` での系（`NecSuf.conjTranspose_tendsto'` の添字 `Conf M` の特殊化）。 -/
theorem conjTranspose_tendsto_tensorPow {M : ℕ} (A : ℕ → TensorPow M) (Alim : TensorPow M)
    (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖(A N)ᴴ - Alimᴴ‖) atTop (𝓝 0) :=
  NecSuf.conjTranspose_tendsto' norm_star complex_conjugate_star_sub A Alim h

end Ising2D
