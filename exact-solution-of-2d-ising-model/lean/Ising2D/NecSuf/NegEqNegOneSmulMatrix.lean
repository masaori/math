/-
# 行列の符号反転は −1 倍に等しい（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationIsScalarMultipleByMinusOne.lean`
（人手 `negation_is_scalar_multiple_by_minus_one`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationIsScalarMultipleByMinusOneFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `neg_eq_neg_one_smul_matrix_apply`（符号反転の定義 → `-x = (-1)x` → スカラー倍の定義） | `neg_eq_neg_one_smul_matrix_apply'`（同じ並び） |

## 何が効いているか / 効いていないか

- 型クラスは `MulOneClass` と `HasDistribNeg` にした。効いているのは `-x = (-1)x`（`neg_one_mul`）だけで、
  これは単位元 `1x = x` と、符号反転が積の左の因子から外へ出ること `(-a)b = -(ab)` から出る。どちらを欠いても通らない。
  `MulOneClass` が連れてくる右単位元 `x1 = x` は効いていない（左単位元だけを引く型クラスが無いので残した）。
- **乗法の結合則は効いていない。** 成分の鎖に積は `(-1)·x` の一つしか現れない。
- **加法は効いていない。** 成分の鎖に和が一つも現れないので、加法・分配則・零元のどれも要らない。
- 添字の有限性も、`Fin m`・`Fin n` の順序も効いていない（添字の型は任意）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(-A)_{ij} = ((-1)A)_{ij}`**（具体版 `neg_eq_neg_one_smul_matrix_apply`）。係数は `MulOneClass` と `HasDistribNeg`。 -/
theorem neg_eq_neg_one_smul_matrix_apply' {R : Type*} [MulOneClass R] [HasDistribNeg R]
    (A : Matrix ι κ R) (i : ι) (j : κ) : (-A) i j = ((-1 : R) • A) i j :=
  calc (-A) i j
      = -A i j := rfl                                                        -- 符号反転の定義
    _ = (-1) * A i j := (neg_one_mul _).symm                                 -- `-x = (-1)x`
    _ = ((-1 : R) • A) i j := rfl                                            -- スカラー倍の定義

/-- **`-A = (-1)A`**（具体版 `neg_eq_neg_one_smul_matrix`）。 -/
theorem neg_eq_neg_one_smul_matrix' {R : Type*} [MulOneClass R] [HasDistribNeg R] (A : Matrix ι κ R) :
    -A = (-1 : R) • A :=
  Matrix.ext (neg_eq_neg_one_smul_matrix_apply' A)   -- 全ての成分が一致する

end Ising2D.NecSuf
