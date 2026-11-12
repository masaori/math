/-
章「実数体への脱出と熱力学極限」の「下組の実現像の上限は列の実数極限に等しい」
（`claim_sequence_lower_set_sup_eq_real_limit`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                         このファイル
  第一の事実: ρ(α) < ρ(β) ⇒ α ≤_{Λ_ℚ} β（全順序性と単調性）           `rationalLogOrderLE_of_realizeRational_lt`
  第二の事実: ρ(0) = ρ(0·0) = ι(0)ρ(0) = 0·ρ(0) = 0                   `realizeRational_zero`
  第三の事実: c := ρ(ȷ(ℓ_2)) > log_ℝ ι(1) = ρ(ȷ(0)) = ρ(0) = 0        `realizeRational_generatorTwo_pos`
  上から: ρ(μ) = ρ(0+μ) ≤ ρ(ε+μ) = ρ(μ+ε) ≤ ρ(λ_L)、極限へ ρ(μ) ≤ I    `realizeRational_le_of_mem_sequenceLowerSet`
  下から: b < I に対し r, r' ∈ ℚ（b/c < ι(r) < ι(r') < I/c）、
          μ := r·ȷ(ℓ_2)、ε := s·ȷ(ℓ_2)（s := r' − r）の三つの鎖、
          収束から N、第一の事実で μ + ε ≤ λ_L                        `exists_mem_sequenceLowerSet_gt`
  結論: I は最小上界、b := I − 1 で空でない、sup = I                 `sequence_lowerSet_sup_eq_realLimit`

必要十分版の定理は使わない（`NecSuf.` を参照しない）。
実数について使うのは、実数列の極限が広義の不等式を保つこと（`ge_of_tendsto`）、
収束の定義（`lt_mem_nhds`）、有理数の稠密性（`exists_rat_btwn`）と四則だけで、完備性は使わない。
`sSup` の値は、空でないことと最小上界であることから `IsLUB.csSup_eq` で読む。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupArchimedean
import Ising2DLambda.FreeEntropy.RationalLogOrderIff
import Ising2DLambda.FreeEntropy.AtOne

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Ising2DLambda.FreeEntropy Filter Topology

/-- 第一の事実: `ρ(α) < ρ(β)` なら `α ≤_{Λ_ℚ} β`。全順序性で `β ≤ α` とすると単調性と矛盾する。 -/
theorem rationalLogOrderLE_of_realizeRational_lt {α β : RationalLogOrderGroup}
    (h : realizeRational α < realizeRational β) : rationalLogOrderLE α β := by
  rcases rationalLogOrderLE_total α β with hab | hba
  · exact hab
  · exact absurd (realizeRational_le_of_rationalLogOrderLE β α hba) (not_le.mpr h)

/-- 第二の事実: `ρ(0) = 0`。 -/
theorem realizeRational_zero : realizeRational 0 = 0 := by
  calc
    realizeRational 0
        = realizeRational ((0 : ℚ) • (0 : RationalLogOrderGroup)) := by
          rw [zero_smul]                                           -- 有理数倍、0·0 = 0
    _ = ((0 : ℚ) : ℝ) * realizeRational 0 := realizeRational_smul 0 0  -- 実現写像は有理数倍と可換
    _ = 0 * realizeRational 0 := by rw [Rat.cast_zero]             -- ι は加法を保つ
    _ = 0 := zero_mul _                                            -- ℝ の四則

/-- `ȷ(0) = 0`（`def_rational_log_order_group` の `ȷ` は零元を零元へ送る）。 -/
theorem toRational_zero' : toRational (0 : LogOrderGroup) = 0 := by
  refine Finsupp.ext fun p => ?_
  rw [toRational_apply, Finsupp.zero_apply, Int.cast_zero, Finsupp.zero_apply]

/-- `rat_Λ(ℓ_2) = 2`（`def_rational_of_log`、`supp(ℓ_2) = {2}`）。 -/
theorem rationalOfLog_generatorTwo : rationalOfLog (generator ⟨2, Nat.prime_two⟩) = 2 := by
  rw [← logRat_two, rationalOfLog_logRat two_pos]

/-- 第三の事実: `c := ρ(ȷ(ℓ_2))` は正である。本文の鎖を下から上へ読む。 -/
theorem realizeRational_generatorTwo_pos :
    0 < realizeRational (toRational (generator ⟨2, Nat.prime_two⟩)) := by
  calc
    (0 : ℝ) = realizeRational 0 := realizeRational_zero.symm                -- 第二の事実
    _ = realizeRational (toRational 0) := by rw [toRational_zero']           -- ȷ(0) = 0
    _ = realLog (rationalOfLogPositiveReal 0) := realizeRational_toRational 0  -- 実現は rat_Λ の実対数
    _ < realLog (rationalOfLogPositiveReal (generator ⟨2, Nat.prime_two⟩)) := by
          -- log_ℝ ι(rat_Λ(0)) = log_ℝ ι(1) < log_ℝ ι(2) = log_ℝ ι(rat_Λ(ℓ_2))
          apply realLog_lt_realLog
          show ((rationalOfLog 0 : ℚ) : ℝ) < ((rationalOfLog (generator ⟨2, Nat.prime_two⟩) : ℚ) : ℝ)
          rw [rationalOfLog_zero, rationalOfLog_generatorTwo]
          exact Rat.cast_lt.mpr one_lt_two                                  -- 1 < 2 と ι の狭義順序保存
    _ = realizeRational (toRational (generator ⟨2, Nat.prime_two⟩)) :=
          (realizeRational_toRational _).symm                              -- 実現は rat_Λ の実対数

/-- 上から: 下組の元の実現値は極限 `I` 以下である。 -/
theorem realizeRational_le_of_mem_sequenceLowerSet (l : ℕ → RationalLogOrderGroup) (I : ℝ)
    (hlim : Tendsto (fun L => realizeRational (l L)) atTop (𝓝 I))
    {μ : RationalLogOrderGroup} (hμ : μ ∈ rationalLogOrderSequenceLowerSet l) :
    realizeRational μ ≤ I := by
  -- 下組の証人 ε（0 ≤ ε）と N
  obtain ⟨ε, hε0, -, N, -, hN⟩ := hμ
  -- 0 + μ ≤ ε + μ（加法単調性）
  have hadd : rationalLogOrderLE (0 + μ) (ε + μ) := rationalLogOrderLE_add_right hε0 μ
  have hbound : ∀ L : ℕ, N ≤ L → realizeRational μ ≤ realizeRational (l L) := fun L hL =>
    calc
      realizeRational μ = realizeRational (0 + μ) := by rw [zero_add]   -- 単位元
      _ ≤ realizeRational (ε + μ) := realizeRational_le_of_rationalLogOrderLE _ _ hadd  -- 単調性
      _ = realizeRational (μ + ε) := by rw [add_comm]                    -- 加法の可換則
      _ ≤ realizeRational (l L) := realizeRational_le_of_rationalLogOrderLE _ _ (hN L hL)  -- 証人と単調性
  -- 実数列の極限は広義の不等式を保つ（実数体への脱出: 連続極限）
  exact ge_of_tendsto hlim (eventually_atTop.2 ⟨N, hbound⟩)

/-- 下から: `b < I` なら、下組の元 `μ` で `b < ρ(μ)` となるものがある。 -/
theorem exists_mem_sequenceLowerSet_gt (l : ℕ → RationalLogOrderGroup) (I : ℝ)
    (hlim : Tendsto (fun L => realizeRational (l L)) atTop (𝓝 I)) {b : ℝ} (hb : b < I) :
    ∃ μ ∈ rationalLogOrderSequenceLowerSet l, b < realizeRational μ := by
  set g : RationalLogOrderGroup := toRational (generator ⟨2, Nat.prime_two⟩) with hg
  set c : ℝ := realizeRational g with hcdef
  have hc : 0 < c := realizeRational_generatorTwo_pos                 -- 第三の事実
  -- b/c < I/c（0 < c）
  have hbc : b / c < I / c := div_lt_div_of_pos_right hb hc
  -- 有理数の稠密性を二度（実数体への脱出）
  obtain ⟨r, hr1, hr2⟩ := exists_rat_btwn hbc
  obtain ⟨r', hr'1, hr'2⟩ := exists_rat_btwn hr2
  set s : ℚ := r' - r with hsdef
  have hs : 0 < s := sub_pos.mpr (Rat.cast_lt.mp hr'1)                 -- ι の順序保存・単射性
  -- b < ρ(μ)、μ := r·ȷ(ℓ_2)
  have hμ : b < realizeRational (r • g) :=
    calc
      b = (b / c) * c := (div_mul_cancel₀ b (ne_of_gt hc)).symm         -- c ≠ 0、ℝ の四則
      _ < (r : ℝ) * c := mul_lt_mul_of_pos_right hr1 hc                -- b/c < ι(r)、0 < c
      _ = realizeRational (r • g) := (realizeRational_smul r g).symm    -- 有理数倍と可換
  -- ρ(μ + ε) < I、ε := s·ȷ(ℓ_2)
  have hμε : realizeRational (r • g + s • g) < I :=
    calc
      realizeRational (r • g + s • g) = realizeRational ((r + s) • g) := by
            rw [add_smul]                                              -- 有理数倍と加法の分配則
      _ = ((r + s : ℚ) : ℝ) * c := realizeRational_smul _ _             -- 有理数倍と可換
      _ = (r' : ℝ) * c := by rw [hsdef, add_sub_cancel]                 -- r + s = r'、ℚ の四則
      _ < (I / c) * c := mul_lt_mul_of_pos_right hr'2 hc                -- ι(r') < I/c、0 < c
      _ = I := div_mul_cancel₀ I (ne_of_gt hc)                          -- c ≠ 0、ℝ の四則
  -- ρ(0) < ρ(ε)
  have hε : realizeRational 0 < realizeRational (s • g) :=
    calc
      realizeRational 0 = 0 := realizeRational_zero                     -- 第二の事実
      _ < (s : ℝ) * c := mul_pos (Rat.cast_pos.mpr hs) hc               -- 正の実数の積は正
      _ = realizeRational (s • g) := (realizeRational_smul s g).symm    -- 有理数倍と可換
  -- 0 ≤ ε（第一の事実）と ε ≠ 0（ρ(ε) ≠ ρ(0)）
  have hε0 : rationalLogOrderLE 0 (s • g) := rationalLogOrderLE_of_realizeRational_lt hε
  have hεne : s • g ≠ 0 := by
    intro h
    rw [h] at hε
    exact lt_irrefl _ hε
  -- 収束の仮定から N（実数体への脱出: 連続極限）
  obtain ⟨N, hN⟩ := eventually_atTop.1 (hlim.eventually (lt_mem_nhds hμε))
  refine ⟨r • g, ⟨s • g, hε0, hεne, max N 1, le_max_right N 1, fun L hL => ?_⟩, hμ⟩
  -- 第一の事実で μ + ε ≤ λ_L
  exact rationalLogOrderLE_of_realizeRational_lt (hN L (le_trans (le_max_left N 1) hL))

/-- `claim_sequence_lower_set_sup_eq_real_limit`:
実数列 `ρ(λ_L)` が `I` に収束するなら、下組の実現像は空でなく、`I` はその最小上界であり、上限は `I` である。 -/
theorem sequence_lowerSet_sup_eq_realLimit (l : ℕ → RationalLogOrderGroup) (I : ℝ)
    (hlim : Tendsto (fun L => realizeRational (l L)) atTop (𝓝 I)) :
    (realizeRational '' rationalLogOrderSequenceLowerSet l).Nonempty ∧
      IsLUB (realizeRational '' rationalLogOrderSequenceLowerSet l) I ∧
      sSup (realizeRational '' rationalLogOrderSequenceLowerSet l) = I := by
  -- I は上界
  have hupper : I ∈ upperBounds (realizeRational '' rationalLogOrderSequenceLowerSet l) := by
    rintro _ ⟨μ, hμ, rfl⟩
    exact realizeRational_le_of_mem_sequenceLowerSet l I hlim hμ
  -- I より小さい上界は無い
  have hleast : I ∈ lowerBounds (upperBounds (realizeRational '' rationalLogOrderSequenceLowerSet l)) := by
    intro b hb
    by_contra hbI
    obtain ⟨μ, hμ, hbμ⟩ := exists_mem_sequenceLowerSet_gt l I hlim (lt_of_not_ge hbI)
    exact absurd (hb ⟨μ, hμ, rfl⟩) (not_le.mpr hbμ)
  -- b := I − 1 で空でない
  have hne : (realizeRational '' rationalLogOrderSequenceLowerSet l).Nonempty := by
    obtain ⟨μ, hμ, -⟩ := exists_mem_sequenceLowerSet_gt l I hlim (sub_one_lt I)
    exact ⟨realizeRational μ, μ, hμ, rfl⟩
  have hlub : IsLUB (realizeRational '' rationalLogOrderSequenceLowerSet l) I := ⟨hupper, hleast⟩
  exact ⟨hne, hlub, hlub.csSup_eq hne⟩

end Ising2DLambda.RealEscape
