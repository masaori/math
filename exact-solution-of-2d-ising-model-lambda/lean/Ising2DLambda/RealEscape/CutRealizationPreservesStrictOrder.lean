/-
人手証明 `claim_cut_realization_preserves_strict_order`（下切断による実現写像は狭義順序を保ち単射である）の具体版。

  人手証明                                                         このファイル
  有理数の 1 の所属は R の 1                                          `realClosedRat_one`
  ρ(1) = ι(1) = 1（有理数をそのまま実現する）                         `cutRealization_one`
  0 <_R d なら 0 ∈ C_d、上限は上界なので ι(0) ≤ ρ(d)                   `cutRealization_nonneg_of_pos`
  0 <_R d なら d ≠ 0（三分法の排他性）、R は部分体なので d⁻¹ ∈ R、
  ρ(d)ρ(d⁻¹) = ρ(dd⁻¹) = ρ(1) = 1 で ρ(d) ≠ 0、ゆえに 0 < ρ(d)        `cutRealization_pos_of_pos`
  d := b − a、0 <_R d（狭義順序の定義）、
  ρ(b) = ρ(a + d) = ρ(a) + ρ(d) > ρ(a)                                `cutRealization_preserves_strict_order`
  a ≠ b なら三分法で a <_R b か b <_R a、像は異なる                   `cutRealization_injective`
  四則・単位元・狭義順序の保存をまとめて実現データを作る              `cutRealization_realClosedRealization`

必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.CutRealizationPreservesMultiplication
import Ising2DLambda.CriticalExponent.RealClosedRealization

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- 有理数の 1 の所属は `R` の 1。 -/
theorem realClosedRat_one (data : RealClosedSubfieldData) :
    realClosedRat data 1 = 1 := by
  rw [realClosedRat_eq_cast]
  simp

/-- `ρ(1) = ι(1) = 1`（`claim_cut_realization_agrees_on_rationals`）。 -/
theorem cutRealization_one (data : RealClosedSubfieldData) :
    realAlgebraicCutRealization data 1 = 1 := by
  rw [← realClosedRat_one, cutRealization_agrees_on_rationals]
  exact Rat.cast_one

/-- `0 <_R d` なら `0 ∈ C_d` で、上限は上界なので `ι(0) ≤ ρ(d)`。 -/
theorem cutRealization_nonneg_of_pos (data : RealClosedSubfieldData) {d : data.carrier}
    (hd : realAlgebraicLt data 0 d) : 0 ≤ realAlgebraicCutRealization data d := by
  -- ρ(d) は下切断の像の最小上界（`claim_real_algebraic_lower_cut_has_supremum`）。
  have hlub := (realAlgebraic_lower_cut_has_supremum data d).2.2
  have hmem : ((0 : ℚ) : ℝ) ∈ realAlgebraicLowerCutImage data d :=
    ⟨0, by rw [realClosedRat_zero]; exact hd, rfl⟩
  have h := hlub.1 hmem
  rwa [Rat.cast_zero] at h

/-- `0 <_R d` なら `0 < ρ(d)`。 -/
theorem cutRealization_pos_of_pos (data : RealClosedSubfieldData) {d : data.carrier}
    (hd : realAlgebraicLt data 0 d) : 0 < realAlgebraicCutRealization data d := by
  -- 三分法の排他性: 0 <_R d と 0 = d は同時に成り立たない。
  have hd0 : d ≠ 0 := fun h =>
    (realAlgebraicLt_trichotomy data 0 d).2.1 ⟨hd, h.symm⟩
  -- R は部分体なので d⁻¹ ∈ R、d d⁻¹ = 1。
  have hinv : d * d⁻¹ = 1 := mul_inv_cancel₀ hd0
  have hprod : realAlgebraicCutRealization data d * realAlgebraicCutRealization data d⁻¹ = 1 :=
    calc realAlgebraicCutRealization data d * realAlgebraicCutRealization data d⁻¹
        = realAlgebraicCutRealization data (d * d⁻¹) :=
          (cutRealization_preserves_multiplication data d d⁻¹).symm
      _ = realAlgebraicCutRealization data 1 := by rw [hinv]
      _ = 1 := cutRealization_one data
  -- ρ(d) = 0 なら左辺は 0 で 1 に等しくない。
  have hne : realAlgebraicCutRealization data d ≠ 0 := by
    intro h0
    rw [h0, zero_mul] at hprod
    exact zero_ne_one hprod
  exact lt_of_le_of_ne (cutRealization_nonneg_of_pos data hd) hne.symm

/-- `claim_cut_realization_preserves_strict_order` の具体版（前半）: `a <_R b` なら `ρ(a) < ρ(b)`。 -/
theorem cutRealization_preserves_strict_order (data : RealClosedSubfieldData)
    {a b : data.carrier} (hab : realAlgebraicLt data a b) :
    realAlgebraicCutRealization data a < realAlgebraicCutRealization data b := by
  -- d := b − a、狭義順序の定義で 0 <_R d。
  have hd : realAlgebraicLt data 0 (b - a) := (realAlgebraicLt_iff_pos_sub data a b).mp hab
  have hpos := cutRealization_pos_of_pos data hd
  calc realAlgebraicCutRealization data a
      < realAlgebraicCutRealization data a + realAlgebraicCutRealization data (b - a) := by
        linarith
    _ = realAlgebraicCutRealization data (a + (b - a)) :=
        (cutRealization_preserves_addition data a (b - a)).symm
    _ = realAlgebraicCutRealization data b := by rw [add_sub_cancel]

/-- `claim_cut_realization_preserves_strict_order` の具体版（後半）: 実現写像は単射。 -/
theorem cutRealization_injective (data : RealClosedSubfieldData) :
    Function.Injective (realAlgebraicCutRealization data) := by
  intro a b hab
  -- 三分法（`claim_real_algebraic_order_trichotomy`）で a <_R b、a = b、b <_R a のいずれか。
  rcases (realAlgebraicLt_trichotomy data a b).1 with h | h | h
  · exact absurd hab (cutRealization_preserves_strict_order data h).ne
  · exact h
  · exact absurd hab (cutRealization_preserves_strict_order data h).ne'

/-- 四則・単位元・狭義順序の保存を合わせると、`def_real_closed_realization` の実現データになる。 -/
noncomputable def cutRealization_realClosedRealization (data : RealClosedSubfieldData) :
    RealClosedRealization data where
  toRingHom :=
    { toFun := realAlgebraicCutRealization data
      map_one' := cutRealization_one data
      map_mul' := cutRealization_preserves_multiplication data
      map_zero' := cutRealization_zero data
      map_add' := cutRealization_preserves_addition data }
  map_lt := fun _ _ h => cutRealization_preserves_strict_order data h

end Ising2DLambda.RealEscape
