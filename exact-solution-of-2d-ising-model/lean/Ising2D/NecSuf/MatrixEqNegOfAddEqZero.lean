/-
# 和が零行列なら一方は他方の符号反転（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixEqualsNegationIfSumIsZero.lean`
（人手 `matrix_equals_negation_if_sum_is_zero`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixEqualsNegationIfSumIsZeroFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `X - (-Y) = X + (-(-Y))`（`matrix_sub_eq_add_neg`） | `sub_eq_add_neg_matrix'`（`hsub := sub_eq_add_neg`） |
| `X + (-(-Y)) = X + Y`（`neg_neg_matrix`） | 成分ごとの `-(-y) = y`（`neg_neg`） |
| `X + Y = O`（仮定） | 仮定 |
| `X - (-Y) = O ⟹ X = -Y`（`matrix_sub_eq_zero_iff`） | `sub_eq_zero_iff_matrix` |

## 何が効いているか / 効いていないか

- 効くのは、係数の加法が群であること（`AddGroup`）だけである。差を和と符号反転で書くこと（`x - y = x + (-y)`）、
  符号反転を二回施すと元に戻ること（`-(-y) = y`）、`x - y = 0 ⟹ x = y` はどれも加法群の公理から出る。
- **加法の可換則、乗法は効いていない。** 具体版の `matrix_double_negation` は `ℂ` の `-z = (-1)z` と `(-1)(-1) = 1` を経由して示すが、
  この主張に要るのは `-(-y) = y` だけで、それは加法群で成り立つので、乗法を仮定に置かない
  （`NecSuf.neg_neg_matrix'` の仮定 `hneg`・`hmm` はここでは要らない）。`NecSuf.neg_sub_neg_matrix'` などは引いた主張の
  必要十分版を仮定ごと使い回すが、ここでは `neg_neg_matrix'` を使うと乗法が仮定に入る一方、最後の段がもともと `AddGroup` を要し、
  `AddGroup` から `-(-y) = y` が出るので、`neg_neg_matrix'` を使わず成分ごとの `-(-y) = y` で示す。
- 行列の添字の集合は任意で、有限であることも効いていない。
-/
import Ising2D.NecSuf.MatrixSubNeg
import Ising2D.NecSuf.MatrixVectorIdentityScalarDifference

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`X + Y = O` なら `X - (-Y) = O`**（具体版 `matrix_sub_neg_eq_zero_of_add_eq_zero` の鎖）。 -/
theorem sub_neg_eq_zero_of_add_eq_zero_matrix' {R : Type*} [AddGroup R]
    (X Y : Matrix ι κ R) (h : X + Y = 0) : X - (-Y) = 0 :=
  calc X - (-Y)
      = X + (-(-Y)) := sub_eq_add_neg_matrix' (fun x y => sub_eq_add_neg x y) X (-Y)
                                                        -- `x - y = x + (-y)` を行列へ（`A → X`, `B → -Y`）
    _ = X + Y := by
          rw [show -(-Y) = Y from Matrix.ext fun i k => neg_neg (Y i k)]
                                                        -- 成分ごとの `-(-y) = y`（符号反転を二回施すと元に戻る）
    _ = 0 := h                                          -- 仮定 `X + Y = O`

/-- **`X + Y = O` なら `X = -Y`**（具体版 `matrix_eq_neg_of_add_eq_zero`）。 -/
theorem eq_neg_of_add_eq_zero_matrix' {R : Type*} [AddGroup R]
    (X Y : Matrix ι κ R) (h : X + Y = 0) : X = -Y :=
  (sub_eq_zero_iff_matrix X (-Y)).mp (sub_neg_eq_zero_of_add_eq_zero_matrix' X Y h)
                                                        -- `A - B = O ⟹ A = B`（`A → X`, `B → -Y`）

end Ising2D.NecSuf
