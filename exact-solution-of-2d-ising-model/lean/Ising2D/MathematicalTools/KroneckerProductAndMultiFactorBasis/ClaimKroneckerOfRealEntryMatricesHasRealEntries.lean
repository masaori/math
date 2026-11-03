/-
# 成分がすべて実数の行列のクロネッカー積は成分がすべて実数（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`
（`linear_space_general_claim_kronecker_of_real_entry_matrices_has_real_entries`、ラベル **`kronecker_of_real_entry_matrices_has_real_entries`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: 各 `k` の `r_k`（`def_matrix_with_real_entries` で `B → A_k`, `p → i_k`, `q → j_k`）と、`finite_product_of_real_inclusions_is_real`（`m → M`, `j → k`, `z_j → (A_k)_{i_kj_k}`, `r_j → r_k`）からの `r` | `hx k (s k) (t k)` と `finite_product_of_real_inclusions_is_real` の `obtain` |
| 成分の鎖の 2 行（`def_kronecker` → `r` の取り方） | `siteProd_hasRealEntries` の `calc` の 2 段 |
| 「`ν` は全単射で、どの成分の番号も `ν(I)` の形に書ける」から全ての成分について条件が成り立つ | `intro s t`（Lean の添字は `Conf M` そのもの） |

- 人手のクロネッカー積 `A_1⊠⋯⊠A_M`（`M ≥ 1`）は Lean の `siteProd (n + 1) x` である（人手の `M` は Lean の `n + 1`）。
  Lean の添字は `Conf M = Fin M → Fin 2` で、人手の `I = (i_1, …, i_M)` をそのまま添字にするので、番号付け `ν` は Lean には現れない。

必要十分版は `Ising2D/NecSuf/KroneckerOfRealEntryMatrices.lean`、具体版をその特殊化として得るのは
`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean` である。
-/
import Ising2D.Representation
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimFiniteProductOfRealInclusionsIsReal
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries

namespace Ising2D

/-- **人手 `kronecker_of_real_entry_matrices_has_real_entries`**: `A_1, …, A_M` の成分がすべて実数なら、`A_1⊠⋯⊠A_M` の成分もすべて実数。 -/
theorem siteProd_hasRealEntries {n : ℕ} (x : Fin (n + 1) → Matrix (Fin 2) (Fin 2) ℂ)
    (hx : ∀ k, MatrixHasRealEntries (x k)) : MatrixHasRealEntries (siteProd (n + 1) x) := by
  intro s t
  obtain ⟨r, hr⟩ := finite_product_of_real_inclusions_is_real n (fun k => x k (s k) (t k))
    (fun k => hx k (s k) (t k))     -- 各 `k` の `r_k` と `finite_product_of_real_inclusions_is_real`（`m → M`, `j → k`, `z_j → (A_k)_{i_kj_k}`, `r_j → r_k`）
  refine ⟨r, ?_⟩
  calc siteProd (n + 1) x s t
      = ∏ k, x k (s k) (t k) := siteProd_apply (n + 1) x s t                -- `def_kronecker` を `A_1, …, A_M` に適用
    _ = (r : ℂ) := hr                                                       -- `r` の取り方

end Ising2D
