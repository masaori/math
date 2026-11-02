/-
# 可換な二つの行列の差とも可換（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutingWithDifference.lean`
（人手 `commuting_with_difference`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutingWithDifferenceFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `G(X - W) = G(X + (-W))`（`matrix_sub_eq_add_neg`） | `sub_eq_add_neg_matrix'`（`hsub`） |
| `= GX + G(-W)`（`mul_add_matrix`） | `mul_add_matrix'` |
| `= XG + G(-W)`（仮定） | 仮定 |
| `= XG + (-(GW))`（`mul_neg_matrix`） | `mul_neg_matrix'` |
| `= XG + (-(WG))`（仮定） | 仮定 |
| `= XG + (-W)G`（`neg_mul_matrix`） | `neg_mul_matrix'` |
| `= (X + (-W))G`（`add_mul_matrix`） | `add_mul_matrix'` |
| `= (X - W)G`（`matrix_sub_eq_add_neg`） | `sub_eq_add_neg_matrix'`（`hsub`） |

## 何が効いているか / 効いていないか

- 係数の型クラスは `Semiring` と `HasDistribNeg`、それに差の記号 `Sub` と `x - y = x + (-y)`（仮定 `hsub`）である。
  `Semiring` と `HasDistribNeg` は、引いた `mul_neg_matrix'`・`neg_mul_matrix'`（符号反転を積の外へ出す段）が要するもので、
  そこでは `-x = (-1)x`・乗法の結合則・有限和への分配則が効く（`Ising2D/NecSuf/NegMatrixProduct.lean`）。
  分配の段 `mul_add_matrix'`・`add_mul_matrix'` は `Semiring` の分配則で足りる。
- **加法の逆元（`x + (-x) = 0`）は効いていない。** 鎖は差を和と符号反転に書き直して動かすだけで、`W + (-W) = O` を使う段が無い。
- **係数の乗法の可換則は効いていない。** 行列 `G` と `X`・`W` の可換性は仮定として外から与えられ、鎖はそれを使うだけである。
- 添字の集合は有限であること（`Fintype`。行列の積が有限和だから）だけが効き、`Fin n` の順序は効いていない。
  複素数であること、体であることは効いていない。
-/
import Ising2D.NecSuf.MatrixSubNeg
import Ising2D.NecSuf.MatMulDistribSum
import Ising2D.NecSuf.NegMatrixProduct

namespace Ising2D.NecSuf

open Matrix

variable {ι : Type*} [Fintype ι]

/-- **`GX = XG` かつ `GW = WG` なら `G(X - W) = (X - W)G`**（具体版 `matrix_mul_sub_eq_sub_mul_of_commute`）。 -/
theorem mul_sub_eq_sub_mul_of_commute_matrix' {R : Type*} [Semiring R] [HasDistribNeg R] [Sub R]
    (hsub : ∀ x y : R, x - y = x + -y) (G X W : Matrix ι ι R)
    (hX : G * X = X * G) (hW : G * W = W * G) : G * (X - W) = (X - W) * G :=
  calc G * (X - W)
      = G * (X + (-W)) := by rw [sub_eq_add_neg_matrix' hsub]
                                                        -- `x - y = x + (-y)` を行列へ（`A → X`, `B → W`）
    _ = G * X + G * (-W) := mul_add_matrix' G X (-W)    -- 右の因子の和への分配
    _ = X * G + G * (-W) := by rw [hX]                  -- 仮定 `GX = XG`
    _ = X * G + (-(G * W)) := by rw [mul_neg_matrix']   -- 右の因子の符号反転を積の外へ
    _ = X * G + (-(W * G)) := by rw [hW]                -- 仮定 `GW = WG`
    _ = X * G + (-W) * G := by rw [neg_mul_matrix']     -- 左の因子の符号反転を積の外へ（右辺から左辺へ）
    _ = (X + (-W)) * G := (add_mul_matrix' X (-W) G).symm
                                                        -- 左の因子の和への分配（右辺から左辺へ）
    _ = (X - W) * G := by rw [sub_eq_add_neg_matrix' hsub]
                                                        -- `x - y = x + (-y)` を行列へ（右辺から左辺へ）

end Ising2D.NecSuf
