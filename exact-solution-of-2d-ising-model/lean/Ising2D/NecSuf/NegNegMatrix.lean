/-
# 行列の符号反転を二回施すと元に戻る（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDoubleNegation.lean`
（人手 `matrix_double_negation`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDoubleNegationFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `neg_neg_matrix_apply`（符号反転の定義 2 回 → `-x = (-1)x` → 積の結合律 → `(-1)(-1) = 1` → 左単位元） | `neg_neg_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- 係数は `Monoid` と `Neg` だけを型クラスに取り、符号反転と積のつながりは仮定 `hneg : ∀ x, -x = (-1) * x`（人手の
  `multiply_by_minus_one` はこの形の定義である）と `hmm : (-1) * (-1) = 1`（人手の `definition_of_cc` の積の計算）で渡す。
  `HasDistribNeg` を取ると `-(-x) = x` が型クラスの側に入ってしまい、何が効いているかが見えなくなるので取らない。
- 効いているのは `hneg`・`hmm`・積の結合律・左単位元 `1x = x` の 4 つで、どれを欠いても鎖は通らない。
  `Monoid` が連れてくる右単位元 `x1 = x` は効いていない（左単位元だけを引く型クラスが無いので残した）。
- **加法は効いていない。** 成分の鎖に和が一つも現れない。積の可換律も効いていない。
- 添字の有限性も、`Fin m`・`Fin n` の順序も効いていない（添字の型は任意）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(-(-A))_{ij} = A_{ij}`**（具体版 `neg_neg_matrix_apply`）。 -/
theorem neg_neg_matrix_apply' {R : Type*} [Monoid R] [Neg R]
    (hneg : ∀ x : R, -x = (-1) * x) (hmm : (-1 : R) * (-1) = 1)
    (A : Matrix ι κ R) (i : ι) (j : κ) : (-(-A)) i j = A i j :=
  calc (-(-A)) i j
      = -((-A) i j) := rfl                                                   -- 符号反転の定義
    _ = -(-A i j) := rfl                                                     -- 符号反転の定義
    _ = (-1) * ((-1) * A i j) := by rw [hneg (-A i j), hneg (A i j)]         -- `-x = (-1)x`（2 か所へ同時適用）
    _ = ((-1) * (-1)) * A i j := (mul_assoc _ _ _).symm                      -- 積の結合律
    _ = 1 * A i j := by rw [hmm]                                             -- `(-1)(-1) = 1`
    _ = A i j := one_mul _                                                   -- 左単位元

/-- **`-(-A) = A`**（具体版 `neg_neg_matrix`）。 -/
theorem neg_neg_matrix' {R : Type*} [Monoid R] [Neg R]
    (hneg : ∀ x : R, -x = (-1) * x) (hmm : (-1 : R) * (-1) = 1) (A : Matrix ι κ R) :
    -(-A) = A :=
  Matrix.ext (neg_neg_matrix_apply' hneg hmm A)   -- 全ての成分が一致する

end Ising2D.NecSuf
