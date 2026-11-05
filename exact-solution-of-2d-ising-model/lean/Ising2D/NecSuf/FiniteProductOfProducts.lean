/-
# 積の左から掛ける有限積は有限積の積（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealProducts.lean`
（人手 `finite_product_of_real_products`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealProductsFromNecSuf.lean`。

有限積は `NecSuf.finProdLeft`（`FiniteProductLeft.lean`。人手 `def_finite_product_of_real_numbers` の 2 つの式がそのまま 2 つの節）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1`（定義 → 定義を 2 箇所へ、右辺から左辺へ） | `finProdLeft_mul'` の `0` の節（同じ並び） |
| `m → m + 1`（定義 → 帰納法の仮定 → `(ab)(cd) = (ac)(bd)` → 定義を 2 箇所へ、右辺から左辺へ） | `finProdLeft_mul'` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 有限積の定義に要るのは二項演算 `*` だけである（`Mul R`）。
- 証明に効くのは、`(ab)(cd) = (ac)(bd)`（仮定 `hmed`）だけである。具体版はこれを ℝ の `mul_mul_mul_comm`（乗法の交換則と結合則）で受ける。
  乗法の結合則・可換則そのもの、単位元、和、順序は効いていない（`hmed` は結合則と可換則から出るが、逆は出ない）。
  `hmed` を削ると `m → m + 1` の 3 段目が閉じない（`finProdLeft` の値は `(Π^{m}) * a_{m+1}` という積なので、
  `x` の因子と `y` の因子を並べ替える規則がほかに無い）。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`finite_product_of_real_products`** の必要十分版:
`hmed`（`(ab)(cd) = (ac)(bd)`）の下で、`Π_{j=1}^{m+1}(x_jy_j) = (Π_{j=1}^{m+1}x_j)(Π_{j=1}^{m+1}y_j)`。 -/
theorem finProdLeft_mul' {R : Type*} [Mul R]
    (hmed : ∀ a b c d : R, (a * b) * (c * d) = (a * c) * (b * d)) :
    ∀ (m : ℕ) (x y : Fin (m + 1) → R),
      finProdLeft m (fun j => x j * y j) = finProdLeft m x * finProdLeft m y
  | 0, x, y =>
    calc finProdLeft 0 (fun j => x j * y j)
        = x 0 * y 0 := finProdLeft_zero _                                     -- 定義
      _ = finProdLeft 0 x * finProdLeft 0 y := by rw [finProdLeft_zero, finProdLeft_zero]
                                                                              -- 定義を 2 箇所へ、右辺から左辺へ
  | m + 1, x, y =>
    calc finProdLeft (m + 1) (fun j => x j * y j)
        = finProdLeft m (fun j => x (Fin.castSucc j) * y (Fin.castSucc j))
            * (x (Fin.last (m + 1)) * y (Fin.last (m + 1))) := finProdLeft_succ m _
                                                                              -- 定義
      _ = (finProdLeft m (fun j => x (Fin.castSucc j)) * finProdLeft m (fun j => y (Fin.castSucc j)))
            * (x (Fin.last (m + 1)) * y (Fin.last (m + 1))) := by
          rw [finProdLeft_mul' hmed m (fun j => x (Fin.castSucc j)) (fun j => y (Fin.castSucc j))]
                                                                              -- 帰納法の仮定
      _ = (finProdLeft m (fun j => x (Fin.castSucc j)) * x (Fin.last (m + 1)))
            * (finProdLeft m (fun j => y (Fin.castSucc j)) * y (Fin.last (m + 1))) := hmed _ _ _ _
                                                                              -- `(ab)(cd) = (ac)(bd)`
      _ = finProdLeft (m + 1) x * finProdLeft (m + 1) y := by rw [finProdLeft_succ m x, finProdLeft_succ m y]
                                                                              -- 定義を 2 箇所へ、右辺から左辺へ

end Ising2D.NecSuf
