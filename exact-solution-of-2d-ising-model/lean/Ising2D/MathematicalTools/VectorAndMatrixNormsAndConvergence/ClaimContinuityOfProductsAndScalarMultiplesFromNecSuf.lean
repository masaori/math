/-
# 行列乗算の右の因子についての連続性と、スカラー倍の収束（具体版を必要十分版から導く）

具体版 `ClaimMatrixMultiplicationContinuityInRightFactor.lean`（人手 `matrix_multiplication_continuity_in_right_factor`）と
`ClaimScalarSequenceTimesMatrixConverges.lean`（人手 `scalar_sequence_times_matrix_converges`）の主張を、
必要十分版 `Ising2D/NecSuf/ContinuityOfProductsAndScalarMultiples.lean` の、行列の集合 `Matrix (Fin n) (Fin n) ℂ` と
Frobenius ノルム（`def_matrix_norm` の行列ノルムと値が一致する）の特殊化として得る。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin n` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。人手の `eigenvalues_of_check_Vprime` Step 3・Step 3' の極限の鎖は
`n → 2^{M_col}` としてこの 2 つの主張を引くが、Lean の `Vprime_mul_Qproj`・`Qproj_mul_Vprime` はまだ必要十分版の特殊化で閉じており、
この系を使っていない（人手の極限の鎖と 1 対 1 の calc に直すときに使う）。
-/
import Ising2D.MathematicalTools.VectorAndMatrixNormsAndConvergence.ClaimMatrixMultiplicationContinuityInRightFactor
import Ising2D.MathematicalTools.VectorAndMatrixNormsAndConvergence.ClaimScalarSequenceTimesMatrixConverges
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrixFromNecSuf
import Ising2D.NecSuf.ContinuityOfProductsAndScalarMultiples
import Ising2D.Basic

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup Matrix.frobeniusNormSMulClass

/-- `matrix_mul_left_tendsto` を `NecSuf.mul_left_tendsto'`（`hdist` は行列の左分配則、`hmul` は Frobenius ノルムの劣乗法性）の特殊化として得る。 -/
theorem matrix_mul_left_tendsto_of_necSuf {n : ℕ} (B : Matrix (Fin n) (Fin n) ℂ) (A : ℕ → Matrix (Fin n) (Fin n) ℂ)
    (Alim : Matrix (Fin n) (Fin n) ℂ) (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖B * A N - B * Alim‖) atTop (𝓝 0) :=
  NecSuf.mul_left_tendsto' norm_nonneg (fun b x y => (Matrix.mul_sub b x y).symm) Matrix.frobenius_norm_mul B A Alim h

/-- `smul_matrix_tendsto` を `NecSuf.smul_tendsto'`（`hsub` は `smul_sub_smul_matrix`、`hnorm` は Frobenius ノルムの `norm_smul`）の特殊化として得る。 -/
theorem smul_matrix_tendsto_of_necSuf {n : ℕ} (c : ℕ → ℂ) (clim : ℂ) (A : Matrix (Fin n) (Fin n) ℂ)
    (h : Tendsto (fun N => ‖c N - clim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖c N • A - clim • A‖) atTop (𝓝 0) :=
  NecSuf.smul_tendsto' smul_sub_smul_matrix norm_smul c clim A h

/-- `matrix_multiplication_continuity_in_right_factor` の `TensorPow M` での系（`NecSuf.mul_left_tendsto'` の添字 `Conf M` の特殊化）。 -/
theorem mul_left_tendsto_tensorPow {M : ℕ} (B : TensorPow M) (A : ℕ → TensorPow M) (Alim : TensorPow M)
    (h : Tendsto (fun N => ‖A N - Alim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖B * A N - B * Alim‖) atTop (𝓝 0) :=
  NecSuf.mul_left_tendsto' norm_nonneg (fun b x y => (Matrix.mul_sub b x y).symm) Matrix.frobenius_norm_mul B A Alim h

/-- `scalar_sequence_times_matrix_converges` の `TensorPow M` での系（`NecSuf.smul_tendsto'` の添字 `Conf M` の特殊化）。 -/
theorem smul_tendsto_tensorPow {M : ℕ} (c : ℕ → ℂ) (clim : ℂ) (A : TensorPow M)
    (h : Tendsto (fun N => ‖c N - clim‖) atTop (𝓝 0)) :
    Tendsto (fun N => ‖c N • A - clim • A‖) atTop (𝓝 0) :=
  NecSuf.smul_tendsto' smul_sub_smul_tensorPow norm_smul c clim A h

end Ising2D
