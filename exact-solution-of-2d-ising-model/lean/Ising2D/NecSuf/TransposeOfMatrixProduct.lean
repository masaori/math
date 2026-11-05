/-
# 行列の積の転置は転置を逆の順に掛けた積（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixProduct.lean`
（人手 `transpose_of_matrix_product`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_transpose_mul_apply`（転置の定義 → 積の定義 → 転置の定義を各項の 2 箇所 → 係数の積の交換律を各項へ → 積の定義） | `transpose_mul_matrix_apply'`（同じ並び） |
| `matrix_transpose_mul`（全ての成分が一致する） | `transpose_mul_matrix'` |

## 何が効いているか / 効いていないか

- 効いているのは、**係数の積の交換律**と、積の成分が有限和であることだけである。
  係数の型 `R` に置いたのは `CommMagma R`（積と、その交換律）と `AddCommMonoid R`（行列の積の成分の有限和 `Finset.sum` に要る）で、
  積の結合則・分配則・単位元・零の性質は 1 つも使わない。
- 交換律は削れない。具体版の 4 段目（`ℂ` の積の交換律を各項へ）がそれを使い、交換律の無い係数では主張が成り立たない
  （1 行 1 列の行列 `A = (a)`, `B = (b)` では左辺が `(ab)`、右辺が `(ba)` で、`ab ≠ ba` なら一致しない）。
- 加法については、`AddCommMonoid` は mathlib の行列の積の定義（`Finset.sum`）が要求するもので、鎖の段は和の性質を使わない
  （各段は和の項を 1 つずつ書き換えるだけである）。
- 行の添字 `ι`・列の添字 `κ` は任意の型、和を取る添字 `σ` は有限型（積の定義に要る）で、正方であることも順序も効いていない。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2D.NecSuf

open Matrix

variable {ι σ κ : Type*} [Fintype σ]

/-- **`((AB)^⊤)_{kl} = (B^⊤A^⊤)_{kl}`**（具体版 `matrix_transpose_mul_apply`）。係数は積の交換律と、和を取るための `AddCommMonoid`。 -/
theorem transpose_mul_matrix_apply' {R : Type*} [CommMagma R] [AddCommMonoid R]
    (A : Matrix ι σ R) (B : Matrix σ κ R) (k : κ) (l : ι) :
    (A * B)ᵀ k l = (Bᵀ * Aᵀ) k l :=
  calc (A * B)ᵀ k l
      = (A * B) l k := rfl                                                    -- 転置の定義
    _ = ∑ j, A l j * B j k := rfl                                             -- 積の定義
    _ = ∑ j, Aᵀ j l * Bᵀ k j := rfl                                           -- 転置の定義（各項の 2 箇所へ同時適用）
    _ = ∑ j, Bᵀ k j * Aᵀ j l :=
        Finset.sum_congr rfl fun _ _ => mul_comm _ _                          -- 係数の積の交換律（各項へ同時適用）
    _ = (Bᵀ * Aᵀ) k l := rfl                                                  -- 積の定義

/-- **`(AB)^⊤ = B^⊤A^⊤`**（具体版 `matrix_transpose_mul`）。 -/
theorem transpose_mul_matrix' {R : Type*} [CommMagma R] [AddCommMonoid R]
    (A : Matrix ι σ R) (B : Matrix σ κ R) : (A * B)ᵀ = Bᵀ * Aᵀ :=
  Matrix.ext (transpose_mul_matrix_apply' A B)   -- 全ての成分が一致する

end Ising2D.NecSuf
