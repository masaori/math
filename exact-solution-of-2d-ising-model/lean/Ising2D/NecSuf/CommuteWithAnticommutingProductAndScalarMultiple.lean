/-
# 反可換な二つの元の積は可換、可換な元のスカラー倍とも可換（**必要十分版**）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimProductOfAnticommutingMatricesCommutes.lean`
（人手 `product_of_anticommuting_matrices_commutes`）と
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutingWithScalarMultiple.lean`
（人手 `commuting_with_scalar_multiple`）。具体版をこのファイルの系として導くのは、同じフォルダの
`ClaimProductOfAnticommutingMatricesCommutesFromNecSuf.lean`・`ClaimCommutingWithScalarMultipleFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `product_of_anticommuting_matrices_commutes` の 8 行（結合則・仮定・符号反転を左因子から外へ・結合則・仮定・符号反転を右因子から外へ・二重の符号反転・結合則） | `commute_mul_of_anticomm'` の 8 段（同じ並び） |
| `commuting_with_scalar_multiple` の 3 行（スカラー倍を右因子から外へ・仮定・スカラー倍を左因子へ） | `commute_smul_of_commute'` の 3 段（同じ並び） |

## 何が効いているか / 効いていないか

- `commute_mul_of_anticomm'` に効いているのは、**積の結合則**（`Semigroup`）と、**符号反転が積の各因子から外へ出ること、
  符号反転を二回すると元に戻ること**（`HasDistribNeg`）だけである。加法・零・単位元は鎖に出ない。
  行列であること、複素数であること、`G` が `ε` であることは効いていない。
- `commute_smul_of_commute'` に効いているのは、**積が各因子について `𝕜` 倍と交換すること**
  （`SMulCommClass 𝕜 A A`・`IsScalarTower 𝕜 A A`）だけである。`A` の積の結合則も、`𝕜` の構造（積・和・単位元）も効いていない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Action.Defs

namespace Ising2D.NecSuf

section AnticommProduct

variable {A : Type*} [Semigroup A] [HasDistribNeg A]

/-- **`product_of_anticommuting_matrices_commutes` の必要十分版**: `GX = −(XG)` かつ `GY = −(YG)` なら
`G(XY) = (XY)G`。calc の 8 段は具体版 `Ising2D.matrix_mul_comm_of_anticomm_pair` の 8 段と同じ順に並ぶ。 -/
theorem commute_mul_of_anticomm' {G X Y : A} (hX : G * X = -(X * G)) (hY : G * Y = -(Y * G)) :
    G * (X * Y) = (X * Y) * G :=
  calc G * (X * Y)
      = (G * X) * Y := (mul_assoc G X Y).symm           -- `mat_mult_associative` にあたる
    _ = (-(X * G)) * Y := by rw [hX]                    -- 仮定 `GX = −(XG)`
    _ = -((X * G) * Y) := neg_mul _ _                   -- `negation_factors_out_of_left_factor` にあたる
    _ = -(X * (G * Y)) := by rw [mul_assoc]             -- `mat_mult_associative` にあたる
    _ = -(X * (-(Y * G))) := by rw [hY]                 -- 仮定 `GY = −(YG)`
    _ = -(-(X * (Y * G))) := by rw [mul_neg]            -- `negation_factors_out_of_right_factor` にあたる
    _ = X * (Y * G) := neg_neg _                        -- `matrix_double_negation` にあたる
    _ = (X * Y) * G := (mul_assoc X Y G).symm           -- `mat_mult_associative` にあたる

end AnticommProduct

section ScalarCommute

variable {𝕜 A : Type*} [Mul A] [SMul 𝕜 A] [SMulCommClass 𝕜 A A] [IsScalarTower 𝕜 A A]

/-- **`commuting_with_scalar_multiple` の必要十分版**: `GX = XG` なら `G(cX) = (cX)G`。
calc の 3 段は具体版 `Ising2D.matrix_mul_smul_comm_of_commute` の 3 段と同じ順に並ぶ。 -/
theorem commute_smul_of_commute' {G X : A} (c : 𝕜) (h : G * X = X * G) :
    G * (c • X) = (c • X) * G :=
  calc G * (c • X)
      = c • (G * X) := mul_smul_comm c G X              -- `scalar_multiple_factors_out_of_right_factor` にあたる
    _ = c • (X * G) := by rw [h]                        -- 仮定 `GX = XG`
    _ = (c • X) * G := (smul_mul_assoc c X G).symm      -- `scalar_multiple_factors_out_of_left_factor` にあたる

end ScalarCommute

end Ising2D.NecSuf
