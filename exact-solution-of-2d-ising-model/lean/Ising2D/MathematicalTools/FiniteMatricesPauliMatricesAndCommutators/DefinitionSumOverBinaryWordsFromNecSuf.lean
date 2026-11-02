/-
# `{0,1}^r` の上の行列の和と、右または左から行列を掛けることとの分配（具体版を必要十分版から導く）

具体版 `DefinitionSumOverBinaryWords.lean` の定義と主張を、必要十分版 `Ising2D/NecSuf/BinaryWordSum.lean` の
`α := Mat(m,n,ℂ)`、`f := (· C)` の特殊化として得る。`hf := add_mul_matrix`（人手の `mat_mult_distributes_over_sum_in_left_factor`）を渡す。
左から掛ける側は `f := (C * ·)`、`hf := mul_add_matrix`（人手の `mat_mult_distributes_over_sum_in_right_factor`）である。
人手のラベルは `def_sum_over_binary_words`・`sum_over_binary_words_distributes_in_left_factor`・`sum_over_binary_words_distributes_in_right_factor`・
`sum_over_binary_words_with_one_nonzero_term`（`NecSuf.binWordSum_eq_of_eq_zero`、`α := Mat(m,n,ℂ)`）。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。`TensorPow M` の `{0,1}^r` の上の和は `NecSuf.binWordSum` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.NecSuf.BinaryWordSum

namespace Ising2D

/-- 具体版の和 `binaryWordMatrixSum` は、必要十分版 `NecSuf.binWordSum` の `α := Mat(m,n,ℂ)` の場合である（2 つの節が一致する）。 -/
theorem binaryWordMatrixSum_eq_binWordSum {m n : ℕ} :
    ∀ (r : ℕ) (B : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ), binaryWordMatrixSum r B = NecSuf.binWordSum r B
  | 0, _ => rfl
  | r + 1, B => by
    rw [binaryWordMatrixSum_succ, NecSuf.binWordSum_succ, binaryWordMatrixSum_eq_binWordSum r]

/-- `sum_over_binary_words_distributes_in_left_factor` を `NecSuf.binWordSum_map`（`f := (· C)`）の特殊化として得る。 -/
theorem binaryWordMatrixSum_mul_of_necSuf {m n p : ℕ} (r : ℕ)
    (X : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) (C : Matrix (Fin n) (Fin p) ℂ) :
    binaryWordMatrixSum r X * C = binaryWordMatrixSum r (fun ε => X ε * C) := by
  rw [binaryWordMatrixSum_eq_binWordSum, binaryWordMatrixSum_eq_binWordSum]
  exact NecSuf.binWordSum_map (· * C) (fun a b => add_mul_matrix a b C) r X

/-- `sum_over_binary_words_distributes_in_left_factor` の `TensorPow M` での系。 -/
theorem binWordSum_mul_tensorPow {M : ℕ} (r : ℕ) (X : (Fin (r + 1) → Fin 2) → TensorPow M) (C : TensorPow M) :
    NecSuf.binWordSum r X * C = NecSuf.binWordSum r (fun ε => X ε * C) :=
  NecSuf.binWordSum_map (· * C) (fun a b => add_mul_matrix_tensorPow a b C) r X

/-- `sum_over_binary_words_distributes_in_right_factor` を `NecSuf.binWordSum_map`（`f := (C * ·)`）の特殊化として得る。 -/
theorem mul_binaryWordMatrixSum_of_necSuf {m n p : ℕ} (r : ℕ) (C : Matrix (Fin m) (Fin n) ℂ)
    (X : (Fin (r + 1) → Fin 2) → Matrix (Fin n) (Fin p) ℂ) :
    C * binaryWordMatrixSum r X = binaryWordMatrixSum r (fun ε => C * X ε) := by
  rw [binaryWordMatrixSum_eq_binWordSum, binaryWordMatrixSum_eq_binWordSum]
  exact NecSuf.binWordSum_map (C * ·) (fun a b => mul_add_matrix C a b) r X

/-- `sum_over_binary_words_distributes_in_right_factor` の `TensorPow M` での系。 -/
theorem mul_binWordSum_tensorPow {M : ℕ} (r : ℕ) (C : TensorPow M) (X : (Fin (r + 1) → Fin 2) → TensorPow M) :
    C * NecSuf.binWordSum r X = NecSuf.binWordSum r (fun ε => C * X ε) :=
  NecSuf.binWordSum_map (C * ·) (fun a b => mul_add_matrix_tensorPow C a b) r X

/-- `sum_over_binary_words_with_one_nonzero_term` を `NecSuf.binWordSum_eq_of_eq_zero`（`α := Mat(m,n,ℂ)`）の特殊化として得る。
`a + 0 = a`・`0 + a = a` は `Mat(m,n,ℂ)` の加法の構造から入る（具体版の `matrix_add_zero_matrix`・`zero_matrix_add_matrix` に当たる）。 -/
theorem binaryWordMatrixSum_eq_of_eq_zero_of_necSuf {m n : ℕ} (r : ℕ) (ε' : Fin (r + 1) → Fin 2)
    (B : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) (hB : ∀ ε, ε ≠ ε' → B ε = 0) :
    binaryWordMatrixSum r B = B ε' := by
  rw [binaryWordMatrixSum_eq_binWordSum]
  exact NecSuf.binWordSum_eq_of_eq_zero r ε' B hB

/-- `sum_over_binary_words_with_one_nonzero_term` の `TensorPow M` での系。 -/
theorem binWordSum_eq_of_eq_zero_tensorPow {M : ℕ} (r : ℕ) (ε' : Fin (r + 1) → Fin 2)
    (B : (Fin (r + 1) → Fin 2) → TensorPow M) (hB : ∀ ε, ε ≠ ε' → B ε = 0) :
    NecSuf.binWordSum r B = B ε' :=
  NecSuf.binWordSum_eq_of_eq_zero r ε' B hB

end Ising2D
