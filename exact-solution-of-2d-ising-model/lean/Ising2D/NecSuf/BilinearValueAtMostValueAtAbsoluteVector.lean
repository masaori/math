/-
# 必要十分版: 成分が非負の行列 `P` について `x^⊤Px ≤ u^⊤Pu`（`u_k := |x_k|`）

人手証明のラベル: **`real_bilinear_value_at_most_value_at_absolute_vector`**
（正本 `structured-latex/content/011_max_eigenvalue.ts`）。
具体版は `Ising2D.real_bilinear_value_at_most_value_at_absolute_vector`
（`Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimRealBilinearValueAtMostValueAtAbsoluteVector.lean`）で、
導出は同じフォルダの `ClaimRealBilinearValueAtMostValueAtAbsoluteVectorFromNecSuf.lean` に置く。

## 手順（具体版の `calc` の 9 段と同じ並び）

| 具体版の段 | 本ファイル |
| --- | --- |
| 準備: 各 `k` の有限和の三角不等式 | `abs_bilinear_row_le_row_abs_sum'` |
| 1 段目 `real_number_is_at_most_its_absolute_value` | `le_abs'`（`NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean`） |
| 2 段目 `def_real_bilinear_value` | `dotProduct_mulVec_eq_double_sum'` |
| 3 段目 有限和の三角不等式 | `Finset.abs_sum_le_sum_abs` |
| 4 段目 有限和の単調性（各 `k` は準備） | `Finset.sum_le_sum` |
| 5・6 段目 `real_abs_of_product` を 2 回 | `abs_mul'`（同じファイル） |
| 7 段目 `\|P_kl\| = P_kl`（`P_kl ≥ 0`） | `abs_of_nonneg` |
| 8 段目 `u_k := \|x_k\|` | 定義どおり（`rfl`） |
| 9 段目 `def_real_bilinear_value` を右辺から左辺へ | `dotProduct_mulVec_eq_double_sum'` |

有限和の三角不等式と単調性は、添字が `Fin` の既存の必要十分版（`NecSuf/FiniteSumSubadditiveAndMonotone.lean`）ではなく、
添字が一般の有限型の和に使える mathlib の `Finset.abs_sum_le_sum_abs`・`Finset.sum_le_sum` を引く（具体版の `_fintype` 版の段に当たる）。

## この主張に本質的に効いている構造

* 係数 `R` は、加法について可換群で全順序と両立し（有限和の三角不等式・単調性）、
  `0 ≤ a` を左から掛けると `≤` が保たれる（`PosMulMono`。積の絶対値 `abs_mul'` に要る）。
* 分配律と乗法の結合則は、mathlib の `x ⬝ᵥ P *ᵥ y`（`Σ_k x_k (Σ_l P_kl y_l)`）を人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く段
  （2・9 段目）だけで使う。乗法の可換性・単位元・逆元・ℝ の完備性は使わない。
* `P` の成分は非負であることだけを使う（人手の用途 `W_ℝ` の正値性は要らない）。
-/
import Ising2D.NecSuf.AbsoluteValueBoundsTriangleAndProduct
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Data.Matrix.Mul

set_option linter.unusedSectionVars false

namespace Ising2D.NecSuf

open Matrix

variable {n : Type*} [Fintype n]

section DoubleSum

variable {R : Type*} [NonUnitalSemiring R]

/-- 2・9 段目: mathlib の `x ⬝ᵥ P *ᵥ y` を人手の `Σ_kΣ_l (x_kP_kl)y_l` へ開く（分配律と乗法の結合則だけを使う）。
`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean` も同じ段に使うので、係数は非単位的な半環に置く。 -/
theorem dotProduct_mulVec_eq_double_sum' (x y : n → R) (P : Matrix n n R) :
    x ⬝ᵥ P *ᵥ y = ∑ k, ∑ l, x k * P k l * y l :=
  calc x ⬝ᵥ P *ᵥ y
      = ∑ k, x k * ∑ l, P k l * y l := rfl
    _ = ∑ k, ∑ l, x k * (P k l * y l) := by simp only [Finset.mul_sum]
    _ = ∑ k, ∑ l, x k * P k l * y l := by simp only [mul_assoc]

end DoubleSum

variable {R : Type*} [NonUnitalRing R] [LinearOrder R] [IsOrderedAddMonoid R] [PosMulMono R]

/-- 準備: 各 `k` で `|Σ_l x_kP_klx_l| ≤ Σ_l |x_kP_klx_l|`。 -/
theorem abs_bilinear_row_le_row_abs_sum' (P : Matrix n n R) (x : n → R) (k : n) :
    |∑ l, x k * P k l * x l| ≤ ∑ l, |x k * P k l * x l| :=
  Finset.abs_sum_le_sum_abs _ _

/-- **人手 `real_bilinear_value_at_most_value_at_absolute_vector` の必要十分版**。 -/
theorem bilinear_value_at_most_value_at_absolute_vector' (P : Matrix n n R)
    (hP : ∀ k l, 0 ≤ P k l) (x : n → R) :
    x ⬝ᵥ P *ᵥ x ≤ (fun k => |x k|) ⬝ᵥ P *ᵥ (fun k => |x k|) :=
  calc x ⬝ᵥ P *ᵥ x
      ≤ |x ⬝ᵥ P *ᵥ x| := le_abs' _
    _ = |∑ k, ∑ l, x k * P k l * x l| := by rw [dotProduct_mulVec_eq_double_sum']
    _ ≤ ∑ k, |∑ l, x k * P k l * x l| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ k, ∑ l, |x k * P k l * x l| :=
        Finset.sum_le_sum fun k _ => abs_bilinear_row_le_row_abs_sum' P x k
    _ = ∑ k, ∑ l, |x k * P k l| * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => abs_mul' _ _
    _ = ∑ k, ∑ l, |x k| * |P k l| * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [abs_mul' (x k) (P k l)]
    _ = ∑ k, ∑ l, |x k| * P k l * |x l| :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => by
          rw [abs_of_nonneg (hP k l)]
    _ = ∑ k, ∑ l, (fun k => |x k|) k * P k l * (fun k => |x k|) l := rfl
    _ = (fun k => |x k|) ⬝ᵥ P *ᵥ (fun k => |x k|) :=
        (dotProduct_mulVec_eq_double_sum' _ _ P).symm

end Ising2D.NecSuf
