/-
# 定数 `c` の決定（偶セクター）（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`constant_c_value_even_sector`（`evenEigen_009_claim_...`）。

**抽象版**は `Ising2D/Abstract/ConstantC.lean` の `Abstract.const_eq_of_trace_ratio`
（体 ℂ の中の 4 つの等式と 3 つの正値性だけ。行列もトレースも出てこない）。
本ファイルの `constant_c_value_even_sector` は**その特殊化として導出する**。

## 他章への依存（仮定として受け取るもの）

章 016 の `V_plus_eq_c_check_Vprime`（「ある `c ∈ ℂ^×` が存在して `V^{(+)} = c V̌'`」）は
**並行して形式化中**なので、仮定 `hVeq : VPlus … = c • F.Vprime g` として受け取る。
本章の主張はこの `c` の値を決めるものである。

## 章 009 との関係

章 009 の `constant_c_value`（`Ising2D/Part009/Claim017_ConstantC.lean`）と
本ファイルは、**同じ抽象版 `Abstract.const_eq_of_trace_ratio` の別の特殊化**である。
違うのは
- 符号 `η`（章 009 は一般の `η`、本章は `(+)` すなわち `η = -1`）、
- `p = tr(V̌')` の値（章 009 は前因子 `2^{M-m}` つき、本章は前因子なし）
の 2 点だけで、`τ` を経由する筋（`tr(V)/tr(V^{-1}) = c^2`、符号反転共役 `U` による
`tr(exp(-S_1)exp(-S_2)) = τ`、正定値性による符号確定）はまったく同じである。
符号反転共役 `Ising2D.Uflip_conj_S1`（章 009 `sign_flip_conjugation`）は
`η` について複号同順の形で証明されているので、`η = -1` を代入するだけでよい。
-/
import Ising2D.Part017.Claim008_VPlusPositiveDefinite
import Ising2D.Abstract.ConstantC

namespace Ising2D

open Matrix
open scoped ComplexOrder

section ConstantCEven

variable {M : ℕ}

/-- **原文 `constant_c_value_even_sector` Step 1**: `tr(V^{(+)}) = (2s_2)^{M/2} τ`。 -/
theorem trace_VPlus (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (VPlus M s2 K1 K2star).trace
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) * tauTrace M K1 (-1) K2star :=
  trace_Vmat K1 (-1) s2 K2star

/-- **原文 `constant_c_value_even_sector` Step 1（後半）＋ Step 2**:
`tr((V^{(+)})^{-1}) = (2s_2)^{-M/2} τ`（符号反転共役で `τ` に戻る）。 -/
theorem trace_VPlusInv (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) :
    (VPlusInv M K1 s2 K2star).trace
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ))⁻¹ * tauTrace M K1 (-1) K2star :=
  trace_VmatInv K1 (-1) s2 K2star

/-- `V^{(+)} = c V̌'` から `(V^{(+)})^{-1} = c⁻¹ (V̌')^{-1}`（逆元の一意性）。 -/
theorem VPlusInv_eq (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ} (hs2 : 0 < s2) (hcne : c ≠ 0)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    VPlusInv M K1 s2 K2star = c⁻¹ • F.Vprime (fun i => -(g i)) := by
  have hleft := VPlusInv_mul_VPlus (M := M) (K1 := K1) (K2star := K2star) hs2
  have hright : VPlus M s2 K1 K2star * (c⁻¹ • F.Vprime (fun i => -(g i))) = 1 := by
    rw [hVeq, smul_mul_smul_comm, F.Vprime_mul_Vprime_neg, mul_inv_cancel₀ hcne, one_smul]
  calc VPlusInv M K1 s2 K2star
      = VPlusInv M K1 s2 K2star
          * (VPlus M s2 K1 K2star * (c⁻¹ • F.Vprime (fun i => -(g i)))) := by
        rw [hright, mul_one]
    _ = (VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star)
          * (c⁻¹ • F.Vprime (fun i => -(g i))) := by noncomm_ring
    _ = c⁻¹ • F.Vprime (fun i => -(g i)) := by rw [hleft, one_mul]

/-- **原文 `constant_c_value_even_sector`**: `V^{(+)} = c V̌'` の `c` は `(2 sinh 2K_2)^{M/2}`。

抽象版 `Abstract.const_eq_of_trace_ratio` の特殊化として導出する。 -/
theorem constant_c_value_even_sector (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    c = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ)) := by
  classical
  set a : ℝ := ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) with ha
  have hapos : 0 < a := Real.rpow_pos_of_pos (by linarith) _
  obtain ⟨p, hppos, hP⟩ := F.trace_Vprime_pos g
  have hVpos : 0 < (VPlus M s2 K1 K2star).trace := trace_VPlus_pos hK1 hK2 hs2
  have hcne : c ≠ 0 := by
    intro h0
    rw [h0, zero_smul] at hVeq
    rw [hVeq, Matrix.trace_zero] at hVpos
    exact lt_irrefl 0 hVpos
  have h1 : (VPlus M s2 K1 K2star).trace = c * ((p : ℝ) : ℂ) := by
    rw [hVeq, Matrix.trace_smul, smul_eq_mul, hP]
  have h2 : (VPlusInv M K1 s2 K2star).trace = c⁻¹ * ((p : ℝ) : ℂ) := by
    rw [VPlusInv_eq F g hs2 hcne hVeq, Matrix.trace_smul, smul_eq_mul, F.trace_Vprime_inv g, hP]
  exact Abstract.const_eq_of_trace_ratio hapos hppos h1 h2
    (trace_VPlus K1 s2 K2star) (trace_VPlusInv K1 s2 K2star) hVpos

end ConstantCEven

end Ising2D
