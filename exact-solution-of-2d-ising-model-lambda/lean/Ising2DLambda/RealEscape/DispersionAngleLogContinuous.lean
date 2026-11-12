/-
章「実数体への脱出と熱力学極限」の「正の分散因子から角の対数関数の連続性を得る」
（`claim_dispersion_angle_log_continuous`）の具体版。

  人手証明                                                          このファイル
  B_q(θ₁,θ₂) := (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂)、r := ι_{ℚ→ℝ}(q)   `dispersionAngleArgument`
  p := q²+2q−1 ≠ 0（p = 0 なら (q+1)(q+1) = q²+2q+1 = p+2 = 0+2 = 2）  `dispersion_angle_log_continuous` の `hp`
  0 < r < 1、r²+2r−1 = ι(p) ≠ 0、0 < (r²+2r−1)²                       同 `hr0`・`hr1`・`hpr`・`hlow`
  B − (r²+2r−1)² の五行（= 2r(1−r²)((1−cos θ₁)+(1−cos θ₂))）           `dispersionAngleArgument_sub_lower`
  2r(1−r²) > 0、1 − cos θⱼ ≥ 0 から B − (r²+2r−1)² ≥ 0                同 `hdiff`
  B = (B − (r²+2r−1)²) + (r²+2r−1)² ≥ (r²+2r−1)² > 0                  `dispersionAngleArgument_pos`
  実余弦と四則の連続性から B は ℝ² 上連続                              `dispersionAngleArgument_continuous`
  f_q := log_ℝ ∘ B は連続（`def_real_logarithm` の連続性）              `dispersionAngleLog`・`dispersion_angle_log_continuous`

脱出理由: 実対数（実数体 ℝ の位相で連続性を述べる）。`ι_{ℚ→ℝ}` は Lean の型強制 `(q : ℝ)`。
実余弦は mathlib の `Real.cos` で、使う性質は `cos θ ≤ 1` と連続性だけである。
実対数は `def_real_logarithm` の具体版 `realLog` とその連続性 `realLog_comp_continuous` を引く。
必要十分版の定理・定義は使わない。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealization
import Ising2DLambda.FisherZero.NoRationalSquareTwo

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero

/-- `B_q(θ₁,θ₂) := (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂)`（`r := ι_{ℚ→ℝ}(q)`）。 -/
noncomputable def dispersionAngleArgument (q : ℚ) (θ₁ θ₂ : ℝ) : ℝ :=
  (1 + (q : ℝ) ^ 2) ^ 2 - 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) * (Real.cos θ₁ + Real.cos θ₂)

/-- 五行: `B − (r²+2r−1)² = 2r(1−r²)((1−cos θ₁)+(1−cos θ₂))`。 -/
theorem dispersionAngleArgument_sub_lower (q : ℚ) (θ₁ θ₂ : ℝ) :
    dispersionAngleArgument q θ₁ θ₂ - ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 =
      2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) * ((1 - Real.cos θ₁) + (1 - Real.cos θ₂)) := by
  set r : ℝ := (q : ℝ)
  set c₁ : ℝ := Real.cos θ₁
  set c₂ : ℝ := Real.cos θ₂
  calc dispersionAngleArgument q θ₁ θ₂ - (r ^ 2 + 2 * r - 1) ^ 2
      = (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (c₁ + c₂) - (r ^ 2 + 2 * r - 1) ^ 2 := rfl
    _ = ((1 + r ^ 2) - (r ^ 2 + 2 * r - 1)) * ((1 + r ^ 2) + (r ^ 2 + 2 * r - 1))
          - 2 * r * (1 - r ^ 2) * (c₁ + c₂) := by ring
    _ = (2 - 2 * r) * (2 * r ^ 2 + 2 * r) - 2 * r * (1 - r ^ 2) * (c₁ + c₂) := by ring
    _ = 4 * r * (1 - r ^ 2) - 2 * r * (1 - r ^ 2) * (c₁ + c₂) := by ring
    _ = 2 * r * (1 - r ^ 2) * ((1 - c₁) + (1 - c₂)) := by ring

/-- 正値性: `0 < (r²+2r−1)²`、`(r²+2r−1)² ≤ B_q(θ₁,θ₂)`、`0 < B_q(θ₁,θ₂)`。 -/
theorem dispersionAngleArgument_pos (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (θ₁ θ₂ : ℝ) :
    0 < ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 ∧
      ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 ≤ dispersionAngleArgument q θ₁ θ₂ ∧
      0 < dispersionAngleArgument q θ₁ θ₂ := by
  -- p := q²+2q−1 ≠ 0（`claim_no_rational_square_two`）
  have hp : q ^ 2 + 2 * q - 1 ≠ 0 := by
    intro hp0
    apply noRationalSquareTwo (q + 1)
    calc (q + 1) * (q + 1) = q ^ 2 + 2 * q + 1 := by ring
      _ = (q ^ 2 + 2 * q - 1) + 2 := by ring
      _ = 0 + 2 := by rw [hp0]
      _ = 2 := by ring
  -- ι_{ℚ→ℝ} は順序と四則を保ち単射
  have hr0 : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq0
  have hr1 : (q : ℝ) < 1 := by exact_mod_cast hq1
  have hpr : (q : ℝ) ^ 2 + 2 * (q : ℝ) - 1 = ((q ^ 2 + 2 * q - 1 : ℚ) : ℝ) := by push_cast; ring
  have hpr0 : (q : ℝ) ^ 2 + 2 * (q : ℝ) - 1 ≠ 0 := by
    rw [hpr]; exact_mod_cast hp
  -- 零でない実数の平方は正
  have hlow : 0 < ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 :=
    lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 hpr0))
  -- 2r(1−r²) > 0（1 − r² = (1−r)(1+r)）
  have h1r : 0 < 1 - (q : ℝ) ^ 2 := by
    have : 1 - (q : ℝ) ^ 2 = (1 - (q : ℝ)) * (1 + (q : ℝ)) := by ring
    rw [this]
    exact mul_pos (by linarith) (by linarith)
  have hcoef : 0 < 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) := mul_pos (mul_pos two_pos hr0) h1r
  -- 1 − cos θⱼ ≥ 0（cos θⱼ ≤ 1）
  have hcos : 0 ≤ (1 - Real.cos θ₁) + (1 - Real.cos θ₂) :=
    add_nonneg (sub_nonneg.2 (Real.cos_le_one θ₁)) (sub_nonneg.2 (Real.cos_le_one θ₂))
  have hdiff : 0 ≤ dispersionAngleArgument q θ₁ θ₂ - ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 := by
    rw [dispersionAngleArgument_sub_lower]
    exact mul_nonneg hcoef.le hcos
  have hle : ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 ≤ dispersionAngleArgument q θ₁ θ₂ := by
    calc ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2
        = 0 + ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 := by ring
      _ ≤ (dispersionAngleArgument q θ₁ θ₂ - ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2)
            + ((q : ℝ) ^ 2 + 2 * (q : ℝ) - 1) ^ 2 := add_le_add_left hdiff _
      _ = dispersionAngleArgument q θ₁ θ₂ := by ring
  exact ⟨hlow, hle, lt_of_lt_of_le hlow hle⟩

/-- 実余弦の連続性と実数の四則の連続性から `B_q` は `ℝ²` 上連続。 -/
theorem dispersionAngleArgument_continuous (q : ℚ) :
    Continuous (fun θ : ℝ × ℝ => dispersionAngleArgument q θ.1 θ.2) := by
  unfold dispersionAngleArgument
  exact continuous_const.sub (continuous_const.mul
    ((Real.continuous_cos.comp continuous_fst).add (Real.continuous_cos.comp continuous_snd)))

/-- `f_q(θ₁,θ₂) := log_ℝ B_q(θ₁,θ₂)`。被対数の正値性は `dispersionAngleArgument_pos`。 -/
noncomputable def dispersionAngleLog (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) (θ : ℝ × ℝ) : ℝ :=
  realLog ⟨dispersionAngleArgument q θ.1 θ.2, (dispersionAngleArgument_pos q hq0 hq1 θ.1 θ.2).2.2⟩

/-- `claim_dispersion_angle_log_continuous` の具体版。`B_q` は全ての角で正で、`f_q` は連続である。 -/
theorem dispersion_angle_log_continuous (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    (∀ θ₁ θ₂ : ℝ, 0 < dispersionAngleArgument q θ₁ θ₂) ∧
      Continuous (dispersionAngleLog q hq0 hq1) :=
  ⟨fun θ₁ θ₂ => (dispersionAngleArgument_pos q hq0 hq1 θ₁ θ₂).2.2,
    realLog_comp_continuous (fun θ : ℝ × ℝ => dispersionAngleArgument q θ.1 θ.2)
      (fun θ => (dispersionAngleArgument_pos q hq0 hq1 θ.1 θ.2).2.2)
      (dispersionAngleArgument_continuous q)⟩

end Ising2DLambda.RealEscape
