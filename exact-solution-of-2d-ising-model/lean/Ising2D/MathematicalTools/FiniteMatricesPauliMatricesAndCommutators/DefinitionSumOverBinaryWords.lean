/-
# `{0,1}^r` の上の行列の和と、右または左から行列を掛けることとの分配（**具体版**）

対応する人手証明のラベル: `def_sum_over_binary_words`・`sum_over_binary_words_distributes_in_left_factor`・
`sum_over_binary_words_distributes_in_right_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_sum_over_binary_words`・
`linear_space_general_claim_sum_over_binary_words_distributes_in_left_factor`・
`linear_space_general_claim_sum_over_binary_words_distributes_in_right_factor`）。

**必要十分版**: `Ising2D/NecSuf/BinaryWordSum.lean`。具体版をその系として導くのは `DefinitionSumOverBinaryWordsFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `{0,1}^r` は Lean の `Fin (r + 1) → Fin 2` で、人手の `ε_j` が Lean の `ε (j - 1)` である。
  人手の `(ε', e)` は `Fin.snoc ε' e` である。
* 定義の 2 つの式は `binaryWordMatrixSum` の 2 つの節で、`binaryWordMatrixSum_zero`・`binaryWordMatrixSum_succ` として引く。
* `sum_over_binary_words_distributes_in_left_factor` の帰納法の 2 つの鎖（`r = 1` の 3 行、`r → r + 1` の 4 行）は、
  `binaryWordMatrixSum_mul` の 2 つの節の `calc` と 1 対 1 である。`mat_mult_distributes_over_sum_in_left_factor` は具体版 `add_mul_matrix` である。
* `sum_over_binary_words_distributes_in_right_factor` の帰納法の 2 つの鎖（`r = 1` の 3 行、`r → r + 1` の 4 行）は、
  `mul_binaryWordMatrixSum` の 2 つの節の `calc` と 1 対 1 である。`mat_mult_distributes_over_sum_in_right_factor` は具体版 `mul_add_matrix` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Data.Fin.Tuple.Basic

namespace Ising2D

open Matrix

/-- **`def_sum_over_binary_words`**: `{0,1}^{r+1}` で添字付けられた `Mat(m,n,ℂ)` の元の和。 -/
def binaryWordMatrixSum {m n : ℕ} :
    (r : ℕ) → ((Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) → Matrix (Fin m) (Fin n) ℂ
  | 0, B => B (fun _ => 1) + B (fun _ => 0)
  | r + 1, B => binaryWordMatrixSum r (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0))

/-- `def_sum_over_binary_words` の 1 つ目の式: `Σ_{ε∈{0,1}^1} B_ε := B_{(1)} + B_{(0)}`。 -/
theorem binaryWordMatrixSum_zero {m n : ℕ} (B : (Fin 1 → Fin 2) → Matrix (Fin m) (Fin n) ℂ) :
    binaryWordMatrixSum 0 B = B (fun _ => 1) + B (fun _ => 0) := rfl

/-- `def_sum_over_binary_words` の 2 つ目の式: `Σ_{ε∈{0,1}^{r+2}} B_ε := Σ_{ε'∈{0,1}^{r+1}} (B_{(ε',1)} + B_{(ε',0)})`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordMatrixSum_succ {m n : ℕ} (r : ℕ) (B : (Fin (r + 2) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) :
    binaryWordMatrixSum (r + 1) B
      = binaryWordMatrixSum r
          (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl

/-- **`sum_over_binary_words_distributes_in_left_factor`**: `(Σ_{ε∈{0,1}^r} X_ε) C = Σ_{ε∈{0,1}^r} X_ε C`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordMatrixSum_mul {m n p : ℕ} :
    ∀ (r : ℕ) (X : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) (C : Matrix (Fin n) (Fin p) ℂ),
      binaryWordMatrixSum r X * C = binaryWordMatrixSum r (fun ε => X ε * C)
  | 0, X, C =>
    calc binaryWordMatrixSum 0 X * C
        = (X (fun _ => 1) + X (fun _ => 0)) * C := rfl                       -- `def_sum_over_binary_words`
      _ = X (fun _ => 1) * C + X (fun _ => 0) * C := add_mul_matrix _ _ _     -- `mat_mult_distributes_over_sum_in_left_factor`
      _ = binaryWordMatrixSum 0 (fun ε => X ε * C) := rfl                     -- `def_sum_over_binary_words` を右辺から左辺へ
  | r + 1, X, C =>
    calc binaryWordMatrixSum (r + 1) X * C
        = binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * C := rfl
                                                                              -- `def_sum_over_binary_words`
      _ = binaryWordMatrixSum r
            (fun ε' => (X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * C) :=
          binaryWordMatrixSum_mul r _ C                                       -- 帰納法の仮定
      _ = binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) * C + X (Fin.snoc (α := fun _ => Fin 2) ε' 0) * C) := by
          congr 1; funext ε'; exact add_mul_matrix _ _ _                      -- `mat_mult_distributes_over_sum_in_left_factor` を各項へ
      _ = binaryWordMatrixSum (r + 1) (fun ε => X ε * C) := rfl               -- `def_sum_over_binary_words` を右辺から左辺へ

/-- **`sum_over_binary_words_distributes_in_right_factor`**: `C (Σ_{ε∈{0,1}^r} X_ε) = Σ_{ε∈{0,1}^r} C X_ε`（人手の `r` は Lean の `r + 1`）。 -/
theorem mul_binaryWordMatrixSum {m n p : ℕ} :
    ∀ (r : ℕ) (C : Matrix (Fin m) (Fin n) ℂ) (X : (Fin (r + 1) → Fin 2) → Matrix (Fin n) (Fin p) ℂ),
      C * binaryWordMatrixSum r X = binaryWordMatrixSum r (fun ε => C * X ε)
  | 0, C, X =>
    calc C * binaryWordMatrixSum 0 X
        = C * (X (fun _ => 1) + X (fun _ => 0)) := rfl                       -- `def_sum_over_binary_words`
      _ = C * X (fun _ => 1) + C * X (fun _ => 0) := mul_add_matrix _ _ _     -- `mat_mult_distributes_over_sum_in_right_factor`
      _ = binaryWordMatrixSum 0 (fun ε => C * X ε) := rfl                     -- `def_sum_over_binary_words` を右辺から左辺へ
  | r + 1, C, X =>
    calc C * binaryWordMatrixSum (r + 1) X
        = C * binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl
                                                                              -- `def_sum_over_binary_words`
      _ = binaryWordMatrixSum r
            (fun ε' => C * (X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0))) :=
          mul_binaryWordMatrixSum r C _                                       -- 帰納法の仮定
      _ = binaryWordMatrixSum r
            (fun ε' => C * X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + C * X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := by
          congr 1; funext ε'; exact mul_add_matrix _ _ _                      -- `mat_mult_distributes_over_sum_in_right_factor` を各項へ
      _ = binaryWordMatrixSum (r + 1) (fun ε => C * X ε) := rfl               -- `def_sum_over_binary_words` を右辺から左辺へ

end Ising2D
