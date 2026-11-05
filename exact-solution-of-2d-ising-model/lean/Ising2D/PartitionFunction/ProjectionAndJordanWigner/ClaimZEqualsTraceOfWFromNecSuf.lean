/-
# `Z_equals_trace_of_W` を必要十分版の特殊化として得る

具体版 `DefinitionSymmetrizedTransferMatrix.lean` の `trace_mul_pow_eq_trace_symmetrized_pow`（係数が `ℂ` の行列。人手の鎖と 1 対 1）が、
必要十分版 `NecSuf/OpenProductPowAndCyclicTrace.lean` の `NecSuf.trace_mul_pow_eq_trace_sandwich_pow` を
`α := Matrix n n ℂ`、`τ := Matrix.trace`（巡回性は具体版 `trace_cyclic`）へ特殊化したものと一致することを示す。

使う側 `partition_function_sandwich`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimPartitionFunctionSandwich.lean`）は
係数が `ℝ` の行列 `symTransfer B V₂ = (BV₂)B` について述べるので、同じ必要十分版を `α := Matrix n n ℝ` へ特殊化した読み
`trace_mul_pow_eq_trace_symTransfer_pow` と、人手の「とくに」の 2 行 `partition_function_eq_trace_symTransfer_pow` をここに置く。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionSymmetrizedTransferMatrix
import Ising2D.NecSuf.OpenProductPowAndCyclicTrace

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 具体版 `trace_mul_pow_eq_trace_symmetrized_pow` と同じ型の主張を、必要十分版の特殊化として得る。 -/
theorem trace_mul_pow_eq_trace_symmetrized_pow_of_necSuf {B V1 V2 W : Matrix n n ℂ}
    (hBB : B * B = V1) (hW : W = (B * V2) * B) (N : ℕ) (hN : 1 ≤ N) :
    ((V1 * V2) ^ N).trace = (W ^ N).trace :=
  NecSuf.trace_mul_pow_eq_trace_sandwich_pow Matrix.trace trace_cyclic hBB hW N hN

/-- 使う側の読み: 係数が `ℝ` の行列で `n ≥ 1` なら `tr((V_1V_2)^n) = tr(W^n)`（`W = symTransfer B V₂`）。
必要十分版を `α := Matrix n n ℝ`、`τ := Matrix.trace`（巡回性 `Matrix.trace_mul_comm`）へ特殊化したもの。 -/
theorem trace_mul_pow_eq_trace_symTransfer_pow {B V1 V2 : Matrix n n ℝ} (hBB : B * B = V1)
    (N : ℕ) (hN : 1 ≤ N) :
    ((V1 * V2) ^ N).trace = (symTransfer B V2 ^ N).trace :=
  NecSuf.trace_mul_pow_eq_trace_sandwich_pow Matrix.trace Matrix.trace_mul_comm hBB rfl N hN

/-- 人手 `Z_equals_trace_of_W` の「とくに」を使う側の読みで: `Z = tr((V_1V_2)^{N_row})`
（`partition_function_via_transfer_matrix`。仮定 `hZ` で受け取る）のもとで `Z = tr(W^{N_row})`（2 行）。 -/
theorem partition_function_eq_trace_symTransfer_pow {B V1 V2 : Matrix n n ℝ} (hBB : B * B = V1)
    {Z : ℝ} {N : ℕ} (hN : 1 ≤ N) (hZ : Z = ((V1 * V2) ^ N).trace) :
    Z = (symTransfer B V2 ^ N).trace :=
  calc Z = ((V1 * V2) ^ N).trace := hZ                         -- `partition_function_via_transfer_matrix`
    _ = (symTransfer B V2 ^ N).trace :=
        trace_mul_pow_eq_trace_symTransfer_pow hBB N hN        -- 本体を `n := N_row` に適用

end Ising2D
