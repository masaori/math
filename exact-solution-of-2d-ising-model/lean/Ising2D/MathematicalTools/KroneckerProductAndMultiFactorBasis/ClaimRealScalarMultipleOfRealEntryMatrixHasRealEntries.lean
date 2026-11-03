/-
# 成分がすべて実数の行列の実数倍は成分がすべて実数（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_real_scalar_multiple_of_real_entry_matrix_has_real_entries`、
ラベル **`real_scalar_multiple_of_real_entry_matrix_has_real_entries`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: 任意の `p, q` と、仮定（`def_matrix_with_real_entries`）から `B_{pq} = s_ℂ` を満たす `s` | `intro p q` と `hB p q` の `obtain` |
| 成分の鎖の 3 行（`def_matrix_scalar_multiple` → `s` の取り方 → `real_inclusion_preserves_product`（`a → c`, `b → s`）） | `real_smul_hasRealEntries` の `calc` の 3 段 |
| `r := cs` と取れば `def_matrix_with_real_entries` の条件が成り立つ | `refine ⟨c * s, ?_⟩` |

- 人手の `m, n ∈ ℤ_{≥1}` と成分の番号 `p ∈ {1, …, m}`・`q ∈ {1, …, n}` は、Lean では行と列の添字の型 `α`・`β` の元である
  （`MatrixHasRealEntries` と同じ。`TensorPow M` の行列にもそのまま使う）。
- 人手の `c_ℂ`（`inclusion_rr_to_cc`）は Lean の `(c : ℂ)`、スカラー倍 `c_ℂB` は `(c : ℂ) • B` である。
  `def_matrix_scalar_multiple` の段 `((c : ℂ) • B) p q = (c : ℂ) * B p q` は mathlib の行列のスカラー倍の定義で `rfl` である。

必要十分版は `Ising2D/NecSuf/ScalarMultipleOfClosedEntries.lean`、具体版をその特殊化として得るのは
`ClaimRealScalarMultipleOfRealEntryMatrixFromNecSuf.lean` である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries

namespace Ising2D

/-- **人手 `real_scalar_multiple_of_real_entry_matrix_has_real_entries`**: `B` の成分がすべて実数なら、`c ∈ ℝ` について `c_ℂB` の成分もすべて実数。 -/
theorem real_smul_hasRealEntries {α β : Type*} (c : ℝ) (B : Matrix α β ℂ)
    (hB : MatrixHasRealEntries B) : MatrixHasRealEntries ((c : ℂ) • B) := by
  intro p q
  obtain ⟨s, hs⟩ := hB p q                                                  -- 仮定（`def_matrix_with_real_entries`）から `s`
  refine ⟨c * s, ?_⟩                                                        -- `r := cs`
  calc ((c : ℂ) • B) p q
      = (c : ℂ) * B p q := rfl                                              -- `def_matrix_scalar_multiple`（`a → c_ℂ`, `A → B`, `i → p`, `j → q`）
    _ = (c : ℂ) * (s : ℂ) := by rw [hs]                                     -- `s` の取り方
    _ = ((c * s : ℝ) : ℂ) := real_inclusion_mul c s                         -- `real_inclusion_preserves_product`（`a → c`, `b → s`）

end Ising2D
