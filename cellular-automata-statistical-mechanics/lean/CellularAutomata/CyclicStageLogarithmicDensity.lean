/-
正本: content/cyclic-stage-logarithmic-density.ts の具体版。

def_cyclic_stage_logarithmic_density_domain → LogarithmicDensityDomain
def_cyclic_stage_shift_rule_family           → shiftOffset, shiftRule, stageMap_shiftRule_apply
claim_cyclic_stage_shift_logarithmic_density_obstruction
  → shift_fixed_iff_constant, shiftFixedEquivState, shift_fixedPointCountSequence,
    shift_logarithmic_count_at_two, shift_not_mem_logarithmicDensityDomain

有限巡回舞台を ZMod L、二元状態を演算なしの State、一方向シフト規則を半径一の
有限真理値表に固定する。不動点の全数分類、状態数二の素数二係数、舞台サイズによる
群内除算障害を本文と同じ順序で示す。有限型・自然数・整数・有限台整数ベクトルだけを
使い、実対数、実数除算、極限、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement

namespace CellularAutomata.CyclicStageLogarithmicDensity

open CellularAutomata.EssentialDependency
open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount
open CellularAutomata.PrimeLogarithm

noncomputable section

/-- 正の不動点数を持つ段階のうち、対数順序群値を舞台サイズで割れる段階。 -/
def LogarithmicDensityDomain (r : ℕ) (g : (Offset r → State) → State) (n : ℕ) :
    Set (PositiveCountStage r g n) :=
  {L | ∃! d : LogVector, scale (L.val.val : ℤ) d = logarithmicCountSequence r g n L}

/-- 半径一のオフセット `+1`。 -/
def shiftOffset : Offset 1 := ⟨2, by omega⟩

/-- 局所入力の `+1` 成分を返す一方向シフト真理値表。 -/
def shiftRule (y : Offset 1 → State) : State := y shiftOffset

/-- 一方向シフト真理値表が有限巡回舞台に定める大域写像。 -/
theorem stageMap_shiftRule_apply (L : PositiveStage) (x : Stage L → State) (v : Stage L) :
    stageMap L 1 shiftRule x v = x (v + 1) := by
  simp [stageMap, shiftRule, shiftOffset, globalRealizedMap, cyclicProjection, signedOffset]

/-- 一回のシフトで不変な配位は定値配位であり、その逆も成り立つ。 -/
theorem shift_fixed_iff_constant (L : PositiveStage) (x : Stage L → State) :
    iterate (stageMap L 1 shiftRule) 1 x = x ↔ ∀ v : Stage L, x v = x 0 := by
  constructor
  · intro hfixed
    have hstep : ∀ v : Stage L, x (v + 1) = x v := by
      intro v
      have hv := congrFun hfixed v
      simpa [iterate, stageMap_shiftRule_apply] using hv
    intro v
    rw [← ZMod.natCast_zmod_val v]
    induction v.val with
    | zero => simp
    | succ k ih =>
        calc
          x ((↑(k + 1) : Stage L)) = x ((↑k : Stage L) + 1) := by rw [Nat.cast_succ]
          _ = x (↑k : Stage L) := hstep (↑k)
          _ = x 0 := ih
  · intro hconstant
    funext v
    calc
      iterate (stageMap L 1 shiftRule) 1 x v = x (v + 1) := by
        simp [iterate, stageMap_shiftRule_apply]
      _ = x 0 := hconstant (v + 1)
      _ = x v := (hconstant v).symm

/-- 二元状態と一方向シフトの不動配位との全単射。 -/
noncomputable def shiftFixedEquivState (L : PositiveStage) :
    {x : Stage L → State // iterate (stageMap L 1 shiftRule) 1 x = x} ≃ State where
  toFun x := x.val 0
  invFun a := ⟨fun _ => a, (shift_fixed_iff_constant L _).2 (fun _ => rfl)⟩
  left_inv x := by
    apply Subtype.ext
    funext v
    exact (shift_fixed_iff_constant L x.val).1 x.property v |>.symm
  right_inv _ := rfl

/-- 各正の有限巡回舞台で、一方向シフトの不動点は二つの定値配位を尽くす。 -/
theorem shift_fixedPointCountSequence (L : PositiveStage) :
    fixedPointCountSequence 1 shiftRule 1 L = 2 := by
  classical
  calc
    fixedPointCountSequence 1 shiftRule 1 L =
        Fintype.card {x : Stage L → State // iterate (stageMap L 1 shiftRule) 1 x = x} := by
      unfold fixedPointCountSequence fixedPointCount fixedPoints
      convert (Fintype.card_subtype
        (fun x : Stage L → State => iterate (stageMap L 1 shiftRule) 1 x = x)).symm using 1
      apply congrArg Finset.card
      ext x
      simp
    _ = Fintype.card State := Fintype.card_congr (shiftFixedEquivState L)
    _ = 2 := card_state

/-- シフト規則族は全段階で正の不動点数を持つ。 -/
def shiftPositiveCountStage (L : PositiveStage) : PositiveCountStage 1 shiftRule 1 :=
  ⟨L, by rw [shift_fixedPointCountSequence]; decide⟩

/-- シフト規則族の各有限段階の自由エントロピーは `log_Λ(2/1)` である。 -/
theorem shift_logarithmic_count (L : PositiveStage) :
    logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L) =
      logarithm (positiveNat 2 (by decide)) := by
  unfold logarithmicCountSequence
  apply congrArg logarithm
  apply Subtype.ext
  change ((fixedPointCountSequence 1 shiftRule 1 L : ℕ) : ℚ) / 1 = (2 : ℚ) / 1
  rw [shift_fixedPointCountSequence]
  norm_num

/-- シフト規則族の自由エントロピーは、素数二の係数が一である。 -/
theorem shift_logarithmic_count_at_two (L : PositiveStage) :
    logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L) ⟨2, by decide⟩ = 1 := by
  rw [shift_logarithmic_count]
  exact logarithm_two_at_two

/-- 舞台サイズ二以上では、シフト規則族の自由エントロピーを舞台サイズで割れない。 -/
theorem shift_not_mem_logarithmicDensityDomain (L : PositiveStage) (hL : 2 ≤ L.val) :
    shiftPositiveCountStage L ∉ LogarithmicDensityDomain 1 shiftRule 1 := by
  intro hdomain
  have hdivisibility :=
    (integer_division
      (logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L))
      (L.val : ℤ)
      (by exact_mod_cast L.property.ne')).mp hdomain
  let p : Prime := ⟨2, by decide⟩
  have hpvalue :
      logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L) p = 1 := by
    exact shift_logarithmic_count_at_two L
  have hpsupport :
      p ∈ (logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L)).support := by
    exact Finsupp.mem_support_iff.mpr (by simp [hpvalue])
  have hdiv : (L.val : ℤ) ∣ 1 := by
    simpa [hpvalue] using hdivisibility p hpsupport
  have hle := Int.natAbs_le_of_dvd_ne_zero hdiv (by norm_num : (1 : ℤ) ≠ 0)
  simp at hle
  omega

end

end CellularAutomata.CyclicStageLogarithmicDensity
