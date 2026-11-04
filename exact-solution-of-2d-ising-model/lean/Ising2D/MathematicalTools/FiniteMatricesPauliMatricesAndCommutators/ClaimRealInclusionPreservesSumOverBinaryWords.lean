/-
# `{0,1}^r` の上の実数の和の包含は、包含の和に等しい（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_real_inclusion_preserves_sum_over_binary_words`、ラベル **`real_inclusion_preserves_sum_over_binary_words`**）

**必要十分版**: `Ising2D/NecSuf/BinaryWordSum.lean` の `binWordSum_map`（`f := (↑· : ℝ → ℂ)`）。
具体版をその系として導くのは同じフォルダの `ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf.lean`。

## 人手証明との対応

人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `(ε', e)` は `Fin.snoc ε' e` である。
人手の左辺の和（`def_sum_over_binary_words_of_complex_numbers`）は `binaryWordComplexSum`、右辺の和
（`def_sum_over_binary_words_of_real_numbers`）は `binaryWordRealSum` である。

| 人手 | Lean |
| --- | --- |
| `r = 1` の 3 行（ℂ の和の定義 → `real_inclusion_preserves_sum` → ℝ の和の定義を右辺から左辺へ） | `binaryWordComplexSum_ofReal` の `0` の節の `calc` の 3 段 |
| `r → r + 1` の 4 行（ℂ の和の定義 → `real_inclusion_preserves_sum` を各項へ → 帰納法の仮定 → ℝ の和の定義を右辺から左辺へ） | 同じ定理の `r + 1` の節の `calc` の 4 段 |

人手の帰納法は「`{0,1}^r` で添字付けられた実数の全ての族について」示す。Lean では族 `x` を定理の引数に取る再帰で、
帰納法の仮定 `binaryWordComplexSum_ofReal r _` を族 `ε' ↦ x_{(ε',1)} + x_{(ε',0)}` に使う。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionSumOverBinaryWords
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum

namespace Ising2D

/-- **人手 `real_inclusion_preserves_sum_over_binary_words`**:
`Σ_{ε∈{0,1}^r} (x_ε)_ℂ = (Σ_{ε∈{0,1}^r} x_ε)_ℂ`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordComplexSum_ofReal :
    ∀ (r : ℕ) (x : (Fin (r + 1) → Fin 2) → ℝ),
      binaryWordComplexSum r (fun ε => (x ε : ℂ)) = ((binaryWordRealSum r x : ℝ) : ℂ)
  | 0, x =>
    calc binaryWordComplexSum 0 (fun ε => (x ε : ℂ))
        = (x (fun _ => 1) : ℂ) + (x (fun _ => 0) : ℂ) := binaryWordComplexSum_zero _
                                                        -- `def_sum_over_binary_words_of_complex_numbers`
      _ = ((x (fun _ => 1) + x (fun _ => 0) : ℝ) : ℂ) := real_inclusion_add _ _
                                                        -- `real_inclusion_preserves_sum`（`a → x_{(1)}`、`b → x_{(0)}`）
      _ = ((binaryWordRealSum 0 x : ℝ) : ℂ) := by rw [binaryWordRealSum_zero]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ
  | r + 1, x =>
    calc binaryWordComplexSum (r + 1) (fun ε => (x ε : ℂ))
        = binaryWordComplexSum r
            (fun ε' => (x (Fin.snoc (α := fun _ => Fin 2) ε' 1) : ℂ) + (x (Fin.snoc (α := fun _ => Fin 2) ε' 0) : ℂ)) :=
          binaryWordComplexSum_succ r _                 -- `def_sum_over_binary_words_of_complex_numbers`
      _ = binaryWordComplexSum r
            (fun ε' => ((x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0) : ℝ) : ℂ)) := by
          congr 1; funext ε'; exact real_inclusion_add _ _
                                                        -- `real_inclusion_preserves_sum` を各項へ同時に
      _ = ((binaryWordRealSum r
            (fun ε' => x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0)) : ℝ) : ℂ) :=
          binaryWordComplexSum_ofReal r _               -- 帰納法の仮定（`x_{ε'} → x_{(ε',1)} + x_{(ε',0)}`）
      _ = ((binaryWordRealSum (r + 1) x : ℝ) : ℂ) := by rw [binaryWordRealSum_succ]
                                                        -- `def_sum_over_binary_words_of_real_numbers` を右辺から左辺へ

end Ising2D
