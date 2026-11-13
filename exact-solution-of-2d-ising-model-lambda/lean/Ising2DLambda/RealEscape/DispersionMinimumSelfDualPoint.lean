/-
章「実数体への脱出と熱力学極限」の「分散因子の最小値は自己双対点で零になる」
（`claim_dispersion_minimum_self_dual_point`）の具体版。

  人手証明                                                          このファイル
  B_ξ(θ₁,θ₂) := (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂)、r := ρ(ξ)        `dispersionMinimumArgument`
  p := 1 − 2ξ − ξξ ∈ R、c := 2r(1−r²)                                 `dispersion_minimum_self_dual_point` の `p`・`c`
  第一の事実 0 < r < 1（ρ(0)=0、ρ(1)=1、狭義順序の保存）             `cutRealization_pos_lt_one`
  第二の事実 c > 0（c = 2r((1−r)(1+r))）                              `dispersionMinimum_coefficient_pos`
  第三の事実 ρ(p) = 1−2r−r² の七行                                    `cutRealization_selfDualQuadratic`
  第四の事実 s ∈ R、s ≠ 0、−1−s <_R −2、−2 <_R 0、−1−s <_R 0          `sqrtTwo_ne_zero`・`negOneSubSqrtTwo_lt_zero`
  第五の事実 ξ ≠ −1−s（0 <_R 0 から v·v = 0）                         `ne_negOneSubSqrtTwo_of_pos`
  B − (1−2r−r²)² の六行                                               `dispersionMinimumArgument_sub_gap`
  B(0,0) の四行                                                       `dispersionMinimumArgument_zero_zero`
  最小値（下界と (0,0) での達成）                                      `dispersion_minimum_self_dual_point` の第一・第二成分
  零条件の七行の同値                                                  `dispersionMinimumGap_eq_zero_iff`
  1 + x_c = s ≠ 0 と KW(x_c) = x_c                                    `criticalPoint_kwSelfDual`

脱出理由: 実数の角と余弦（`Real.cos`。使う性質は `cos θ ≤ 1` と `cos 0 = 1` だけ）、
実現写像 `realAlgebraicCutRealization`。零点の同定は実閉部分体の代数と順序へ戻す。
必要十分版の定理・定義は使わない。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder
import Ising2DLambda.FisherZero.RealAlgebraicOrderTransitive
import Ising2DLambda.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.FisherZero.KwSelfDualQuadraticEquivalence
import Ising2DLambda.CriticalExponent.CriticalPointPositive

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- `B_ξ(θ₁,θ₂) := (1+r²)² − 2r(1−r²)(cos θ₁ + cos θ₂)`（`r := ρ_{R→ℝ}(ξ)` を引数に取る）。 -/
noncomputable def dispersionMinimumArgument (r θ₁ θ₂ : ℝ) : ℝ :=
  (1 + r ^ 2) ^ 2 - 2 * r * (1 - r ^ 2) * (Real.cos θ₁ + Real.cos θ₂)

/-- `[0,2π]²` 上の `B_ξ` の値の集合。 -/
def dispersionMinimumValues (r : ℝ) : Set ℝ :=
  {y | ∃ θ₁ θ₂ : ℝ, θ₁ ∈ Set.Icc 0 (2 * Real.pi) ∧ θ₂ ∈ Set.Icc 0 (2 * Real.pi) ∧
    y = dispersionMinimumArgument r θ₁ θ₂}

/-- 第一の事実: `0 <_R ξ <_R 1` なら `0 < ρ(ξ) < 1`。 -/
theorem cutRealization_pos_lt_one (data : RealClosedSubfieldData) {ξ : data.carrier}
    (hξ0 : realAlgebraicLt data 0 ξ) (hξ1 : realAlgebraicLt data ξ 1) :
    0 < realAlgebraicCutRealization data ξ ∧ realAlgebraicCutRealization data ξ < 1 := by
  constructor
  · calc (0 : ℝ)
        = realAlgebraicCutRealization data 0 := (cutRealization_zero data).symm
      _ < realAlgebraicCutRealization data ξ := cutRealization_preserves_strict_order data hξ0
  · calc realAlgebraicCutRealization data ξ
        < realAlgebraicCutRealization data 1 := cutRealization_preserves_strict_order data hξ1
      _ = 1 := cutRealization_one data

/-- 第二の事実: `0 < r < 1` なら `c = 2r(1−r²) > 0`。 -/
theorem dispersionMinimum_coefficient_pos {r : ℝ} (hr0 : 0 < r) (hr1 : r < 1) :
    0 < 2 * r * (1 - r ^ 2) := by
  calc (0 : ℝ)
      < 2 * r * ((1 - r) * (1 + r)) :=
        mul_pos (mul_pos two_pos hr0) (mul_pos (by linarith) (by linarith))
    _ = 2 * r * (1 - r ^ 2) := by ring

/-- `ρ(2) = 2`（有理数 `2` に `claim_cut_realization_agrees_on_rationals` を当てる）。 -/
theorem cutRealization_two (data : RealClosedSubfieldData) :
    realAlgebraicCutRealization data 2 = 2 := by
  have h : (2 : data.carrier) = realClosedRat data 2 := by
    rw [realClosedRat_eq_cast]; norm_num
  rw [h, cutRealization_agrees_on_rationals]
  norm_num

section
variable (data : RealClosedSubfieldData)
local notation "ρ" => realAlgebraicCutRealization data

/-- `(2 : R)` の `Qbar` での値は `2`。 -/
theorem realClosed_two_val : ((2 : data.carrier) : Qbar) = 2 := by
  have h : (2 : data.carrier) = 1 + 1 := by norm_num
  rw [h]; push_cast; norm_num

/-- 第三の事実: `ρ(1 − 2ξ − ξξ) = 1 − 2r − r²`（本文の七行。`r := ρ(ξ)`）。 -/
theorem cutRealization_selfDualQuadratic (ξ : data.carrier) :
    ρ (1 - 2 * ξ - ξ * ξ) = 1 - 2 * ρ ξ - ρ ξ ^ 2 := by
  calc ρ (1 - 2 * ξ - ξ * ξ)
      = ρ (1 - 2 * ξ - ξ * ξ) + (2 * ρ ξ + ρ ξ * ρ ξ) - (2 * ρ ξ + ρ ξ * ρ ξ) := by ring
    _ = ρ (1 - 2 * ξ - ξ * ξ) + (ρ 2 * ρ ξ + ρ ξ * ρ ξ) - (2 * ρ ξ + ρ ξ * ρ ξ) := by
        rw [cutRealization_two]
    _ = ρ (1 - 2 * ξ - ξ * ξ) + (ρ (2 * ξ) + ρ (ξ * ξ)) - (2 * ρ ξ + ρ ξ * ρ ξ) := by
        rw [cutRealization_preserves_multiplication, cutRealization_preserves_multiplication]
    _ = ρ (1 - 2 * ξ - ξ * ξ) + ρ (2 * ξ + ξ * ξ) - (2 * ρ ξ + ρ ξ * ρ ξ) := by
        rw [cutRealization_preserves_addition data (2 * ξ) (ξ * ξ)]
    _ = ρ ((1 - 2 * ξ - ξ * ξ) + (2 * ξ + ξ * ξ)) - (2 * ρ ξ + ρ ξ * ρ ξ) := by
        rw [cutRealization_preserves_addition data (1 - 2 * ξ - ξ * ξ) (2 * ξ + ξ * ξ)]
    _ = ρ 1 - (2 * ρ ξ + ρ ξ * ρ ξ) := by
        rw [show (1 - 2 * ξ - ξ * ξ) + (2 * ξ + ξ * ξ) = (1 : data.carrier) by ring]
    _ = 1 - 2 * ρ ξ - ρ ξ ^ 2 := by rw [cutRealization_one]; ring

/-- 零条件の七行の同値: `(1−2r−r²)² = 0 ↔ ξ = x_c`。 -/
theorem dispersionMinimumGap_eq_zero_iff {s : Qbar} (hs : s * s = 2) {ξ t : data.carrier}
    (htval : (t : Qbar) = s) (hne : ξ ≠ -1 - t) :
    (1 - 2 * ρ ξ - ρ ξ ^ 2) ^ 2 = 0 ↔ ξ = criticalPointRealClosed data s hs := by
  -- `(ξ:Qbar) = −1 − s ↔ ξ = −1 − t`（`t` は `s` の `R` での元）。
  have hcastNeg : (ξ : Qbar) = -1 - s ↔ ξ = -1 - t := by
    constructor
    · intro h; apply Subtype.ext; push_cast; rw [h, htval]
    · intro h; rw [h]; push_cast; rw [htval]
  calc (1 - 2 * ρ ξ - ρ ξ ^ 2) ^ 2 = 0
      ↔ 1 - 2 * ρ ξ - ρ ξ ^ 2 = 0 := pow_eq_zero_iff two_ne_zero
    _ ↔ ρ (1 - 2 * ξ - ξ * ξ) = ρ 0 := by
        rw [cutRealization_selfDualQuadratic, cutRealization_zero]
    _ ↔ 1 - 2 * ξ - ξ * ξ = 0 := (cutRealization_injective data).eq_iff
    _ ↔ (ξ : Qbar) ^ 2 + 2 * (ξ : Qbar) - 1 = 0 := by
        constructor
        · intro h
          have hq : ((1 - 2 * ξ - ξ * ξ : data.carrier) : Qbar) = 0 := by rw [h]; rfl
          push_cast at hq; rw [realClosed_two_val] at hq
          linear_combination -hq
        · intro h
          apply Subtype.ext
          push_cast; rw [realClosed_two_val]
          linear_combination -h
    _ ↔ ((ξ : Qbar) = -1 + s ∨ (ξ : Qbar) = -1 - s) := selfDualQuadratic_roots hs
    _ ↔ (ξ : Qbar) = -1 + s := by
        constructor
        · rintro (h | h)
          · exact h
          · exact absurd (hcastNeg.mp h) hne
        · exact Or.inl
    _ ↔ ξ = criticalPointRealClosed data s hs := by
        rw [← criticalPointRealClosed_val data s hs]
        exact Subtype.ext_iff.symm

end

/-- 第四の事実の前半: `s·s = 2` を満たす `R` の元 `t` は零でない。 -/
theorem sqrtTwo_ne_zero (data : RealClosedSubfieldData) {t : data.carrier}
    (ht : t * t = 2) : t ≠ 0 := by
  intro h0
  have h2 : (2 : data.carrier) = 0 :=
    calc (2 : data.carrier) = t * t := ht.symm
      _ = 0 * 0 := by rw [h0]
      _ = 0 := zero_mul 0
  -- ℚ ⊂ Qbar で 2 ≠ 0。
  have h2Q : ((2 : data.carrier) : Qbar) = 0 := by rw [h2]; rfl
  rw [realClosed_two_val] at h2Q
  exact two_ne_zero h2Q

/-- 第四の事実の後半: `−1 − t <_R 0`（`−1 − t <_R −2` と `−2 <_R 0` に推移律を当てる）。 -/
theorem negOneSubSqrtTwo_lt_zero (data : RealClosedSubfieldData) {t xc : data.carrier}
    (ht : t * t = 2) (hxc : xc = -1 + t) (hpos : realAlgebraicLt data 0 xc) :
    realAlgebraicLt data (-1 - t) 0 := by
  obtain ⟨w, hw0, hw⟩ := hpos
  have h1 : realAlgebraicLt data (-1 - t) (-2) := by
    refine ⟨w, hw0, ?_⟩
    calc (-2 : data.carrier) - (-1 - t)
        = -1 + t := by ring
      _ = xc := hxc.symm
      _ = xc - 0 := (sub_zero xc).symm
      _ = w * w := hw
  have h2 : realAlgebraicLt data (-2) 0 := by
    refine ⟨t, sqrtTwo_ne_zero data ht, ?_⟩
    calc (0 : data.carrier) - (-2)
        = 2 := by ring
      _ = t * t := ht.symm
  exact realAlgebraicLt_trans data _ _ _ h1 h2

/-- 第五の事実: `0 <_R ξ` かつ `−1 − t <_R 0` なら `ξ ≠ −1 − t`。 -/
theorem ne_negOneSubSqrtTwo_of_pos (data : RealClosedSubfieldData) {ξ t : data.carrier}
    (hξ0 : realAlgebraicLt data 0 ξ) (hneg : realAlgebraicLt data (-1 - t) 0) :
    ξ ≠ -1 - t := by
  intro hξ
  have hξneg : realAlgebraicLt data ξ 0 := hξ ▸ hneg
  obtain ⟨v, hv0, hv⟩ := realAlgebraicLt_trans data 0 ξ 0 hξ0 hξneg
  have hvv : v * v = 0 :=
    calc v * v = 0 - 0 := hv.symm
      _ = 0 := sub_self 0
  -- `claim_qbar_no_zero_divisors`: 零でない元の平方は零でない。
  exact hv0 (mul_self_eq_zero.mp hvv)

/-- 本文の六行: `B − (1−2r−r²)² = c((1−cos θ₁)+(1−cos θ₂))`。 -/
theorem dispersionMinimumArgument_sub_gap (r θ₁ θ₂ : ℝ) :
    dispersionMinimumArgument r θ₁ θ₂ - (1 - 2 * r - r ^ 2) ^ 2 =
      2 * r * (1 - r ^ 2) * ((1 - Real.cos θ₁) + (1 - Real.cos θ₂)) := by
  set c : ℝ := 2 * r * (1 - r ^ 2)
  set c₁ : ℝ := Real.cos θ₁
  set c₂ : ℝ := Real.cos θ₂
  calc dispersionMinimumArgument r θ₁ θ₂ - (1 - 2 * r - r ^ 2) ^ 2
      = (1 + r ^ 2) ^ 2 - c * (c₁ + c₂) - (1 - 2 * r - r ^ 2) ^ 2 := rfl
    _ = ((1 + r ^ 2) - (1 - 2 * r - r ^ 2)) * ((1 + r ^ 2) + (1 - 2 * r - r ^ 2))
          - c * (c₁ + c₂) := by ring
    _ = (2 * r + 2 * r ^ 2) * (2 - 2 * r) - c * (c₁ + c₂) := by ring
    _ = 4 * r * (1 - r ^ 2) - c * (c₁ + c₂) := by ring
    _ = c * ((1 - c₁) + (1 - c₂)) := by simp only [c]; ring

/-- 本文の四行: `B(0,0) = (1−2r−r²)²`。 -/
theorem dispersionMinimumArgument_zero_zero (r : ℝ) :
    dispersionMinimumArgument r 0 0 = (1 - 2 * r - r ^ 2) ^ 2 := by
  calc dispersionMinimumArgument r 0 0
      = (dispersionMinimumArgument r 0 0 - (1 - 2 * r - r ^ 2) ^ 2) + (1 - 2 * r - r ^ 2) ^ 2 := by
        ring
    _ = 2 * r * (1 - r ^ 2) * ((1 - Real.cos 0) + (1 - Real.cos 0)) + (1 - 2 * r - r ^ 2) ^ 2 := by
        rw [dispersionMinimumArgument_sub_gap]
    _ = 2 * r * (1 - r ^ 2) * ((1 - 1) + (1 - 1)) + (1 - 2 * r - r ^ 2) ^ 2 := by
        rw [Real.cos_zero]
    _ = (1 - 2 * r - r ^ 2) ^ 2 := by ring

/-- 双対性: `1 + x_c = s ≠ 0` と `claim_kw_self_dual_quadratic_equivalence` から `KW(x_c) = x_c`。 -/
theorem criticalPoint_kwSelfDual {s : Qbar} (hs : s * s = 2) :
    kwDualTransform (-1 + s) = -1 + s := by
  have hs0 : s ≠ 0 := by
    intro h0
    have : (2 : Qbar) = 0 := by rw [← hs, h0, zero_mul]
    exact two_ne_zero this
  have hDomain : 1 + (-1 + s) ≠ 0 := by
    calc 1 + (-1 + s) = s := by ring
      _ ≠ 0 := hs0
  have hquad : (-1 + s) ^ 2 + 2 * (-1 + s) - 1 = 0 :=
    (selfDualQuadratic_roots hs).mpr (Or.inl rfl)
  exact (kwSelfDual_quadratic_equivalence hDomain).mpr hquad

/-- `claim_dispersion_minimum_self_dual_point` の具体版。
`0 <_R ξ <_R 1` のとき、`[0,2π]²` 上の `B_ξ` の最小値は `(1−2r−r²)²` で角 `(0,0)` で達成され、
最小値が零であることと `ξ = x_c` は同値で、`x_c` では `KW(x_c) = x_c`。 -/
theorem dispersion_minimum_self_dual_point {s : Qbar} (data : RealClosedSubfieldSqrtTwoData s)
    (hs : s * s = 2) (ξ : data.carrier)
    (hξ0 : realAlgebraicLt data.toRealClosedSubfieldData 0 ξ)
    (hξ1 : realAlgebraicLt data.toRealClosedSubfieldData ξ 1) :
    IsLeast (dispersionMinimumValues (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ))
        ((1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2) ∧
      dispersionMinimumArgument (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ) 0 0 =
        (1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2 ∧
      ((1 - 2 * realAlgebraicCutRealization data.toRealClosedSubfieldData ξ
          - realAlgebraicCutRealization data.toRealClosedSubfieldData ξ ^ 2) ^ 2 = 0 ↔
        ξ = criticalPointRealClosed data.toRealClosedSubfieldData s hs) ∧
      kwDualTransform ((criticalPointRealClosed data.toRealClosedSubfieldData s hs : _) : Qbar) =
        ((criticalPointRealClosed data.toRealClosedSubfieldData s hs : _) : Qbar) := by
  -- 第一の事実・第二の事実。
  obtain ⟨hr0, hr1⟩ := cutRealization_pos_lt_one data.toRealClosedSubfieldData hξ0 hξ1
  have hc := dispersionMinimum_coefficient_pos hr0 hr1
  -- 第四の事実: s ∈ R（`claim_critical_point_mem_real_closed`）、−1 − s <_R 0。
  obtain ⟨t, htval⟩ := sqrtTwo_mem_realClosed data.toRealClosedSubfieldData s hs
  have ht : t * t = 2 := by
    apply Subtype.ext; push_cast; rw [htval]; exact hs
  have hxc : criticalPointRealClosed data.toRealClosedSubfieldData s hs = -1 + t := by
    apply Subtype.ext; rw [criticalPointRealClosed_val]; push_cast; rw [htval]
  have hneg := negOneSubSqrtTwo_lt_zero data.toRealClosedSubfieldData ht hxc (criticalPoint_positive data hs)
  -- 第五の事実。
  have hne := ne_negOneSubSqrtTwo_of_pos data.toRealClosedSubfieldData hξ0 hneg
  -- 最小値: 下界と (0,0) での達成。
  have hlow : ∀ (r : ℝ), 0 < 2 * r * (1 - r ^ 2) →
      ∀ θ₁ θ₂ : ℝ, (1 - 2 * r - r ^ 2) ^ 2 ≤ dispersionMinimumArgument r θ₁ θ₂ := by
    intro r hc θ₁ θ₂
    have hcos : 0 ≤ (1 - Real.cos θ₁) + (1 - Real.cos θ₂) :=
      add_nonneg (sub_nonneg.2 (Real.cos_le_one θ₁)) (sub_nonneg.2 (Real.cos_le_one θ₂))
    have hdiff : 0 ≤ dispersionMinimumArgument r θ₁ θ₂ - (1 - 2 * r - r ^ 2) ^ 2 := by
      rw [dispersionMinimumArgument_sub_gap]; exact mul_nonneg hc.le hcos
    linarith
  have hzero := dispersionMinimumArgument_zero_zero (realAlgebraicCutRealization data.toRealClosedSubfieldData ξ)
  have h0mem : (0 : ℝ) ∈ Set.Icc 0 (2 * Real.pi) := ⟨le_rfl, Real.two_pi_pos.le⟩
  refine ⟨⟨⟨0, 0, h0mem, h0mem, hzero.symm⟩, ?_⟩, hzero,
    dispersionMinimumGap_eq_zero_iff data.toRealClosedSubfieldData hs htval hne, ?_⟩
  · rintro y ⟨θ₁, θ₂, -, -, rfl⟩
    exact hlow _ hc θ₁ θ₂
  · rw [criticalPointRealClosed_val]
    exact criticalPoint_kwSelfDual hs

end Ising2DLambda.RealEscape
