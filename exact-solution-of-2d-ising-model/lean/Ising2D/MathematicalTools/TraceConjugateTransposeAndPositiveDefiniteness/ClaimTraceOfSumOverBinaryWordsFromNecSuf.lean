/-
# `{0,1}^r` の上の和のトレース（具体版を必要十分版から導く）

具体版 `ClaimTraceOfSumOverBinaryWords.lean` の `trace_binaryWordMatrixSum`（人手 `trace_of_sum_over_binary_words`）を、
必要十分版 `Ising2D/NecSuf/BinaryWordSum.lean` の `binWordSum_map` の `f := trace`、`hf := trace_add_matrix`（人手の準備の鎖）の
特殊化として得る。具体版の帰納法の二つの鎖は `binWordSum_map` の 2 つの節と同じ並びである。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く（`hf := trace_add_tensorPow`）。
`TensorPow M` の `{0,1}^r` の上の和は、行列も複素数も `NecSuf.binWordSum` である。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTraceOfSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWordsFromNecSuf
import Ising2D.NecSuf.BinaryWordSum

namespace Ising2D

open Matrix

/-- `trace_of_sum_over_binary_words` を `NecSuf.binWordSum_map`（`f := trace`）の特殊化として得る。 -/
theorem trace_binaryWordMatrixSum_of_necSuf {n : ℕ} (r : ℕ) (B : (Fin (r + 1) → Fin 2) → Matrix (Fin n) (Fin n) ℂ) :
    (binaryWordMatrixSum r B).trace = binaryWordComplexSum r (fun ε => (B ε).trace) := by
  rw [binaryWordMatrixSum_eq_binWordSum, binaryWordComplexSum_eq_binWordSum]
  exact NecSuf.binWordSum_map Matrix.trace (fun A B => trace_add_matrix A B) r B

/-- `trace_of_sum_over_binary_words` の `TensorPow M` での系。 -/
theorem trace_binWordSum_tensorPow {M : ℕ} (r : ℕ) (B : (Fin (r + 1) → Fin 2) → TensorPow M) :
    (NecSuf.binWordSum r B).trace = NecSuf.binWordSum r (fun ε => (B ε).trace) :=
  NecSuf.binWordSum_map Matrix.trace (fun A B => trace_add_tensorPow A B) r B

end Ising2D
