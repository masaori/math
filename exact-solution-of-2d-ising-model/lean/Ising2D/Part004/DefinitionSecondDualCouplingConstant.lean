/-
# 第二の双対結合定数 `K_2^*`

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_000k_definition_second_dual_coupling_constant`
  （ラベル **`def_second_dual_coupling_constant`**）

* `transfer_matrix_000g_definition_positive_coupling_tanh`
  （ラベル **`def_positive_coupling_tanh`**）の値域 `0 < tanh K < 1`

人手の定義: `K_2 ∈ ℝ_{>0}` に対して `K_2^* := -(1/2) log(tanh K_2)`（`tanh K_2 > 0`）。
実対数は `Real.log`。人手の定義域 `K_2 > 0` は、値を使う補題の仮定 `0 < K2` として置く
（`Real.log` は全域で定義されているので、関数の定義自体には仮定を要しない）。

## 人手証明との対応

* `tanh_pos` / `positive_coupling_tanh_lt_one`: `def_positive_coupling_tanh` の証明の下側・上側の評価。
* `Kstar_pos`: `def_second_dual_coupling_constant` の証明の
  `log(tanh K_2) < 0`、`-1/2 < 0`、「負の実数二つの積は正」の三行。
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.DerivHyp

namespace Ising2D

/-- **人手 `def_second_dual_coupling_constant` の `K_2^* = -(1/2) log(tanh K_2)`。** -/
noncomputable def Kstar (K2 : ℝ) : ℝ := -(1 / 2) * Real.log (Real.tanh K2)

/-- `K_2 > 0` なら `tanh K_2 > 0`（実対数の引数が正であること）。 -/
theorem tanh_pos {K2 : ℝ} (h : 0 < K2) : 0 < Real.tanh K2 := by
  rw [Real.tanh_eq_sinh_div_cosh]
  exact div_pos (Real.sinh_pos_iff.mpr h) (Real.cosh_pos K2)

/-- **人手 `def_positive_coupling_tanh` の上側の評価** `tanh K < 1`。
`tanh K = sinh K / cosh K < cosh K / cosh K = 1`（`sinh K < cosh K` かつ `cosh K > 0`）。 -/
theorem positive_coupling_tanh_lt_one (K : ℝ) : Real.tanh K < 1 := by
  have hc : 0 < Real.cosh K := Real.cosh_pos K
  calc
    Real.tanh K = Real.sinh K / Real.cosh K := Real.tanh_eq_sinh_div_cosh K
    _ < Real.cosh K / Real.cosh K := div_lt_div_of_pos_right (Real.sinh_lt_cosh K) hc
    _ = 1 := div_self (ne_of_gt hc)

/-- **人手 `def_second_dual_coupling_constant` の正値性** `K_2^* > 0`（`K_2 > 0`）。 -/
theorem Kstar_pos {K2 : ℝ} (h : 0 < K2) : 0 < Kstar K2 := by
  -- `0 < tanh K_2 < 1 ⟹ log(tanh K_2) < 0`
  have hlog : Real.log (Real.tanh K2) < 0 := Real.log_neg (tanh_pos h) (positive_coupling_tanh_lt_one K2)
  -- `-1/2 < 0`
  have hhalf : -(1 / 2 : ℝ) < 0 := by norm_num
  -- 負の実数二つの積は正
  exact mul_pos_of_neg_of_neg hhalf hlog

end Ising2D
