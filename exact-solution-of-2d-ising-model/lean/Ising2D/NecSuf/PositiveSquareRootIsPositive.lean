/-
# 正の元の非負の平方根は正（**必要十分版**）

対応する人手証明のラベル: `sqrt_of_positive_real_is_positive`
（`structured-latex/content/000_calculation_formulae_20_29.ts`）

具体版: `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSqrtOfPositiveRealIsPositive.lean`。
具体版をこの特殊化（`R := ℝ`、`y := √x`）として導くのは同じフォルダの `ClaimSqrtOfPositiveRealIsPositiveFromNecSuf.lean`。

## 何が効いているか / 効いていないか

具体版と同じ手順（前置きの `y ≥ 0`・`y^2 = x`、背理法の 4 段の鎖、`≥` と `≠` から `>`）で、効くのは

* 冪の定義の 2 つの式と `1` が乗法の単位元であること（`sq_eq_mul_self'`。具体版の `square_of_real_number_is_product`。`Monoid` は冪 `^` を使うためだけに要る）、
* `0·0 = 0`（仮定 `h00`。具体版が使うのは `0·x = 0` の `x → 0` の 1 点だけなので、`MonoidWithZero` の `0·a = 0`・`a·0 = 0` を取らずに明示の仮定にした）、
* 順序の反対称律（`PartialOrder`。`0 ≤ y` かつ `y ≠ 0` から `0 < y` を出す最後の段で要る。前順序では `≤` かつ `≠` から `<` が出ない）

だけである。平方根という写像そのもの（存在・一意性・上限性質による構成）、実数であること、全順序、
加法、乗法と順序の両立、乗法の可換性は効いていない。`y` は「`0 ≤ y` かつ `y^2 = x`」を満たしさえすればよい。
-/
import Mathlib.Order.Basic
import Ising2D.NecSuf.SquareIsProduct

namespace Ising2D.NecSuf

/-- **必要十分版**: `0 ≤ y`、`y^2 = x`、`0 < x` なら `0 < y`。具体版 `sqrt_of_positive_real_is_positive` と同じ段の並び。 -/
theorem pos_of_nonneg_of_sq_eq_pos {R : Type*} [Monoid R] [Zero R] [PartialOrder R] {x y : R}
    (h00 : (0 : R) * 0 = 0) (hy0 : 0 ≤ y) (hyx : y ^ 2 = x) (hx : 0 < x) : 0 < y := by
  have hne : y ≠ 0 := by
    intro h                                              -- 背理法: `y = 0` と仮定する
    have : x = 0 :=
      calc x
          = y ^ 2 := hyx.symm                            -- `y^2 = x` を右辺から左辺へ
        _ = (0 : R) ^ 2 := by rw [h]                     -- 仮定 `y = 0`
        _ = 0 * 0 := sq_eq_mul_self' 0                   -- 冪の定義（具体版の `square_of_real_number_is_product`）
        _ = 0 := h00                                     -- 仮定 `0·0 = 0`（具体版の ℝ で `0·x = 0` の `x → 0`）
    exact hx.ne' this                                    -- `0 < x` に反する（`<` の非反射律）
  exact lt_of_le_of_ne hy0 (Ne.symm hne)                 -- 反対称律: `0 ≤ y` かつ `y ≠ 0` なら `0 < y`

end Ising2D.NecSuf
