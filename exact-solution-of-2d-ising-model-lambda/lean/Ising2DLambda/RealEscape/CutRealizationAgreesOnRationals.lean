/-
人手証明 `claim_cut_realization_agrees_on_rationals`（下切断による実現写像は有理数をそのまま実現する）の具体版。

  人手証明                                                         このファイル
  r < q なら 0 <_R q − r（正の有理数の正値性）、狭義順序の定義で r <_R q   `realAlgebraic_rat_lt_of_lt`
  r <_R q なら r < q（q < r・q = r は推移律と三分法の排他性に反する）      `realAlgebraic_lowerCut_lt_of_lt`
  二つの含意から C_q = {r ∈ Q : r < q}                                  `mem_realAlgebraicLowerCutImage_rat`
  包含写像は ≤ を保つ単射なので、狭義順序を保ち反映する                    `Rat.cast_lt`（定義 def_real_logarithm の包含写像）
  ι(q) は像の上界                                                      `realAlgebraicLowerCutImage_rat_upperBound`
  y < ι(q) なら稠密性で y < ι(r) < ι(q)、r ∈ C_q で y は上界でない（ℝ への脱出）
                                                                        `realAlgebraicLowerCutImage_rat_isLUB`
  ρ(q) も最小上界（前の主張）、最小上界は一意                             `cutRealization_agrees_on_rationals`

必要十分版の定理・定義は使わない。
-/
import Ising2DLambda.RealEscape.RealAlgebraicLowerCutSupremum

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent

/-- `r < q` なら `r <_R q`（正の有理数の正値性と狭義順序の定義）。 -/
theorem realAlgebraic_rat_lt_of_lt (data : RealClosedSubfieldData) {r q : ℚ} (h : r < q) :
    realAlgebraicLt data (realClosedRat data r) (realClosedRat data q) :=
  realAlgebraic_rat_lt_of_sub_pos data (realAlgebraic_rat_sub_pos data h)

/-- 下切断の同値: `ι(r)` が `C_q` の像に入ることと `r < q` は同値。 -/
theorem mem_realAlgebraicLowerCutImage_rat (data : RealClosedSubfieldData) (q r : ℚ) :
    (r : ℝ) ∈ realAlgebraicLowerCutImage data (realClosedRat data q) ↔ r < q := by
  constructor
  · rintro ⟨t, ht, hx⟩
    -- 包含写像の単射性で t = r。
    have htr : t = r := (Rat.cast_injective hx).symm
    subst htr
    exact realAlgebraic_lowerCut_lt_of_lt data ht
  · intro h
    exact ⟨r, realAlgebraic_rat_lt_of_lt data h, rfl⟩

/-- `ι(q)` は `C_q` の像の上界。 -/
theorem realAlgebraicLowerCutImage_rat_upperBound (data : RealClosedSubfieldData) (q : ℚ) :
    (q : ℝ) ∈ upperBounds (realAlgebraicLowerCutImage data (realClosedRat data q)) := by
  rintro x ⟨r, hr, rfl⟩
  -- r <_R q から r < q、包含写像で ι(r) < ι(q)。
  exact (Rat.cast_lt.mpr (realAlgebraic_lowerCut_lt_of_lt data hr)).le

/-- `ι(q)` は `C_q` の像の最小上界（稠密性の段が ℝ への脱出）。 -/
theorem realAlgebraicLowerCutImage_rat_isLUB (data : RealClosedSubfieldData) (q : ℚ) :
    IsLUB (realAlgebraicLowerCutImage data (realClosedRat data q)) (q : ℝ) := by
  refine ⟨realAlgebraicLowerCutImage_rat_upperBound data q, ?_⟩
  intro y hy
  by_contra hle
  have hlt := not_le.mp hle
  -- 実数内の有理数の稠密性: y < ι(r) < ι(q)。
  obtain ⟨r, hyr, hrq⟩ := exists_rat_btwn hlt
  -- 包含写像の狭義順序の反映で r < q、下切断の同値で ι(r) は像に入る。
  have hmem : (r : ℝ) ∈ realAlgebraicLowerCutImage data (realClosedRat data q) :=
    (mem_realAlgebraicLowerCutImage_rat data q r).mpr (Rat.cast_lt.mp hrq)
  -- y は上界なので ι(r) ≤ y、y < ι(r) と両立しない。
  exact absurd (hy hmem) (not_le.mpr hyr)

/-- `claim_cut_realization_agrees_on_rationals` の具体版: `ρ(q) = ι(q)`。 -/
theorem cutRealization_agrees_on_rationals (data : RealClosedSubfieldData) (q : ℚ) :
    realAlgebraicCutRealization data (realClosedRat data q) = (q : ℝ) := by
  -- ρ(q) は前の主張により同じ像の最小上界。
  have hρ := (realAlgebraic_lower_cut_has_supremum data (realClosedRat data q)).2.2
  -- 最小上界は一意。
  exact hρ.unique (realAlgebraicLowerCutImage_rat_isLUB data q)

end Ising2DLambda.RealEscape
