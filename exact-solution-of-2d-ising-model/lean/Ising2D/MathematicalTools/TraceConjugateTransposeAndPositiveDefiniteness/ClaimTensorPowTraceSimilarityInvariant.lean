/-
# トレースは相似変換で不変（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `trace_basic_properties` (4)
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_002_claim_trace_properties`）の、
`n → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。

**必要十分版**は置かない（`DefinitionTrace.lean` の冒頭の理由と同じく、(4) は (2) の系である）。

## 人手証明との対応

人手の (4) の 5 行の鎖は `trace_similarity_invariant_tensorPow` の `calc` の 5 段と 1 対 1 である。
`mat_mult_associative` は Lean の具体版が無く mathlib の `Matrix.mul_assoc` を引き、(2) は `trace_cyclic`、
`identity_matrix_is_left_unit_of_mat_mult` は `TensorPow M` の具体版 `identity_matrix_mul_tensorPow` を引く。
`DefinitionTrace.lean` に置かないのは、`identity_matrix_mul_tensorPow` のファイルが `DefinitionTrace.lean` を
推移的に import しているためである。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct

namespace Ising2D

/-- **人手 `trace_basic_properties` (4)**（`Mat(2^M, ℂ)`）: `P'P = I` なら `tr(P(AP')) = tr(A)`。 -/
theorem trace_similarity_invariant_tensorPow {M : ℕ} (P P' A : TensorPow M) (h : P' * P = 1) :
    (P * (A * P')).trace = A.trace :=
  calc (P * (A * P')).trace
      = ((P * A) * P').trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = (P' * (P * A)).trace := trace_cyclic _ _           -- (2) を `A → PA`、`B → P'` に適用
    _ = ((P' * P) * A).trace := by rw [Matrix.mul_assoc]   -- `mat_mult_associative`
    _ = ((1 : TensorPow M) * A).trace := by rw [h]         -- `P'P = I`
    _ = A.trace := by rw [identity_matrix_mul_tensorPow]   -- `identity_matrix_is_left_unit_of_mat_mult`

end Ising2D
