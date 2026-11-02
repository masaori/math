/-
# 左から掛ける有限積と、単位元の有限積（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionFiniteProductOfMatrices.lean`
（人手 `def_finite_product_of_matrices`・`finite_product_of_identity_matrices`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionFiniteProductOfMatricesFromNecSuf.lean`。

人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。すなわち Lean の `finProdLeft r A`（因子 `A : Fin (r + 1) → R`）は人手の `∏_{j=1}^{r+1} A_j` で、人手の `A_j` が Lean の `A (j - 1)` である。
定義の 2 つの式（`∏_{j=1}^{1} A_j := A_1`、`∏_{j=1}^{r+2} A_j := (∏_{j=1}^{r+1} A_j) A_{r+2}`）が、そのまま `finProdLeft` の 2 つの節である。
mathlib の `List.prod` は右から畳み込み、空の積を `1` とするので、人手の定義（左から掛け、空の積を持たない）と形が違う。そのため使わない。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `finite_product_of_identity_matrices` の `r = 1`（定義） | `finProdLeft_const_one'` の `0` の節（定義） |
| 同じく `r → r + 1`（定義 → 帰納法の仮定 → `I I = I`） | `finProdLeft_const_one'` の `r + 1` の節（同じ並び） |

## 何が効いているか / 効いていないか

- 有限積の定義に要るのは二項演算 `*` だけである（`Mul R`）。単位元・結合則は定義に効いていない（空の積を持たないので単位元が要らない）。
- `∏ 1 = 1` に効くのは、`1·1 = 1`（仮定 `h`）だけである。具体版は `identity_matrix_is_right_unit_of_mat_mult` を `A → I` で使うが、
  効いているのはその `A = I` の場合だけである。積の結合則、`1` が左右の単位元であること（`1 = I` 以外の元について）、可換則は効いていない。
-/
import Mathlib.Data.Fin.Basic
import Mathlib.Algebra.Group.Defs

namespace Ising2D.NecSuf

/-- **`def_finite_product_of_matrices`** の必要十分版: `r + 1` 個の因子を左から順に掛ける。 -/
def finProdLeft {R : Type*} [Mul R] : (r : ℕ) → (Fin (r + 1) → R) → R
  | 0, A => A 0
  | r + 1, A => finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))

/-- `∏_{j=1}^{1} A_j := A_1`。 -/
theorem finProdLeft_zero {R : Type*} [Mul R] (A : Fin 1 → R) : finProdLeft 0 A = A 0 := rfl

/-- `∏_{j=1}^{r+2} A_j := (∏_{j=1}^{r+1} A_j) A_{r+2}`（人手の `r` は Lean の `r + 1`）。 -/
theorem finProdLeft_succ {R : Type*} [Mul R] (r : ℕ) (A : Fin (r + 2) → R) :
    finProdLeft (r + 1) A = finProdLeft r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)) := rfl

/-- **`∏ 1 = 1`**（具体版 `finite_product_of_identity_matrices`）。 -/
theorem finProdLeft_const_one' {R : Type*} [Mul R] [One R] (h : (1 : R) * 1 = 1) :
    ∀ r : ℕ, finProdLeft r (fun _ => (1 : R)) = 1
  | 0 =>
    calc finProdLeft 0 (fun _ => (1 : R))
        = 1 := finProdLeft_zero _                                        -- 定義
  | r + 1 =>
    calc finProdLeft (r + 1) (fun _ => (1 : R))
        = finProdLeft r (fun _ => (1 : R)) * 1 := finProdLeft_succ r _    -- 定義
      _ = 1 * 1 := by rw [finProdLeft_const_one' h r]                    -- 帰納法の仮定
      _ = 1 := h                                                         -- `1·1 = 1`

end Ising2D.NecSuf
