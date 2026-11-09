/-
# 成分がすべて実数の行列の積は成分がすべて実数（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_product_of_real_entry_matrices_has_real_entries`、ラベル **`product_of_real_entry_matrices_has_real_entries`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: 任意の `i, k` と、仮定（`def_matrix_with_real_entries`）から各 `j` について `A_{ij} = (s_j)_ℂ`・`B_{jk} = (t_j)_ℂ` を満たす `s_j, t_j ∈ ℝ` | `intro i k` と `hA i j`・`hB j k` の `choose` |
| 成分の鎖の 1 行目（`mat_mult`） | `calc` の 1 段目 |
| 2 行目（`s_j, t_j` の取り方） | 2 段目 |
| 3 行目（`real_inclusion_preserves_product`（`a → s_j`, `b → t_j`）を `n` 個の項へ同時に適用） | 3 段目（`real_inclusion_mul` を各項へ） |
| 4 行目（`real_inclusion_preserves_finite_sum`（`m → n`, `r_j → s_jt_j`）） | 4 段目 |
| `Σ_j s_jt_j ∈ ℝ`（`def_finite_sum_of_real_numbers`）で、`i, k` は任意なので `def_matrix_with_real_entries` の条件が成り立つ | `refine ⟨∑ j, s j * t j, ?_⟩` |

- 人手の `m, n, p ∈ ℤ_{≥1}` と成分の番号は、Lean の行・和・列の添字の型 `α`・`β`・`γ` の元である
  （`matrix_add_hasRealEntries` と同じ。`TensorPow M` の行列にもそのまま使う）。和を取る添字の型 `β` には、
  `mat_mult` の和が有限和であることに当たる `Fintype β` と、人手の `n ≥ 1` に当たる `Nonempty β` を置く。
  `n ≥ 1` は、人手の 4 行目が引く `real_inclusion_preserves_finite_sum`（`m → n`）の前提 `m ≥ 1` に当たる
  （必要十分版でもこの仮定が効く。`NecSuf/ProductOfClosedEntries.lean` の冒頭）。具体版 `real_inclusion_of_finite_sum_fintype` もこの仮定を使う。`m, p ≥ 1` はどの段も使わないので `α`・`γ` には置かない。
- 1 段目の `mat_mult` は mathlib の行列の積の定義（成分は `dotProduct`）で `rfl` である。
- 4 段目の `real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype` を引く。

必要十分版は `Ising2D/NecSuf/ProductOfClosedEntries.lean`、具体版をその特殊化として得るのは
`ClaimProductOfRealEntryMatricesFromNecSuf.lean` である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Mathlib.Data.Complex.BigOperators
import Mathlib.Data.Matrix.Mul

namespace Ising2D

/-- **人手 `product_of_real_entry_matrices_has_real_entries`**: `A`・`B` の成分がすべて実数なら、`AB` の成分もすべて実数。 -/
theorem matrix_mul_hasRealEntries {α β γ : Type*} [Fintype β] [Nonempty β]
    (A : Matrix α β ℂ) (B : Matrix β γ ℂ)
    (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) : MatrixHasRealEntries (A * B) := by
  intro i k
  choose s hs using fun j => hA i j                                         -- 仮定（`def_matrix_with_real_entries`）から各 `j` の `s_j`
  choose t ht using fun j => hB j k                                         -- 仮定（`def_matrix_with_real_entries`）から各 `j` の `t_j`
  refine ⟨∑ j, s j * t j, ?_⟩                                               -- `Σ_j s_jt_j ∈ ℝ`（`def_finite_sum_of_real_numbers`）
  calc (A * B) i k
      = ∑ j, A i j * B j k := rfl                                           -- `mat_mult`
    _ = ∑ j, (s j : ℂ) * (t j : ℂ) :=
        Finset.sum_congr rfl fun j _ => by rw [hs j, ht j]                  -- `s_j, t_j` の取り方
    _ = ∑ j, ((s j * t j : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun j _ => real_inclusion_mul (s j) (t j)      -- `real_inclusion_preserves_product`（`a → s_j`, `b → t_j`）を `n` 個の項へ同時に適用
    _ = ((∑ j, s j * t j : ℝ) : ℂ) :=
        real_inclusion_of_finite_sum_fintype _                              -- `real_inclusion_preserves_finite_sum`（`m → n`, `r_j → s_jt_j`）

end Ising2D
