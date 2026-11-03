/-
# 成分がすべて実数の行列の実数倍（必要十分版）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries.lean`
（人手 `real_scalar_multiple_of_real_entry_matrix_has_real_entries`）。
具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealScalarMultipleOfRealEntryMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `def_matrix_scalar_multiple` の段（`(c_ℂB)_{pq} = c_ℂB_{pq}`） | `smul_entries_mem` の 1 段目 |
| `s` の取り方 → `real_inclusion_preserves_product` の 2 段 | 仮定 `hc`・`hB p q` を積で閉じること `hmul` に渡す 1 段 |

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。効いているのは
  **`S` が積で閉じていること**（`hmul`）と、**掛ける数 `c` が `S` に入ること**（`hc`）だけである。
  `S` を `ℝ` の像に取ると、`hmul` は具体版の `real_inclusion_preserves_product` の段が与え、`hc` は `c_ℂ` が `c` の像であることである。
- 具体版の 2〜3 段目（`s` の取り方 → `real_inclusion_preserves_product`）は、ここでは `hmul` を引く 1 段にまとまる。
  具体版で 2 段に分かれているのは、`S` の元を `r_ℂ` と書いて実数 `s` を取り出す書き方のためで、手順（成分をスカラー倍の定義で積に読み、積で閉じることに渡す）は同じである。
- 係数の型 `R` に置いたのは積 `Mul R` だけである（スカラー倍 `c • B` は `R` の積を成分ごとに左から掛けるもの）。
  加法・零元・単位元・結合性・可換性は使わない。行列の添字 `α`・`β` は任意の型で、正方であることも有限であることも効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

/-- **積で閉じた性質に入る数を、成分がすべてその性質に入る行列に掛けても、成分はすべてその性質に入る**
（具体版 `real_smul_hasRealEntries`）。 -/
theorem smul_entries_mem {R α β : Type*} [Mul R] (S : R → Prop) (hmul : ∀ a b, S a → S b → S (a * b))
    (c : R) (hc : S c) (B : Matrix α β R) (hB : ∀ p q, S (B p q)) :
    ∀ p q, S ((c • B) p q) := by
  intro p q
  have h : (c • B) p q = c * B p q := rfl                                   -- スカラー倍の定義
  rw [h]
  exact hmul c (B p q) hc (hB p q)                                          -- 仮定 `hc`・`hB p q` を、積で閉じること `hmul` に

end Ising2D.NecSuf
