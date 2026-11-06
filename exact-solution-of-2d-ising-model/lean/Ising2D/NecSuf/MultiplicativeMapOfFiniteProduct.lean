/-
# 積を保つ写像は、左から掛ける有限積を保つ（**必要十分版**）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesFiniteProduct.lean`
（人手 `real_inclusion_preserves_finite_product`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesFiniteProductFromNecSuf.lean`。

`finProdLeft r A`（`FiniteProductLeft.lean`）は人手の `Π_{j=1}^{r+1} A_j` で、`def_finite_product_of_complex_numbers`・
`def_finite_product_of_real_numbers` の 2 つの式がそのまま 2 つの節である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1` の 2 行（ℂ の積の定義 → ℝ の積の定義を右辺から左辺へ） | `finProdLeft_map_of_mul` の `0` の節（同じ並び） |
| `m → m + 1` の 4 行（ℂ の積の定義 → 帰納法の仮定 → `real_inclusion_preserves_product` → ℝ の積の定義を右辺から左辺へ） | `finProdLeft_map_of_mul` の `r + 1` の節（同じ並び。3 段目は仮定 `hmul`） |

## 何が効いているか / 効いていないか

- 写像について効くのは、積を保つこと `f(a)f(b) = f(ab)`（仮定 `hmul`）だけである。具体版はこれを `real_inclusion_mul` で受ける。
  外すと通らない: `ℝ` 上の `f(x) = x + 1` では `f(1)f(1) = 4` だが `f(1·1) = 2` で、`m = 2` の主張が崩れる。
  `f` が単射であること、和を保つこと、`f(1) = 1` は効いていない（空の積を持たないので `f(1)` が現れない）。
- 定義域・値域について効くのは二項演算 `*` だけ（`Mul R`・`Mul S`）である。積の結合則・可換則・単位元、
  定義域が ℝ で値域が ℂ であることは効いていない（両辺とも左から順に畳み込むので、並べ替えも括弧の付け替えも起きない）。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`real_inclusion_preserves_finite_product`** の必要十分版: 積を保つ写像 `f` について
`Π_{j=1}^{r+1} f(x_j) = f(Π_{j=1}^{r+1} x_j)`。 -/
theorem finProdLeft_map_of_mul {R S : Type*} [Mul R] [Mul S]
    (f : R → S) (hmul : ∀ a b, f a * f b = f (a * b)) :
    ∀ (r : ℕ) (x : Fin (r + 1) → R), finProdLeft r (fun j => f (x j)) = f (finProdLeft r x)
  | 0, x =>
    calc finProdLeft 0 (fun j => f (x j))
        = f (x 0) := finProdLeft_zero _                                       -- 値域の積の定義
      _ = f (finProdLeft 0 x) := by rw [finProdLeft_zero]                     -- 定義域の積の定義を右辺から左辺へ
  | r + 1, x =>
    calc finProdLeft (r + 1) (fun j => f (x j))
        = finProdLeft r (fun j => f (x (Fin.castSucc j))) * f (x (Fin.last (r + 1))) :=
          finProdLeft_succ r _                                                -- 値域の積の定義
      _ = f (finProdLeft r (fun j => x (Fin.castSucc j))) * f (x (Fin.last (r + 1))) := by
          rw [finProdLeft_map_of_mul f hmul r]                                -- 帰納法の仮定
      _ = f (finProdLeft r (fun j => x (Fin.castSucc j)) * x (Fin.last (r + 1))) :=
          hmul _ _                                                            -- `f(a)f(b) = f(ab)`
      _ = f (finProdLeft (r + 1) x) := by rw [finProdLeft_succ]               -- 定義域の積の定義を右辺から左辺へ

end Ising2D.NecSuf
