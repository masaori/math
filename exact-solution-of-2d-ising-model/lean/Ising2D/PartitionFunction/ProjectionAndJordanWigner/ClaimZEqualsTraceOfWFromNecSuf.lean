/-
# `Z_equals_trace_of_W` を必要十分版の特殊化として得る

具体版 `DefinitionSymmetrizedTransferMatrix.lean` の `trace_mul_pow_eq_trace_symmetrized_pow`（係数が `ℂ` の行列。人手の鎖と 1 対 1）が、
必要十分版 `NecSuf/OpenProductPowAndCyclicTrace.lean` の `NecSuf.trace_mul_pow_eq_trace_sandwich_pow` を
`α := Matrix n n ℂ`、`τ := Matrix.trace`（巡回性は具体版 `trace_cyclic`）へ特殊化したものと一致することを示す。
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

end Ising2D
