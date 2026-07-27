/-
# 定数 `c` の決定（**抽象版**）

対応する人手証明のラベル（具体版は
`Ising2D/Part017/Claim009_ConstantCEvenSector.lean`、および
章 009 の `Ising2D/Part009/Claim017_ConstantC.lean` の `constant_c_value`）:
`constant_c_value_even_sector`。

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明 `constant_c_value_even_sector` の Step 3・Step 4 は
「`tr(V^{(+)})/tr((V^{(+)})^{-1}) = c^2`」「`= (2s_2)^M`」「正値性で符号を決める」
という 3 段だが、そこに**行列もトレースも指数関数も出てこない**。

効いているのは、体 ℂ の中の 4 つの等式

  `T = c p`,  `T' = c⁻¹ p`,  `T = a τ`,  `T' = a⁻¹ τ`

と、`a > 0`, `p > 0`, `T > 0`（実正値）だけである。ここから `c = a` が出る。

すなわち、
- `T, T'` が「トレース」であること、
- `p = tr(V̌')`, `τ = tr(exp S_1 exp S_2)` の中身、
- `V^{(+)}` が正定値行列であること（使うのは `tr(V^{(+)}) > 0` という**数**だけ）、
- `a = (2s_2)^{M/2}` の具体形（使うのは `a > 0` だけ）

はいずれも効いていない。**章 009 の `constant_c_value` と章 017 の
`constant_c_value_even_sector` は、この 1 つの補題の別の特殊化である。**

`c ≠ 0` は仮定せずに済む（`T = c p > 0` と `p ≠ 0` から従う）。
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.RCLike.Basic

namespace Ising2D.Abstract

open scoped ComplexOrder

/-- **人手証明 `constant_c_value_even_sector` Step 3〜4 の核**。

`T = c p = a τ`, `T' = c⁻¹ p = a⁻¹ τ`, `a > 0`, `p > 0`, `T > 0` ならば `c = a`。 -/
theorem const_eq_of_trace_ratio {c τ T T' : ℂ} {a p : ℝ}
    (hapos : 0 < a) (hppos : 0 < p)
    (h1 : T = c * (p : ℂ)) (h2 : T' = c⁻¹ * (p : ℂ))
    (h3 : T = (a : ℂ) * τ) (h4 : T' = ((a : ℂ))⁻¹ * τ)
    (hTpos : 0 < T) : c = (a : ℂ) := by
  have hane : ((a : ℝ) : ℂ) ≠ 0 := by
    simpa using ((RCLike.ofReal_pos (K := ℂ)).2 hapos).ne'
  have hpne : ((p : ℝ) : ℂ) ≠ 0 := by
    simpa using ((RCLike.ofReal_pos (K := ℂ)).2 hppos).ne'
  have hcne : c ≠ 0 := by
    intro h0
    rw [h0, zero_mul] at h1
    rw [h1] at hTpos
    exact lt_irrefl 0 hTpos
  have hcp : c * (p : ℂ) = (a : ℂ) * τ := h1.symm.trans h3
  have hcp' : c⁻¹ * (p : ℂ) = ((a : ℂ))⁻¹ * τ := h2.symm.trans h4
  -- `a p = c τ`
  have hq : (a : ℂ) * (p : ℂ) = c * τ := by
    have h : c * (a : ℂ) * (c⁻¹ * (p : ℂ)) = c * (a : ℂ) * (((a : ℂ))⁻¹ * τ) := by rw [hcp']
    rw [show c * (a : ℂ) * (c⁻¹ * (p : ℂ)) = (c * c⁻¹) * ((a : ℂ) * (p : ℂ)) from by ring,
      show c * (a : ℂ) * (((a : ℂ))⁻¹ * τ) = ((a : ℂ) * ((a : ℂ))⁻¹) * (c * τ) from by ring,
      mul_inv_cancel₀ hcne, mul_inv_cancel₀ hane, one_mul, one_mul] at h
    exact h
  -- `c^2 = a^2`
  have hsq0 : c ^ 2 * (p : ℂ) = ((a : ℂ)) ^ 2 * (p : ℂ) := by
    calc c ^ 2 * (p : ℂ) = c * (c * (p : ℂ)) := by ring
      _ = c * ((a : ℂ) * τ) := by rw [hcp]
      _ = (a : ℂ) * (c * τ) := by ring
      _ = (a : ℂ) * ((a : ℂ) * (p : ℂ)) := by rw [← hq]
      _ = ((a : ℂ)) ^ 2 * (p : ℂ) := by ring
  have hsq : c ^ 2 = ((a : ℂ)) ^ 2 := mul_right_cancel₀ hpne hsq0
  -- 符号の確定
  have hfac : (c - (a : ℂ)) * (c + (a : ℂ)) = 0 := by linear_combination hsq
  rcases mul_eq_zero.1 hfac with h | h
  · exact sub_eq_zero.1 h
  · exfalso
    have hc : c = -((a : ℝ) : ℂ) := by linear_combination h
    rw [hc] at h1
    rw [h1] at hTpos
    have hlt : (0 : ℂ) < (((-(a * p) : ℝ)) : ℂ) := by
      push_cast
      convert hTpos using 1
      ring
    have hneg : (0 : ℝ) < -(a * p) := (RCLike.ofReal_pos (K := ℂ)).1 hlt
    nlinarith [mul_pos hapos hppos]

end Ising2D.Abstract
