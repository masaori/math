/-
# 第二の双対結合定数 `K_2^*`

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_000k_definition_second_dual_coupling_constant`
  （ラベル **`def_second_dual_coupling_constant`**）

人手の定義: `K_2 ∈ ℝ_{>0}` に対して `K_2^* := -(1/2) log(tanh K_2)`（`tanh K_2 > 0`）。
実対数は `Real.log`。人手の定義域 `K_2 > 0` は、値を使う補題の仮定 `0 < K2` として置く
（`Real.log` は全域で定義されているので、関数の定義自体には仮定を要しない）。
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

end Ising2D
