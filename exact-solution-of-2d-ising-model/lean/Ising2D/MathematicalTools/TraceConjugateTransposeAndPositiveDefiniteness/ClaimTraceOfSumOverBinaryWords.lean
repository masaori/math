/-
# `{0,1}^r` の上の和のトレースと、行列のスカラー倍のトレース（**具体版**）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `trace_of_sum_over_binary_words`（`eigenvalues_of_V_claim_trace_of_sum_over_binary_words`）
- `trace_of_scalar_multiple`（`eigenvalues_of_V_claim_trace_of_scalar_multiple`）

## 人手証明との対応

* 人手の `Mat(n,ℂ)` は Lean の `Matrix (Fin n) (Fin n) ℂ`、人手の `r ∈ ℤ_{≥1}` は Lean の `r + 1` である。
  左辺の行列の和は `binaryWordMatrixSum`（`def_sum_over_binary_words`）、右辺の複素数の和は `binaryWordComplexSum`
  （`def_sum_over_binary_words_of_complex_numbers`）である。
* `trace_of_sum_over_binary_words` の準備の鎖（3 行）は `trace_add_matrix` の `calc`、帰納法の二つの鎖（`r = 1` の 3 行、
  `r → r + 1` の 4 行）は `trace_binaryWordMatrixSum` の 2 つの節の `calc` と 1 対 1 である。
* `trace_of_scalar_multiple` の鎖（5 行）は `trace_of_scalar_multiple` の `calc` と 1 対 1 である。
* `trace_basic_properties` (1) は `trace_linear`、`scalar_multiple_by_one` は `matrix_one_smul`、`matrix_plus_zero_matrix` は
  `matrix_add_zero_matrix`、`zero_scalar_multiple_is_zero_matrix` は `matrix_zero_smul` である。
  `complex_numbers_form_a_field` の乗法・加法の単位元と `complex_zero_times_is_zero` は mathlib の `one_mul`・`add_zero`・`zero_mul` で受ける
  （ℂ の体の公理の具体版は Lean に置いていない）。
* 添字が `Conf M` の `TensorPow M` は添字が `Fin n` の行列ではないので、同じ鎖を `TensorPow M` の系の補題で書いたものを
  `trace_add_tensorPow`・`trace_smul_tensorPow` に置く。`{0,1}^r` の上の和の系 `trace_binWordSum_tensorPow` は、
  必要十分版 `NecSuf.binWordSum_map`（`f := trace`）の特殊化として `ClaimTraceOfSumOverBinaryWordsFromNecSuf.lean` に置く。

## 必要十分版

- `trace_of_sum_over_binary_words`: `Ising2D/NecSuf/BinaryWordSum.lean` の `binWordSum_map`（和を保つ写像は `{0,1}^r` の上の和を保つ）。
  効いているのはトレースが二項の和を保つこと（準備の鎖）だけで、スカラー倍についての線型性・巡回性・行列であることは効いていない。
  導出は `ClaimTraceOfSumOverBinaryWordsFromNecSuf.lean`。
- `trace_of_scalar_multiple`: 置かない。証明は `trace_basic_properties` (1) の `β = 0_ℂ` の場合で、(1) 自身の必要十分版を
  置いていない理由（`DefinitionTrace.lean` の冒頭）がそのまま当てはまり、取り払える構造が残っていない。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOne
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutative
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrix
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrixFromNecSuf

namespace Ising2D

open Matrix

/-- **原文 `trace_of_sum_over_binary_words` の準備の鎖**（3 行）: `tr(A + B) = tr(1_ℂA + 1_ℂB) = 1_ℂtr(A) + 1_ℂtr(B) = tr(A) + tr(B)`。 -/
theorem trace_add_matrix {n : ℕ} (A B : Matrix (Fin n) (Fin n) ℂ) : (A + B).trace = A.trace + B.trace :=
  calc (A + B).trace
      = ((1 : ℂ) • A + (1 : ℂ) • B).trace := by rw [matrix_one_smul A, matrix_one_smul B]
                                                        -- `scalar_multiple_by_one`（`m, n → n`）を二つの項へ同時に右辺から左辺へ
    _ = 1 * A.trace + 1 * B.trace := trace_linear 1 1 A B
                                                        -- `trace_basic_properties` (1)（`α, β → 1_ℂ`）
    _ = A.trace + B.trace := by rw [one_mul, one_mul]   -- `1_ℂ` は乗法の単位元（`complex_numbers_form_a_field`）を二つの項へ同時に

/-- **原文 `trace_of_sum_over_binary_words`**: `tr(Σ_{ε∈{0,1}^r} B_ε) = Σ_{ε∈{0,1}^r} tr(B_ε)`（人手の `r` は Lean の `r + 1`）。 -/
theorem trace_binaryWordMatrixSum {n : ℕ} :
    ∀ (r : ℕ) (B : (Fin (r + 1) → Fin 2) → Matrix (Fin n) (Fin n) ℂ),
      (binaryWordMatrixSum r B).trace = binaryWordComplexSum r (fun ε => (B ε).trace)
  | 0, B =>
    calc (binaryWordMatrixSum 0 B).trace
        = (B (fun _ => 1) + B (fun _ => 0)).trace := rfl  -- `def_sum_over_binary_words`（`m, n → n`）
      _ = (B (fun _ => 1)).trace + (B (fun _ => 0)).trace := trace_add_matrix _ _
                                                        -- 準備の鎖（`A → B_{(1)}`、`B → B_{(0)}`）
      _ = binaryWordComplexSum 0 (fun ε => (B ε).trace) := rfl
                                                        -- `def_sum_over_binary_words_of_complex_numbers`（`z_ε → tr(B_ε)`）を右辺から左辺へ
  | r + 1, B =>
    calc (binaryWordMatrixSum (r + 1) B).trace
        = (binaryWordMatrixSum r
            (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0))).trace := rfl
                                                        -- `def_sum_over_binary_words`（`m, n → n`）
      _ = binaryWordComplexSum r
            (fun ε' => (B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)).trace) :=
          trace_binaryWordMatrixSum r _                 -- 帰納法の仮定（`B_{ε'} → B_{(ε',1)} + B_{(ε',0)}`）
      _ = binaryWordComplexSum r
            (fun ε' => (B (Fin.snoc (α := fun _ => Fin 2) ε' 1)).trace + (B (Fin.snoc (α := fun _ => Fin 2) ε' 0)).trace) := by
          congr 1; funext ε'; exact trace_add_matrix _ _ -- 準備の鎖を各項へ同時に
      _ = binaryWordComplexSum (r + 1) (fun ε => (B ε).trace) := rfl
                                                        -- `def_sum_over_binary_words_of_complex_numbers`（`z_ε → tr(B_ε)`）を右辺から左辺へ

/-- **原文 `trace_of_scalar_multiple`**（5 行）: `tr(αA) = tr(αA + O) = tr(αA + 0_ℂA) = αtr(A) + 0_ℂtr(A) = αtr(A) + 0_ℂ = αtr(A)`。 -/
theorem trace_of_scalar_multiple {n : ℕ} (α : ℂ) (A : Matrix (Fin n) (Fin n) ℂ) : (α • A).trace = α * A.trace :=
  calc (α • A).trace
      = (α • A + 0).trace := by rw [matrix_add_zero_matrix]
                                                        -- `matrix_plus_zero_matrix`（`m, n → n`、`X → αA`）を右辺から左辺へ
    _ = (α • A + (0 : ℂ) • A).trace := by rw [matrix_zero_smul A]
                                                        -- `zero_scalar_multiple_is_zero_matrix`（`m, n → n`）を右辺から左辺へ
    _ = α * A.trace + 0 * A.trace := trace_linear α 0 A A
                                                        -- `trace_basic_properties` (1)（`β → 0_ℂ`、`B → A`）
    _ = α * A.trace + 0 := by rw [zero_mul]             -- `complex_zero_times_is_zero`（`z → tr(A)`）
    _ = α * A.trace := add_zero _                       -- `0_ℂ` は加法の単位元（`complex_numbers_form_a_field`）

/-- `trace_of_sum_over_binary_words` の準備の鎖の `TensorPow M` での系（同じ 3 行）。 -/
theorem trace_add_tensorPow {M : ℕ} (A B : TensorPow M) : (A + B).trace = A.trace + B.trace :=
  calc (A + B).trace
      = ((1 : ℂ) • A + (1 : ℂ) • B).trace := by rw [one_smul_tensorPow A, one_smul_tensorPow B]
                                                        -- `scalar_multiple_by_one` を二つの項へ同時に右辺から左辺へ
    _ = 1 * A.trace + 1 * B.trace := trace_linear 1 1 A B
                                                        -- `trace_basic_properties` (1)（`α, β → 1_ℂ`）
    _ = A.trace + B.trace := by rw [one_mul, one_mul]   -- `1_ℂ` は乗法の単位元を二つの項へ同時に

/-- `trace_of_scalar_multiple` の `TensorPow M` での系（同じ 5 行）。 -/
theorem trace_smul_tensorPow {M : ℕ} (α : ℂ) (A : TensorPow M) : (α • A).trace = α * A.trace :=
  calc (α • A).trace
      = (α • A + 0).trace := by rw [matrix_add_zero_matrix_tensorPow]
                                                        -- `matrix_plus_zero_matrix`（`X → αA`）を右辺から左辺へ
    _ = (α • A + (0 : ℂ) • A).trace := by rw [zero_smul_tensorPow A]
                                                        -- `zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ
    _ = α * A.trace + 0 * A.trace := trace_linear α 0 A A
                                                        -- `trace_basic_properties` (1)（`β → 0_ℂ`、`B → A`）
    _ = α * A.trace + 0 := by rw [zero_mul]             -- `complex_zero_times_is_zero`（`z → tr(A)`）
    _ = α * A.trace := add_zero _                       -- `0_ℂ` は加法の単位元

end Ising2D
