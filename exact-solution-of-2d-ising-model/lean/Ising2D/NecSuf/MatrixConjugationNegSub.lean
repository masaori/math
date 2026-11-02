/-
# 行列の共役は符号反転と差を保つ（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesDifference.lean`
（人手 `matrix_conjugation_preserves_negation`・`matrix_conjugation_preserves_difference`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesDifferenceFromNecSuf.lean`。

`NecSuf/MatrixConjugationSum.lean` と同じく、共役 `T_B(A) = (BA)B^{-1}` の `B^{-1}` を任意の行列 `B'` に置き換えて `(BA)B'` について述べる。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `conj_neg_matrix`（`T_B` の定義 → 符号反転を右の因子から出す → 左の因子から出す → `T_B` の定義） | `conj_neg_matrix'`（同じ並び） |
| `conj_sub_matrix`（差を和と符号反転へ → 和を保つ → 符号反転を保つ → 和と符号反転を差へ） | `conj_sub_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- **`B` が可逆であること、`B'` が `B` の逆元であること、行列の積の結合則は効いていない**（`(BA)B'` の括弧のまま変形する）。
- 符号反転を保つことで効いているのは、符号反転を積の外へ出す 2 つ（`NecSuf.mul_neg_matrix'`・`NecSuf.neg_mul_matrix'`）であり、
  係数は `Semiring` と `HasDistribNeg`（`-x = (-1)x`、乗法の結合則、有限和への左分配則）である。
  **係数の乗法の可換則と加法の逆元は効いていない**（`-1` は単位元と `HasDistribNeg` だけから全ての元と交換する）。
  `HasDistribNeg` が連れてくる二重の符号反転 `-(-x) = x`（`InvolutiveNeg`）も効いていない。
- 差を保つことで効いているのは、差が `x + (-y)` で定まること（仮定 `hsub`。人手の `def_complex_difference`）、和を保つこと
  （`NecSuf.conj_add_matrix'`。係数の左右の分配則と加法の結合則・交換則）、上の符号反転を保つことだけである。
  `Sub` を `Semiring` と別に取るのは、`hsub` と `Semiring`・`HasDistribNeg` を加法の逆元なしで同時に持つ型クラスが mathlib に無いからである
  （`NecSuf/SmulMatrixSub.lean` と同じ扱い）。
- 行列が正方であることは効いていない（`B : ι × κ`、`W : κ × κ'`、`B' : κ' × μ` の形で述べる）。添字は有限であること（積が有限和だから）だけが効く。
-/
import Ising2D.NecSuf.MatrixConjugationSum
import Ising2D.NecSuf.NegMatrixProduct
import Ising2D.NecSuf.MatrixSubNeg

namespace Ising2D.NecSuf

open Matrix

variable {R : Type*} {ι κ κ' μ : Type*}

/-- **符号反転を保つ**（具体版 `conj_neg_matrix`）: `(B(-W))B' = -((BW)B')`。 -/
theorem conj_neg_matrix' [Semiring R] [HasDistribNeg R] [Fintype κ] [Fintype κ']
    (B : Matrix ι κ R) (B' : Matrix κ' μ R) (W : Matrix κ κ' R) :
    (B * (-W)) * B' = -((B * W) * B') :=
  calc (B * (-W)) * B'
      = (-(B * W)) * B' := by rw [mul_neg_matrix' B W]                        -- 符号反転を右の因子から出す
    _ = -((B * W) * B') := neg_mul_matrix' _ _                                -- 符号反転を左の因子から出す

/-- **差を保つ**（具体版 `conj_sub_matrix`）: `(B(X - W))B' = (BX)B' - (BW)B'`。 -/
theorem conj_sub_matrix' [Semiring R] [HasDistribNeg R] [Sub R] (hsub : ∀ x y : R, x - y = x + -y)
    [Fintype κ] [Fintype κ'] (B : Matrix ι κ R) (B' : Matrix κ' μ R) (X W : Matrix κ κ' R) :
    (B * (X - W)) * B' = (B * X) * B' - (B * W) * B' :=
  calc (B * (X - W)) * B'
      = (B * (X + (-W))) * B' := by rw [sub_eq_add_neg_matrix' hsub X W]      -- 差を和と符号反転へ
    _ = (B * X) * B' + (B * (-W)) * B' := conj_add_matrix' _ _ _ _            -- 和を保つ
    _ = (B * X) * B' + (-((B * W) * B')) := by rw [conj_neg_matrix' B B' W]   -- 符号反転を保つ
    _ = (B * X) * B' - (B * W) * B' := (sub_eq_add_neg_matrix' hsub _ _).symm -- 和と符号反転を差へ

end Ising2D.NecSuf
