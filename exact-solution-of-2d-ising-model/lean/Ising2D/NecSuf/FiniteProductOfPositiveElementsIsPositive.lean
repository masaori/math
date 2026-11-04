/-
# 正の元の左から掛ける有限積は正（**必要十分版**）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfPositiveRealsIsPositive.lean`
（人手 `finite_product_of_positive_reals_is_positive`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfPositiveRealsIsPositiveFromNecSuf.lean`。

有限積は `NecSuf.finProdLeft`（`FiniteProductLeft.lean`。人手 `def_finite_product_of_real_numbers` の 2 つの式がそのまま 2 つの節）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1`（定義 → 仮定 `r_1 > 0`） | `finProdLeft_pos'` の `0` の節（同じ並び） |
| `m → m + 1`（帰納法の仮定と仮定 `r_{m+1} > 0` → 定義 → `a > 0, b > 0` なら `ab > 0`） | `finProdLeft_pos'` の `m + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 有限積の定義に要るのは二項演算 `*` だけである（`Mul R`）。主張を述べるのに要るのは `0` と `<` だけである（`Zero R`・`LT R`）。
- 証明に効くのは、`0 < a`・`0 < b` なら `0 < a * b`（仮定 `hmul`）だけである。具体版はこれを ℝ の `mul_pos` で受ける。
  `<` が順序であること（推移律・非反射律）、積の結合則・可換則・単位元、和、`1 > 0` は効いていない。
  `hmul` を削ると `m → m + 1` の最後の段が閉じない（`finProdLeft` の値は `(Π^{m}) * r_{m+1}` という積なので、
  積と `0 <` を結ぶ規則がほかに無い）。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`finite_product_of_positive_reals_is_positive`** の必要十分版:
`hmul`（`0 < a`・`0 < b` なら `0 < a * b`）の下で、すべての `j` で `0 < r_j` なら `0 < Π_{j=1}^{m+1} r_j`。 -/
theorem finProdLeft_pos' {R : Type*} [Mul R] [Zero R] [LT R]
    (hmul : ∀ a b : R, 0 < a → 0 < b → 0 < a * b) :
    ∀ (m : ℕ) (r : Fin (m + 1) → R), (∀ j, 0 < r j) → 0 < finProdLeft m r
  | 0, r, hr =>
    calc finProdLeft 0 r
        = r 0 := finProdLeft_zero r                                           -- 定義
      _ > 0 := hr 0                                                           -- 仮定 `r_1 > 0`
  | m + 1, r, hr =>
    have hprod : 0 < finProdLeft m (fun j => r (Fin.castSucc j)) :=
      finProdLeft_pos' hmul m (fun j => r (Fin.castSucc j)) (fun j => hr _)  -- 帰納法の仮定
    have hlast : 0 < r (Fin.last (m + 1)) := hr _                             -- 仮定 `r_{m+1} > 0`
    calc finProdLeft (m + 1) r
        = finProdLeft m (fun j => r (Fin.castSucc j)) * r (Fin.last (m + 1)) :=
          finProdLeft_succ m r                                                -- 定義
      _ > 0 := hmul _ _ hprod hlast                                           -- `a > 0, b > 0` なら `ab > 0`

end Ising2D.NecSuf
