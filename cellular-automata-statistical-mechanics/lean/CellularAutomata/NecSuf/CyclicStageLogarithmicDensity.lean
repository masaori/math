/-
章「有限巡回段階の対数順序群値と舞台サイズ規格化の境界」の Lean 必要十分版。

必要な構造の検査結果:
  - シフト不動点の分類には、セル型上の自己写像、基点、および基点から全セルへ有限反復で
    到達できることだけを要る。有限性、巡回群、加法、局所規則、二元状態は要らない。
  - 不動配位と状態の全単射には、上の到達性だけを要る。状態型の有限性は個数を取る段でだけ要る。
  - 舞台サイズによる群内除算障害には、有限台整数ベクトルの一つの係数が一であることと、
    倍率が二以上であることだけを要る。添字が素数であること、対数、舞台、局所規則は要らない。
  - 有理係数への埋め込みと正整数除算には、任意の添字型上の有限台ベクトルだけを要る。
  - 正規化列の非一定性には、任意の値域から有理数への一つの観測写像と、その観測値が
    舞台サイズの逆数であることだけを要る。有限台、素数、対数、CA は要らない。
  - 実対数、極限、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLogarithmicDensity

namespace CellularAutomata.NecSuf.CyclicStageLogarithmicDensity

open CellularAutomata.EssentialDependency
open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.CyclicStageLogarithmicDensity
open CellularAutomata.PrimeLogarithm
open CellularAutomata.NecSuf.GlobalMapIteration
open CellularAutomata.NecSuf.PeriodicPointCount

/-- 基点から自己写像を有限回反復して全セルへ到達できる。 -/
def ReachesFromBase {Cell : Type} (step : Cell → Cell) (base : Cell) : Prop :=
  ∀ v : Cell, ∃ n : ℕ, iterate step n base = v

/--
基点から全セルへ到達できる自己写像に沿う前合成で不変な配位は、定値配位に限る。
逆向きには到達性を要らない。
-/
theorem fixed_precomposition_iff_constant
    {Cell State' : Type}
    (step : Cell → Cell) (base : Cell) (hreaches : ReachesFromBase step base)
    (x : Cell → State') :
    (fun v => x (step v)) = x ↔ ∀ v : Cell, x v = x base := by
  constructor
  · intro hfixed v
    have hinvariant : ∀ n : ℕ, x (iterate step n base) = x base := by
      intro n
      induction n with
      | zero => rfl
      | succ n ih =>
          rw [iterate_succ]
          exact (congrFun hfixed _).trans ih
    obtain ⟨n, hn⟩ := hreaches v
    calc
      x v = x (iterate step n base) := congrArg x hn.symm
      _ = x base := hinvariant n
  · intro hconstant
    funext v
    exact (hconstant (step v)).trans (hconstant v).symm

/-- 上の到達条件の下で、不動配位は基点での値と全単射になる。 -/
noncomputable def fixedPrecompositionEquivState
    {Cell State' : Type}
    (step : Cell → Cell) (base : Cell) (hreaches : ReachesFromBase step base) :
    {x : Cell → State' // (fun v => x (step v)) = x} ≃ State' where
  toFun x := x.val base
  invFun a := ⟨fun _ => a, rfl⟩
  left_inv x := by
    apply Subtype.ext
    funext v
    exact (fixed_precomposition_iff_constant step base hreaches x.val).1 x.property v |>.symm
  right_inv _ := rfl

/-- 添字型上の有限台整数ベクトルの各係数を整数倍する。 -/
noncomputable def vectorScale {Index : Type} [DecidableEq Index]
    (d : ℤ) (a : Index →₀ ℤ) : Index →₀ ℤ :=
  a.mapRange (fun z => d * z) (mul_zero d)

theorem vectorScale_apply {Index : Type} [DecidableEq Index]
    (d : ℤ) (a : Index →₀ ℤ) (p : Index) : vectorScale d a p = d * a p := rfl

/-- ある係数が一なら、二以上の整数倍として有限台整数ベクトルを表せない。 -/
theorem no_scaled_preimage_of_coefficient_one
    {Index : Type} [DecidableEq Index]
    (a : Index →₀ ℤ) (p : Index) (d : ℕ) (hd : 2 ≤ d) (hp : a p = 1) :
    ¬ ∃ b : Index →₀ ℤ, vectorScale (d : ℤ) b = a := by
  rintro ⟨b, hb⟩
  have hcoefficient := congrArg (fun v : Index →₀ ℤ => v p) hb
  rw [vectorScale_apply, hp] at hcoefficient
  have hdiv : (d : ℤ) ∣ 1 := ⟨b p, hcoefficient.symm⟩
  have hle := Int.natAbs_le_of_dvd_ne_zero hdiv (by norm_num : (1 : ℤ) ≠ 0)
  simp at hle
  omega

/-! ### 有理係数正規化列に必要な構造 -/

/-- 任意の添字型上の有限台有理ベクトル。 -/
abbrev RationalVector (Index : Type) := Index →₀ ℚ

/-- 任意の添字型上の有限台整数ベクトルを有限台有理ベクトルへ埋め込む。 -/
noncomputable def integerVectorEmbedding {Index : Type} [DecidableEq Index]
    (a : Index →₀ ℤ) : RationalVector Index :=
  a.mapRange (fun z : ℤ => (z : ℚ)) (by norm_num)

theorem integerVectorEmbedding_apply {Index : Type} [DecidableEq Index]
    (a : Index →₀ ℤ) (i : Index) :
    integerVectorEmbedding a i = (a i : ℚ) := rfl

/-- 有限台有理ベクトルの各係数を正の自然数で割る。 -/
noncomputable def divideRationalVectorByPositiveNat {Index : Type} [DecidableEq Index]
    (a : RationalVector Index) (L : PositiveStage) : RationalVector Index :=
  a.mapRange (fun q : ℚ => q / (L.val : ℚ)) (by simp)

theorem divideRationalVectorByPositiveNat_apply
    {Index : Type} [DecidableEq Index]
    (a : RationalVector Index) (L : PositiveStage) (i : Index) :
    divideRationalVectorByPositiveNat a L i = a i / (L.val : ℚ) := rfl

/--
列の一つの有理観測値が各正段階で舞台サイズの逆数なら、任意の段階とその二倍で列は異なる。
値域には、観測写像以外の構造を要しない。
-/
theorem sequence_ne_double_of_inverse_observation
    {Value : Type}
    (sequence : PositiveStage → Value) (observation : Value → ℚ)
    (hinverse : ∀ L : PositiveStage, observation (sequence L) = 1 / (L.val : ℚ))
    (L : PositiveStage) :
    sequence L ≠ sequence ⟨2 * L.val, by omega⟩ := by
  intro hequal
  have hobservation := congrArg observation hequal
  rw [hinverse, hinverse] at hobservation
  have hnonzero : (L.val : ℚ) ≠ 0 := by exact_mod_cast L.property.ne'
  have hdoubleNonzero : ((2 * L.val : ℕ) : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.mul_pos (by decide : 0 < 2) L.property).ne'
  have hdenominators : ((2 * L.val : ℕ) : ℚ) = (L.val : ℚ) := by
    simpa using (div_eq_div_iff hnonzero hdoubleNonzero).mp hobservation
  have hnat : 2 * L.val = L.val := by exact_mod_cast hdenominators
  omega

/--
一つの有理観測値が舞台サイズの逆数である列は、等号では最終的に一定にならない。
-/
theorem sequence_not_eventually_constant_of_inverse_observation
    {Value : Type}
    (sequence : PositiveStage → Value) (observation : Value → ℚ)
    (hinverse : ∀ L : PositiveStage, observation (sequence L) = 1 / (L.val : ℚ)) :
    ¬ ∃ L₀ : PositiveStage, ∃ d : Value,
      ∀ L : PositiveStage, L₀.val ≤ L.val → sequence L = d := by
  rintro ⟨L₀, d, hconstant⟩
  let L₂ : PositiveStage := ⟨2 * L₀.val, by omega⟩
  have hfirst := hconstant L₀ (by omega)
  have hlater := hconstant L₂ (by change L₀.val ≤ 2 * L₀.val; omega)
  have hdouble : L₂ = (⟨2 * L₀.val, by omega⟩ : PositiveStage) := rfl
  rw [hdouble] at hlater
  exact sequence_ne_double_of_inverse_observation sequence observation hinverse L₀
    (hfirst.trans hlater.symm)

/-! ### 具体版の導出 -/

section Derivation

/-- 有限巡回舞台の加法一ステップは、零から全セルへ有限反復で到達する。 -/
theorem cyclic_successor_reaches_from_zero (L : PositiveStage) :
    ReachesFromBase (fun v : Stage L => v + 1) 0 := by
  intro v
  have hnat : ∀ n : ℕ, iterate (fun w : Stage L => w + 1) n 0 = (n : Stage L) := by
    intro n
    induction n with
    | zero => simp [iterate_zero]
    | succ n ih => rw [iterate_succ, ih, Nat.cast_succ]
  exact ⟨v.val, (hnat v.val).trans (ZMod.natCast_zmod_val v)⟩

/-- 具体版のシフト不動点分類は、基点からの到達性だけを使う一般定理の特殊化である。 -/
theorem shift_fixed_iff_constant_of_necSuf (L : PositiveStage) (x : Stage L → State) :
    iterate (stageMap L 1 shiftRule) 1 x = x ↔ ∀ v : Stage L, x v = x 0 := by
  have hmap : iterate (stageMap L 1 shiftRule) 1 x =
      (fun v : Stage L => x (v + 1)) := by
    funext v
    simp [iterate, stageMap_shiftRule_apply]
  rw [hmap]
  exact fixed_precomposition_iff_constant
    (fun v : Stage L => v + 1) 0 (cyclic_successor_reaches_from_zero L) x

/-- 具体版の不動配位と二元状態の全単射も、基点からの到達性だけから得られる。 -/
noncomputable def shiftFixedEquivStateOfNecSuf (L : PositiveStage) :
    {x : Stage L → State // iterate (stageMap L 1 shiftRule) 1 x = x} ≃ State where
  toFun x := x.val 0
  invFun a := ⟨fun _ => a, (shift_fixed_iff_constant_of_necSuf L _).2 (fun _ => rfl)⟩
  left_inv x := by
    apply Subtype.ext
    funext v
    exact (shift_fixed_iff_constant_of_necSuf L x.val).1 x.property v |>.symm
  right_inv _ := rfl

/-- 具体版の不動点数二は、一般の不動配位全単射の特殊化である。 -/
theorem shift_fixedPointCountSequence_of_necSuf (L : PositiveStage) :
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
    _ = Fintype.card State := Fintype.card_congr (shiftFixedEquivStateOfNecSuf L)
    _ = 2 := card_state

/-- 具体版の自由エントロピー値は、一般の不動配位全単射から得た個数二に従う。 -/
theorem shift_logarithmic_count_of_necSuf (L : PositiveStage) :
    logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L) =
      logarithm (positiveNat 2 (by decide)) := by
  unfold logarithmicCountSequence
  apply congrArg logarithm
  apply Subtype.ext
  change ((fixedPointCountSequence 1 shiftRule 1 L : ℕ) : ℚ) / 1 = (2 : ℚ) / 1
  rw [shift_fixedPointCountSequence_of_necSuf]
  norm_num

/-- 具体版の素数二係数一も、一般の不動配位全単射から得た個数二に従う。 -/
theorem shift_logarithmic_count_at_two_of_necSuf (L : PositiveStage) :
    logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L) ⟨2, by decide⟩ = 1 := by
  rw [shift_logarithmic_count_of_necSuf]
  exact logarithm_two_at_two

/-- 具体版の規格化障害は、素数二の係数一だけを使う一般定理の特殊化である。 -/
theorem shift_not_mem_logarithmicDensityDomain_of_necSuf
    (L : PositiveStage) (hL : 2 ≤ L.val) :
    shiftPositiveCountStage L ∉ LogarithmicDensityDomain 1 shiftRule 1 := by
  intro hdomain
  obtain ⟨d, hd, _⟩ := hdomain
  apply no_scaled_preimage_of_coefficient_one
    (logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L))
    (⟨2, by decide⟩ : Prime) L.val hL (shift_logarithmic_count_at_two_of_necSuf L)
  refine ⟨d, ?_⟩
  exact hd

/-- 具体版の整数係数埋め込みは、任意の添字型上の埋め込みの特殊化である。 -/
theorem rationalEmbedding_eq_necessary_sufficient (a : LogVector) :
    rationalEmbedding a = integerVectorEmbedding a := rfl

/-- 具体版の正整数除算は、任意の添字型上の除算の特殊化である。 -/
theorem divideRationalVector_eq_necessary_sufficient
    (a : RationalLogVector) (L : PositiveStage) :
    divideRationalVector a L = divideRationalVectorByPositiveNat a L := rfl

/-- 具体版の素数二係数は、一般の埋め込みと正整数除算から得られる。 -/
theorem shiftRationalizedLogarithmicDensity_at_two_of_necSuf (L : PositiveStage) :
    shiftRationalizedLogarithmicDensity L ⟨2, by decide⟩ = 1 / (L.val : ℚ) := by
  rw [shiftRationalizedLogarithmicDensity,
    divideRationalVector_eq_necessary_sufficient,
    divideRationalVectorByPositiveNat_apply,
    rationalEmbedding_eq_necessary_sufficient,
    integerVectorEmbedding_apply,
    shift_logarithmic_count_at_two_of_necSuf]
  norm_num

/-- 具体版の二倍段階との非一致は、一座標の逆数表示だけを使う一般定理から得られる。 -/
theorem shiftRationalizedLogarithmicDensity_ne_double_of_necSuf (L : PositiveStage) :
    shiftRationalizedLogarithmicDensity L ≠
      shiftRationalizedLogarithmicDensity ⟨2 * L.val, by omega⟩ := by
  exact sequence_ne_double_of_inverse_observation
    shiftRationalizedLogarithmicDensity
    (fun a : RationalLogVector => a ⟨2, by decide⟩)
    shiftRationalizedLogarithmicDensity_at_two_of_necSuf L

/-- 具体版の完全安定化の否定は、一座標の逆数表示だけを使う一般定理から得られる。 -/
theorem shiftRationalizedLogarithmicDensity_not_eventually_constant_of_necSuf :
    ¬ ∃ L₀ : PositiveStage, ∃ d : RationalLogVector,
      ∀ L : PositiveStage, L₀.val ≤ L.val → shiftRationalizedLogarithmicDensity L = d := by
  exact sequence_not_eventually_constant_of_inverse_observation
    shiftRationalizedLogarithmicDensity
    (fun a : RationalLogVector => a ⟨2, by decide⟩)
    shiftRationalizedLogarithmicDensity_at_two_of_necSuf

end Derivation

end CellularAutomata.NecSuf.CyclicStageLogarithmicDensity
