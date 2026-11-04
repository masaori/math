/-
# 和を積へ送る写像は、左から足す有限和を左から掛ける有限積へ送る（必要十分版）

具体版: `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpOfFiniteSum.lean`
（人手 `real_exp_of_finite_sum`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpOfFiniteSumFromNecSuf.lean`。

人手の `m ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。`finSumLeft r x`（項 `x : Fin (r + 1) → G`）は人手の `Σ_{j=1}^{r+1} x_j`
（`def_finite_sum_of_real_numbers` の 2 つの式がそのまま 2 つの節）、`finProdLeft r A`（`Ising2D/NecSuf/FiniteProductLeft.lean`）は
人手の `Π_{j=1}^{r+1} A_j`（`def_finite_product_of_real_numbers` の 2 つの式）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `m = 1` の 2 行（和の定義 → 積の定義を右辺から左辺へ） | `map_finSumLeft` の `0` の節（同じ並び） |
| `m → m + 1` の 4 行（和の定義 → `scalar_exp_product` を右辺から左辺へ → 帰納法の仮定 → 積の定義を右辺から左辺へ） | `map_finSumLeft` の `r + 1` の節（和の定義 → `f(a+b) = f(a)f(b)` → 帰納法の仮定 → 積の定義） |

## 何が効いているか / 効いていないか

- 写像について効くのは、和を積へ送ること `f(a+b) = f(a)f(b)`（仮定 `hadd`）だけである。外すと通らない:
  `ℝ` 上の `f(x) = x + 1` では `f(1 + 1) = 3` だが `f(1)f(1) = 4` である。
  `exp` が級数（行列の exp の成分）で定義されていること、`f(0) = 1`、値が正であることは効いていない
  （空の和を持たないので `f(0)` が現れない）。
- 定義域について効くのは二項演算 `+` だけ（`Add G`）、値域について効くのは二項演算 `*` だけ（`Mul R`）である。
  加法・乗法の結合則・可換則・単位元・逆元、定義域と値域が ℝ であることは効いていない
  （和も積も左から順に畳み込むので、並べ替えも括弧の付け替えも起きない）。
-/
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`def_finite_sum_of_real_numbers`** の必要十分版: `r + 1` 個の項を左から順に足す。 -/
def finSumLeft {G : Type*} [Add G] : (r : ℕ) → (Fin (r + 1) → G) → G
  | 0, x => x 0
  | r + 1, x => finSumLeft r (fun j => x (Fin.castSucc j)) + x (Fin.last (r + 1))

/-- `Σ_{j=1}^{1} x_j := x_1`。 -/
theorem finSumLeft_zero {G : Type*} [Add G] (x : Fin 1 → G) : finSumLeft 0 x = x 0 := rfl

/-- `Σ_{j=1}^{r+2} x_j := (Σ_{j=1}^{r+1} x_j) + x_{r+2}`（人手の `m` は Lean の `r + 1`）。 -/
theorem finSumLeft_succ {G : Type*} [Add G] (r : ℕ) (x : Fin (r + 2) → G) :
    finSumLeft (r + 1) x = finSumLeft r (fun j => x (Fin.castSucc j)) + x (Fin.last (r + 1)) := rfl

/-- **`f(Σ_j x_j) = Π_j f(x_j)`**（具体版 `real_exp_of_finite_sum`）。`f` は和を積へ送る写像。 -/
theorem map_finSumLeft {G R : Type*} [Add G] [Mul R]
    (f : G → R) (hadd : ∀ a b, f (a + b) = f a * f b) :
    ∀ (r : ℕ) (x : Fin (r + 1) → G), f (finSumLeft r x) = finProdLeft r (fun j => f (x j))
  | 0, x =>
    calc f (finSumLeft 0 x)
        = f (x 0) := by rw [finSumLeft_zero]                                   -- 和の定義
      _ = finProdLeft 0 (fun j => f (x j)) := (finProdLeft_zero (fun j => f (x j))).symm -- 積の定義を右辺から左辺へ
  | r + 1, x =>
    calc f (finSumLeft (r + 1) x)
        = f (finSumLeft r (fun j => x (Fin.castSucc j)) + x (Fin.last (r + 1))) := by
          rw [finSumLeft_succ]                                                  -- 和の定義
      _ = f (finSumLeft r (fun j => x (Fin.castSucc j))) * f (x (Fin.last (r + 1))) :=
          hadd _ _                                                              -- `f(a+b) = f(a)f(b)`
      _ = finProdLeft r (fun j => f (x (Fin.castSucc j))) * f (x (Fin.last (r + 1))) := by
          rw [map_finSumLeft f hadd r]                                          -- 帰納法の仮定
      _ = finProdLeft (r + 1) (fun j => f (x j)) := (finProdLeft_succ r (fun j => f (x j))).symm -- 積の定義を右辺から左辺へ

end Ising2D.NecSuf
