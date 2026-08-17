/-
章「熱力学極限」の「格子点数あたりの Fisher 零点数の列の上極限と下極限（実数体への脱出: 完備性）」
（`def_fisher_zero_density_limsup_liminf`）の具体版。定義ブロックなので必要十分版は置かない。

  人手証明                                                          このファイル
  列 (ν_L(c,r))_{L≥1} ⊂ ℚ                                          `fisherZeroDensitySequence`（L = 0 は 0 で埋める）
  0 ≤ ν_L ≤ 2                                                       `fisherZeroDensitySequence_nonneg` / `_le_two`
  尾部の像 T_N(c,r) := { ι(ν_L) | N ≤ L } ⊂ ℝ                       `fisherZeroDensityTail`
  空でない／上界 2／下界 0                                          `fisherZeroDensityTail_nonempty` / `_bddAbove` / `_bddBelow`
  0 ≤ s_N := sup T_N,  i_N := inf T_N ≤ 2                            `fisherZeroDensityTailSup_nonneg` / `fisherZeroDensityTailInf_le_two`
  {s_N | N ≥ 1} は空でなく下に有界                                    `fisherZeroDensityTailSupSet` / `_nonempty` / `_bddBelow`
  {i_N | N ≥ 1} は空でなく上に有界                                    `fisherZeroDensityTailInfSet` / `_nonempty` / `_bddAbove`
  ν̄(c,r) := inf {s_N},  ν_(c,r) := sup {i_N}                        `fisherZeroDensityLimsup` / `fisherZeroDensityLiminf`

住処: ℝ（完備性。`sSup`・`sInf` は上限・下限）。極限の存在（ν̄ = ν_）は主張しない。
-/
import Mathlib.Data.Real.Archimedean
import Ising2DLambda.ThermodynamicLimit.FisherZeroDensityInRationalDisc

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

variable (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r})

/-- 列 `L ↦ ν_L(c,r)`。人手証明では `L ≥ 1` だけを使う。`L = 0` は `0` で埋める（尾部は `N ≥ 1` でしか取らないので使われない）。 -/
noncomputable def fisherZeroDensitySequence : ℕ → ℚ :=
  fun L => if h : L = 0 then 0 else
    haveI : NeZero L := ⟨h⟩
    fisherZeroDensityInRationalDisc L data c r

/-- `L ≠ 0` では列の値は `ν_L(c,r)` そのものである。 -/
theorem fisherZeroDensitySequence_of_ne_zero (L : ℕ) [hL : NeZero L] :
    fisherZeroDensitySequence data c r L = fisherZeroDensityInRationalDisc L data c r := by
  unfold fisherZeroDensitySequence
  rw [dif_neg hL.ne]

/-- `0 ≤ ν_L(c,r)`（`def_fisher_zero_density_in_rational_disc`）。 -/
theorem fisherZeroDensitySequence_nonneg (L : ℕ) : 0 ≤ fisherZeroDensitySequence data c r L := by
  unfold fisherZeroDensitySequence
  by_cases h : L = 0
  · simp [h]
  · haveI : NeZero L := ⟨h⟩
    rw [dif_neg h]
    exact fisherZeroDensityInRationalDisc_nonneg L data c r

/-- `ν_L(c,r) ≤ 2`（`claim_fisher_zero_density_in_rational_disc_le_two`）。 -/
theorem fisherZeroDensitySequence_le_two (L : ℕ) : fisherZeroDensitySequence data c r L ≤ 2 := by
  unfold fisherZeroDensitySequence
  by_cases h : L = 0
  · simp [h]
  · haveI : NeZero L := ⟨h⟩
    rw [dif_neg h]
    exact fisherZeroDensityInRationalDisc_le_two L data c r

/-- 尾部の像 `T_N(c,r) := { ι_{ℚ→ℝ}(ν_L(c,r)) | N ≤ L } ⊂ ℝ`。 -/
def fisherZeroDensityTail (N : ℕ) : Set ℝ :=
  {t : ℝ | ∃ L : ℕ, N ≤ L ∧ t = ((fisherZeroDensitySequence data c r L : ℚ) : ℝ)}

/-- 空でない: `L := N` が入る。 -/
theorem fisherZeroDensityTail_nonempty (N : ℕ) : (fisherZeroDensityTail data c r N).Nonempty :=
  ⟨_, N, le_rfl, rfl⟩

/-- 上に有界: `ν_L ≤ 2` と `ι_{ℚ→ℝ}` の順序保存（`Rat.cast_le`）から、`2` が上界。 -/
theorem fisherZeroDensityTail_bddAbove (N : ℕ) : BddAbove (fisherZeroDensityTail data c r N) := by
  refine ⟨2, ?_⟩
  rintro t ⟨L, _, rfl⟩
  have h : ((fisherZeroDensitySequence data c r L : ℚ) : ℝ) ≤ ((2 : ℚ) : ℝ) :=
    Rat.cast_le.mpr (fisherZeroDensitySequence_le_two data c r L)
  simpa using h

/-- 下に有界: `0 ≤ ν_L` と順序保存から、`0` が下界。 -/
theorem fisherZeroDensityTail_bddBelow (N : ℕ) : BddBelow (fisherZeroDensityTail data c r N) := by
  refine ⟨0, ?_⟩
  rintro t ⟨L, _, rfl⟩
  have h : ((0 : ℚ) : ℝ) ≤ ((fisherZeroDensitySequence data c r L : ℚ) : ℝ) :=
    Rat.cast_le.mpr (fisherZeroDensitySequence_nonneg data c r L)
  simpa using h

/-- `0 ≤ s_N`: 上限は元 `ι(ν_N) ∈ T_N` 以上で、その元は `0` 以上。 -/
theorem fisherZeroDensityTailSup_nonneg (N : ℕ) : 0 ≤ sSup (fisherZeroDensityTail data c r N) := by
  have hmem : ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) ∈ fisherZeroDensityTail data c r N :=
    ⟨N, le_rfl, rfl⟩
  have h0 : ((0 : ℚ) : ℝ) ≤ ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) :=
    Rat.cast_le.mpr (fisherZeroDensitySequence_nonneg data c r N)
  calc (0 : ℝ) = ((0 : ℚ) : ℝ) := by simp
    _ ≤ ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) := h0
    _ ≤ sSup (fisherZeroDensityTail data c r N) :=
        le_csSup (fisherZeroDensityTail_bddAbove data c r N) hmem

/-- `i_N ≤ 2`: 下限は元 `ι(ν_N) ∈ T_N` 以下で、その元は `2` 以下。 -/
theorem fisherZeroDensityTailInf_le_two (N : ℕ) : sInf (fisherZeroDensityTail data c r N) ≤ 2 := by
  have hmem : ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) ∈ fisherZeroDensityTail data c r N :=
    ⟨N, le_rfl, rfl⟩
  have h2 : ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) ≤ ((2 : ℚ) : ℝ) :=
    Rat.cast_le.mpr (fisherZeroDensitySequence_le_two data c r N)
  calc sInf (fisherZeroDensityTail data c r N)
      ≤ ((fisherZeroDensitySequence data c r N : ℚ) : ℝ) :=
        csInf_le (fisherZeroDensityTail_bddBelow data c r N) hmem
    _ ≤ ((2 : ℚ) : ℝ) := h2
    _ = 2 := by simp

/-- `{ s_N(c,r) | N ≥ 1 } ⊂ ℝ`。 -/
noncomputable def fisherZeroDensityTailSupSet : Set ℝ :=
  {s : ℝ | ∃ N : ℕ, 1 ≤ N ∧ s = sSup (fisherZeroDensityTail data c r N)}

/-- 空でない（`N = 1`）。 -/
theorem fisherZeroDensityTailSupSet_nonempty : (fisherZeroDensityTailSupSet data c r).Nonempty :=
  ⟨_, 1, le_rfl, rfl⟩

/-- 下に有界（下界 `0`）。 -/
theorem fisherZeroDensityTailSupSet_bddBelow : BddBelow (fisherZeroDensityTailSupSet data c r) := by
  refine ⟨0, ?_⟩
  rintro s ⟨N, _, rfl⟩
  exact fisherZeroDensityTailSup_nonneg data c r N

/-- `{ i_N(c,r) | N ≥ 1 } ⊂ ℝ`。 -/
noncomputable def fisherZeroDensityTailInfSet : Set ℝ :=
  {i : ℝ | ∃ N : ℕ, 1 ≤ N ∧ i = sInf (fisherZeroDensityTail data c r N)}

/-- 空でない（`N = 1`）。 -/
theorem fisherZeroDensityTailInfSet_nonempty : (fisherZeroDensityTailInfSet data c r).Nonempty :=
  ⟨_, 1, le_rfl, rfl⟩

/-- 上に有界（上界 `2`）。 -/
theorem fisherZeroDensityTailInfSet_bddAbove : BddAbove (fisherZeroDensityTailInfSet data c r) := by
  refine ⟨2, ?_⟩
  rintro i ⟨N, _, rfl⟩
  exact fisherZeroDensityTailInf_le_two data c r N

/-- 上極限 `ν̄(c,r) := inf { s_N(c,r) | N ≥ 1 }`（完備性で下限を取る）。 -/
noncomputable def fisherZeroDensityLimsup : ℝ :=
  sInf (fisherZeroDensityTailSupSet data c r)

/-- 下極限 `ν_(c,r) := sup { i_N(c,r) | N ≥ 1 }`（完備性で上限を取る）。 -/
noncomputable def fisherZeroDensityLiminf : ℝ :=
  sSup (fisherZeroDensityTailInfSet data c r)

end Ising2DLambda.ThermodynamicLimit
