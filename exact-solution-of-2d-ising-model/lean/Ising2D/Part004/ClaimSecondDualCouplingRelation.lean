/-
# 第二の結合定数と双対結合定数の双対関係

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_000l_claim_second_dual_coupling_relation`
  （ラベル **`second_dual_coupling_relation`**）

## 人手証明との対応

* `exp_two_Kstar_eq_inv_tanh` / `exp_neg_two_Kstar_eq_tanh`:
  `K₂*=-log(tanh K₂)/2` から `exp(±2K₂*)` を求める最初の二計算列。
* `sinh_two_Kstar_eq_half_inv_tanh_sub_tanh`:
  `sinh` の定義へ二つの指数等式を代入する計算列。
* `sinh_two_eq_two_sinh_mul_cosh`:
  人手証明が指数関数の定義から導いた倍角公式と同じ等式。
* `second_dual_coupling_relation`:
  `tanh=sinh/cosh`、商の反転、通分、非零因子の消去、`cosh²-sinh²=1` の順に進む後半。

実数の順序は `K₂>0` から分母の非零性を得るためだけに使う。実対数と指数関数は
`exp(log(tanh K₂))=tanh K₂` を与える箇所にだけ現れる。
-/
import Ising2D.Part004.ClaimTwoByTwoTransferIdentity

namespace Ising2D

/-- `exp(2K₂*)=1/tanh K₂`。人手証明の最初の計算列。 -/
theorem exp_two_Kstar_eq_inv_tanh {K2 : ℝ} (hK2 : 0 < K2) :
    Real.exp (2 * Kstar K2) = 1 / Real.tanh K2 := by
  have ht : 0 < Real.tanh K2 := tanh_pos hK2
  have ht0 : Real.tanh K2 ≠ 0 := ne_of_gt ht
  have harg : 2 * Kstar K2 = -Real.log (Real.tanh K2) := by
    rw [Kstar]
    ring
  have hproduct :
      Real.exp (-Real.log (Real.tanh K2)) * Real.exp (Real.log (Real.tanh K2)) = 1 := by
    calc
      Real.exp (-Real.log (Real.tanh K2)) * Real.exp (Real.log (Real.tanh K2)) =
          Real.exp (-Real.log (Real.tanh K2) + Real.log (Real.tanh K2)) := by
            rw [Real.exp_add]
      _ = Real.exp 0 := by ring
      _ = 1 := Real.exp_zero
  have hproductTanh : Real.exp (-Real.log (Real.tanh K2)) * Real.tanh K2 = 1 := by
    calc
      Real.exp (-Real.log (Real.tanh K2)) * Real.tanh K2 =
          Real.exp (-Real.log (Real.tanh K2)) * Real.exp (Real.log (Real.tanh K2)) := by
            exact congrArg (fun y => Real.exp (-Real.log (Real.tanh K2)) * y)
              (Real.exp_log ht).symm
      _ = 1 := hproduct
  calc
    Real.exp (2 * Kstar K2) = Real.exp (-Real.log (Real.tanh K2)) := by rw [harg]
    _ = 1 / Real.tanh K2 := by
      apply (eq_div_iff ht0).2
      exact hproductTanh

/-- `exp(-2K₂*)=tanh K₂`。人手証明の二つめの計算列。 -/
theorem exp_neg_two_Kstar_eq_tanh {K2 : ℝ} (hK2 : 0 < K2) :
    Real.exp (-2 * Kstar K2) = Real.tanh K2 := by
  have ht : 0 < Real.tanh K2 := tanh_pos hK2
  have harg : -2 * Kstar K2 = Real.log (Real.tanh K2) := by
    rw [Kstar]
    ring
  calc
    Real.exp (-2 * Kstar K2) = Real.exp (Real.log (Real.tanh K2)) := by
      rw [harg]
    _ = Real.tanh K2 := Real.exp_log ht

/-- `sinh(2K₂*)=(1/tanh K₂-tanh K₂)/2`。人手証明の三つめの計算列。 -/
theorem sinh_two_Kstar_eq_half_inv_tanh_sub_tanh {K2 : ℝ} (hK2 : 0 < K2) :
    Real.sinh (2 * Kstar K2) =
      (1 / 2 : ℝ) * (1 / Real.tanh K2 - Real.tanh K2) := by
  have hneg : -(2 * Kstar K2) = -2 * Kstar K2 := by ring
  calc
    Real.sinh (2 * Kstar K2) =
        (Real.exp (2 * Kstar K2) - Real.exp (-(2 * Kstar K2))) / 2 := by
          rw [Real.sinh_eq]
    _ = (1 / Real.tanh K2 - Real.exp (-(2 * Kstar K2))) / 2 := by
      rw [exp_two_Kstar_eq_inv_tanh hK2]
    _ = (1 / Real.tanh K2 - Real.tanh K2) / 2 := by
      rw [hneg, exp_neg_two_Kstar_eq_tanh hK2]
    _ = (1 / 2 : ℝ) * (1 / Real.tanh K2 - Real.tanh K2) := by ring

/-- `sinh(2K₂)=2 sinh(K₂) cosh(K₂)`。人手証明の指数関数による導出。 -/
theorem sinh_two_eq_two_sinh_mul_cosh (K2 : ℝ) :
    Real.sinh (2 * K2) = 2 * Real.sinh K2 * Real.cosh K2 := by
  have hexpSq : Real.exp K2 ^ 2 = Real.exp (2 * K2) := by
    calc
      Real.exp K2 ^ 2 = Real.exp K2 * Real.exp K2 := by ring
      _ = Real.exp (K2 + K2) := by rw [Real.exp_add]
      _ = Real.exp (2 * K2) := by ring
  have hexpNegSq : Real.exp (-K2) ^ 2 = Real.exp (-(2 * K2)) := by
    calc
      Real.exp (-K2) ^ 2 = Real.exp (-K2) * Real.exp (-K2) := by ring
      _ = Real.exp ((-K2) + (-K2)) := by rw [Real.exp_add]
      _ = Real.exp (-(2 * K2)) := by ring
  symm
  calc
    2 * Real.sinh K2 * Real.cosh K2 =
        2 * ((Real.exp K2 - Real.exp (-K2)) / 2) *
          ((Real.exp K2 + Real.exp (-K2)) / 2) := by
            rw [Real.sinh_eq, Real.cosh_eq]
    _ = ((Real.exp K2 - Real.exp (-K2)) *
          (Real.exp K2 + Real.exp (-K2))) / 2 := by ring
    _ = (Real.exp K2 ^ 2 - Real.exp (-K2) ^ 2) / 2 := by ring
    _ = (Real.exp (2 * K2) - Real.exp (-(2 * K2))) / 2 := by
      rw [hexpSq, hexpNegSq]
    _ = Real.sinh (2 * K2) := by rw [Real.sinh_eq]

/-- **原文 `second_dual_coupling_relation`**:
`K₂>0` かつ `K₂*=-log(tanh K₂)/2` なら
`sinh(2K₂)sinh(2K₂*)=1`。 -/
theorem second_dual_coupling_relation {K2 : ℝ} (hK2 : 0 < K2) :
    Real.sinh (2 * K2) * Real.sinh (2 * Kstar K2) = 1 := by
  have hs : Real.sinh K2 ≠ 0 := ne_of_gt (Real.sinh_pos_iff.mpr hK2)
  have hc : Real.cosh K2 ≠ 0 := ne_of_gt (Real.cosh_pos K2)
  have hsc : Real.sinh K2 * Real.cosh K2 ≠ 0 := mul_ne_zero hs hc
  calc
    Real.sinh (2 * K2) * Real.sinh (2 * Kstar K2) =
        (2 * Real.sinh K2 * Real.cosh K2) * Real.sinh (2 * Kstar K2) := by
          rw [sinh_two_eq_two_sinh_mul_cosh]
    _ = (2 * Real.sinh K2 * Real.cosh K2) *
        ((1 / 2 : ℝ) * (1 / Real.tanh K2 - Real.tanh K2)) := by
          rw [sinh_two_Kstar_eq_half_inv_tanh_sub_tanh hK2]
    _ = Real.sinh K2 * Real.cosh K2 *
        (1 / Real.tanh K2 - Real.tanh K2) := by ring
    _ = Real.sinh K2 * Real.cosh K2 *
        (1 / (Real.sinh K2 / Real.cosh K2) -
          Real.sinh K2 / Real.cosh K2) := by
            rw [Real.tanh_eq_sinh_div_cosh]
    _ = Real.sinh K2 * Real.cosh K2 *
        (Real.cosh K2 / Real.sinh K2 -
          Real.sinh K2 / Real.cosh K2) := by
            congr 1
            field_simp
    _ = Real.sinh K2 * Real.cosh K2 *
        ((Real.cosh K2 ^ 2 - Real.sinh K2 ^ 2) /
          (Real.sinh K2 * Real.cosh K2)) := by
            congr 1
            field_simp
    _ = (Real.sinh K2 * Real.cosh K2 *
        (Real.cosh K2 ^ 2 - Real.sinh K2 ^ 2)) /
          (Real.sinh K2 * Real.cosh K2) := by
            rw [mul_div_assoc]
    _ = Real.cosh K2 ^ 2 - Real.sinh K2 ^ 2 := by
      exact mul_div_cancel_left₀
        (Real.cosh K2 ^ 2 - Real.sinh K2 ^ 2) hsc
    _ = 1 := Real.cosh_sq_sub_sinh_sq K2

end Ising2D
