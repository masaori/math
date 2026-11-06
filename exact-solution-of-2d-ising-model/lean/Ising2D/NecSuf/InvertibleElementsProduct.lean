/-
# 可逆元の積は可逆（必要十分版）

具体版: `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionInvertibleElementsProduct.lean`
（人手 `def_invertible_elements_of_R` (ii)）。具体版をこのファイルの系として導くのと `TensorPow M` の系は
`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionInvertibleElementsProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `invertible_product_right_inverse`（代入・結合律 2 回・`g_2h_2 = 1`・右単位元・`g_1h_1 = 1`） | `invertible_product_right_inverse'`（同じ並び） |
| `invertible_product_left_inverse`（代入・結合律 2 回・`h_1g_1 = 1`・右単位元・`h_2g_2 = 1`） | `invertible_product_left_inverse'`（同じ並び） |

## 何が効いているか / 効いていないか

- 効いているのは積の結合律（`Semigroup`）と、元 `1` が右単位元であること（仮定 `hright : ∀ a, a * 1 = a`）だけである。
  どちらの鎖も `1` を右から掛けた形 `g_1 1`・`h_2 1` しか作らないので、左単位元 `1a = a` は効いていない。
  `Monoid` を取ると左単位元が型クラスの側に入って何が効いているかが見えなくなるので、`One` と仮定 `hright` で渡す。
- **加法・スカラー倍は効いていない。** 鎖に和も係数も現れない。行列であること、複素数であること、添字の有限性も効いていない。
- 積の可換律は効いていない（`h` を `g_2^{-1}g_1^{-1}` の順に置くことで、可換律なしに鎖が閉じる）。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

variable {α : Type*} [Semigroup α] [One α]

/-- **`(g_1g_2)(h_2h_1) = 1`**（具体版 `invertible_product_right_inverse`）。 -/
theorem invertible_product_right_inverse' (hright : ∀ a : α, a * 1 = a) {g1 g2 h1 h2 : α}
    (hg1 : g1 * h1 = 1) (hg2 : g2 * h2 = 1) :
    (g1 * g2) * (h2 * h1) = 1 :=
  calc (g1 * g2) * (h2 * h1)
      = (g1 * g2) * (h2 * h1) := rfl                                -- `h = g_2^{-1}g_1^{-1}` の代入
    _ = ((g1 * g2) * h2) * h1 := (mul_assoc _ _ _).symm             -- 結合律
    _ = (g1 * (g2 * h2)) * h1 := by rw [mul_assoc g1 g2 h2]         -- 結合律
    _ = (g1 * 1) * h1 := by rw [hg2]                                -- `g_2h_2 = 1`
    _ = g1 * h1 := by rw [hright g1]                                -- 右単位元
    _ = 1 := hg1                                                    -- `g_1h_1 = 1`

/-- **`(h_2h_1)(g_1g_2) = 1`**（具体版 `invertible_product_left_inverse`）。 -/
theorem invertible_product_left_inverse' (hright : ∀ a : α, a * 1 = a) {g1 g2 h1 h2 : α}
    (hh1 : h1 * g1 = 1) (hh2 : h2 * g2 = 1) :
    (h2 * h1) * (g1 * g2) = 1 :=
  calc (h2 * h1) * (g1 * g2)
      = (h2 * h1) * (g1 * g2) := rfl                                -- `h = g_2^{-1}g_1^{-1}` の代入
    _ = ((h2 * h1) * g1) * g2 := (mul_assoc _ _ _).symm             -- 結合律
    _ = (h2 * (h1 * g1)) * g2 := by rw [mul_assoc h2 h1 g1]         -- 結合律
    _ = (h2 * 1) * g2 := by rw [hh1]                                -- `h_1g_1 = 1`
    _ = h2 * g2 := by rw [hright h2]                                -- 右単位元
    _ = 1 := hh2                                                    -- `h_2g_2 = 1`

end Ising2D.NecSuf
