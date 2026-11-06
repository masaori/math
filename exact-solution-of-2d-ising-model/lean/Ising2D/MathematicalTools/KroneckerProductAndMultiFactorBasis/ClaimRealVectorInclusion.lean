/-
# 実数のベクトルから複素数のベクトルへの包含（定義）と、その単射性・行列との積の交換

正本: `structured-latex/content/002_linear_space_general.ts`

* `linear_space_general_definition_real_vector_inclusion`（ラベル **`def_real_vector_inclusion`**）
* `linear_space_general_claim_real_vector_inclusion_is_injective`（ラベル **`real_vector_inclusion_is_injective`**）
* `linear_space_general_claim_real_vector_inclusion_intertwines_matrix_vector_product`
  （ラベル **`real_vector_inclusion_intertwines_matrix_vector_product`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `ι^n_{ℝ→ℂ}(x)_i := (x_i)_ℂ` | `cvec`（成分は `cvec_apply` で `rfl`） |
| 単射性: 3 行の鎖 `(x_i)_ℂ = (ι(x))_i = (ι(y))_i = (y_i)_ℂ` と `inclusion_rr_to_cc_is_injective` | `real_vector_inclusion_is_injective` の `calc` の 3 段と `inclusion_rr_to_cc_is_injective` |
| 積との交換: 7 行の鎖 `(ι^m(B_ℝx))_i = … = (Bι^n(x))_i` | `real_vector_inclusion_intertwines_matrix_vector_product` の `calc` の 7 段 |

- 人手の `ℝ^n`・`ℂ^n` は Lean の `n → ℝ`・`n → ℂ`（添字の型 `n` の元が成分の番号。積の主張では `α`・`β`）である。Lean の主張は添字の型が空でも成り立つので、`Nonempty` を置かない。
- 人手の `B ∈ Mat^re(m,n,ℂ)` と `B_ℝ := ϱ^{m,n}_{ℂ→ℝ}(B)` は、Lean では行列 `B` と `MatrixHasRealEntries B` の証明 `hB` の組と
  `realMatrixOfRealEntries B hB`（`DefinitionRealMatrixOfRealEntryMatrix.lean`）である。
- 人手の `def_real_matrix_vector_product`・`mat_mult` の行列とベクトルの積は、Lean の `*ᵥ`（成分は `dotProduct` で人手の式と `rfl`）である。
- 積との交換の 4 行目の `real_inclusion_preserves_product` は具体版 `real_inclusion_mul`（`ClaimRealInclusionPreservesProduct.lean`）を引く。
  3 行目の `real_inclusion_preserves_finite_sum` だけは具体版が無いので、既存の慣行どおり mathlib の `Complex.ofReal_sum` を引く。

必要十分版は置かない。単射性の証明が使うのは「成分ごとの等号」と `inclusion_rr_to_cc_is_injective` だけで、後者は
`DefinitionRealMatrixOfRealEntryMatrix.lean` に書いたとおり取り払える代数の構造を使っていない。積との交換は、
`real_matrix_of_real_entry_matrix_preserves_product` と同じく、抽象的な内容が引いた主張（包含が有限和と積を保つこと、
`((B_ℝ)_pq)_ℂ = B_pq`）の側に尽きている。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionRealMatrixOfRealEntryMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Mathlib.Data.Complex.BigOperators
import Mathlib.Data.Matrix.Mul

namespace Ising2D

open Matrix

/-- **人手 `def_real_vector_inclusion` の `ι^n_{ℝ→ℂ}`**: 実数のベクトルの各成分に `ι_{ℝ→ℂ}` を当てる。 -/
def cvec {n : Type*} (x : n → ℝ) : n → ℂ := fun k => (x k : ℂ)

/-- 人手 `def_real_vector_inclusion` の `(ι^n_{ℝ→ℂ}(x))_i = (x_i)_ℂ`。 -/
theorem cvec_apply {n : Type*} (x : n → ℝ) (i : n) : cvec x i = ((x i : ℝ) : ℂ) := rfl

/-- **人手 `real_vector_inclusion_is_injective`**: `ι^n_{ℝ→ℂ}(x) = ι^n_{ℝ→ℂ}(y)` なら `x = y`。 -/
theorem real_vector_inclusion_is_injective {n : Type*} {x y : n → ℝ} (h : cvec x = cvec y) :
    x = y := by
  funext i
  apply inclusion_rr_to_cc_is_injective                                       -- `a → x_i`, `b → y_i`
  calc ((x i : ℝ) : ℂ)
      = cvec x i := rfl                                                       -- `def_real_vector_inclusion` を右辺から左辺へ
    _ = cvec y i := congrFun h i                                              -- 仮定
    _ = ((y i : ℝ) : ℂ) := rfl                                                -- `def_real_vector_inclusion`（`x → y`）

/-- **人手 `real_vector_inclusion_intertwines_matrix_vector_product`**:
`ι^m_{ℝ→ℂ}(B_ℝx) = B ι^n_{ℝ→ℂ}(x)`（`B` は成分がすべて実数の複素行列、`B_ℝ := ϱ(B)`）。 -/
theorem real_vector_inclusion_intertwines_matrix_vector_product {α β : Type*} [Fintype β]
    (B : Matrix α β ℂ) (hB : MatrixHasRealEntries B) (x : β → ℝ) :
    cvec (realMatrixOfRealEntries B hB *ᵥ x) = B *ᵥ cvec x := by
  funext i
  calc cvec (realMatrixOfRealEntries B hB *ᵥ x) i
      = (((realMatrixOfRealEntries B hB *ᵥ x) i : ℝ) : ℂ) := rfl              -- `def_real_vector_inclusion`（`n → m, x → B_ℝx`）
    _ = ((∑ j, realMatrixOfRealEntries B hB i j * x j : ℝ) : ℂ) := rfl       -- `def_real_matrix_vector_product`（`P → B_ℝ`）
    _ = ∑ j, ((realMatrixOfRealEntries B hB i j * x j : ℝ) : ℂ) :=
        Complex.ofReal_sum _ _                                                -- `real_inclusion_preserves_finite_sum` を右辺から左辺へ
    _ = ∑ j, ((realMatrixOfRealEntries B hB i j : ℝ) : ℂ) * ((x j : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun j _ => (real_inclusion_mul _ _).symm         -- `real_inclusion_preserves_product` を右辺から左辺へ `n` 個の項へ
    _ = ∑ j, B i j * ((x j : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun j _ => by
          rw [ofReal_realMatrixOfRealEntries_apply]                           -- `((B_ℝ)_pq)_ℂ = B_pq`（`p → i, q → j`）を `n` 個の項へ
    _ = ∑ j, B i j * cvec x j := rfl                                          -- `def_real_vector_inclusion` を右辺から左辺へ `n` 個の項へ
    _ = (B *ᵥ cvec x) i := rfl                                                -- `mat_mult`（`A → B, a → ι^n(x)`）を右辺から左辺へ

end Ising2D
