/-
正本: content/cyclic-stage-logarithmic-density.ts の具体版。

def_cyclic_stage_logarithmic_density_domain → LogarithmicDensityDomain
def_cyclic_stage_shift_rule_family           → shiftOffset, shiftRule, stageMap_shiftRule_apply
claim_cyclic_stage_shift_logarithmic_density_obstruction
  → shift_fixed_iff_constant, shiftFixedEquivState, shift_fixedPointCountSequence,
    shift_logarithmic_count_at_two, shift_not_mem_logarithmicDensityDomain
def_positive_rational_epsilon_convergence → RationallyConverges
claim_positive_integer_reciprocal_converges_rationally
  → positiveIntegerReciprocal_rationallyConverges
claim_shift_rationalized_logarithmic_density_converges_rationally
  → shiftRationalizedPrimeTwoCoefficient_rationallyConverges
def_rational_prime_vector_finite_sum_distance
  → rationalLogVectorFiniteSumDistance
def_rational_prime_vector_finite_sum_convergence
  → RationalLogVectorConverges
claim_rational_prime_vector_finite_sum_distance_nonnegative
  → rationalLogVectorFiniteSumDistance_nonnegative
claim_shift_rationalized_logarithmic_density_vector_converges
  → shiftRationalizedLogarithmicDensity_apply,
    shiftRationalizedLogarithmicDensity_support,
    shiftRationalizedLogarithmicDensity_distance_zero,
    shiftRationalizedLogarithmicDensity_vectorConverges
def_rational_prime_vector_finite_sum_cauchy → RationalLogVectorCauchy
def_increasing_prime_sequence → increasingPrimeIndex, increasingPrimeIndex_injective
def_rational_prime_vector_geometric_truncation_sequence
  → geometricPrimeTruncation, geometricPrimeTruncation_apply_index
claim_rational_prime_vector_geometric_truncations_cauchy
  → geometricPrimeTruncation_distance_of_le,
    geometricPrimeTruncation_distance_lt_reciprocal,
    geometricPrimeTruncation_cauchy
claim_rational_prime_vector_geometric_truncations_no_limit
  → geometricPrimeTruncation_no_finiteSupport_limit
def_rational_prime_vector_cauchy_sequence_asymptotic_agreement
  → RationalLogVectorAsymptoticallyAgrees
claim_rational_prime_vector_asymptotically_distinct_cauchy_sequences_uncountable
  → binaryGeometricPrimeTruncation, binaryGeometricPrimeTruncation_cauchy,
    binaryGeometricPrimeTruncation_not_asymptotically_agree,
    binaryCauchySequenceFamily_uncountable

有限巡回舞台を ZMod L、二元状態を演算なしの State、一方向シフト規則を半径一の
有限真理値表に固定する。不動点の全数分類、状態数二の素数二係数、舞台サイズによる
群内除算障害を本文と同じ順序で示す。有限型・自然数・整数・有限台整数ベクトルだけを
使う。有理収束は正有理数の許容誤差だけで定義し、実対数、実数除算、位相、完備化、
実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement
import Mathlib.Algebra.Order.Archimedean.Basic
import Mathlib.Algebra.Order.Field.GeomSum
import Mathlib.Data.Nat.Prime.Nth

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

/-! ## 有理係数へ拡張した一方向シフトの正規化列 -/

/-- 素数上の有限台有理ベクトル。 -/
abbrev RationalLogVector := Prime →₀ ℚ

/-- 対数順序群の有限台整数ベクトルを有限台有理ベクトルへ埋め込む。 -/
noncomputable def rationalEmbedding (a : LogVector) : RationalLogVector :=
  a.mapRange (fun z : ℤ => (z : ℚ)) (by norm_num)

theorem rationalEmbedding_apply (a : LogVector) (p : Prime) :
    rationalEmbedding a p = (a p : ℚ) := rfl

/-- 有限台有理ベクトルの各係数を正の舞台サイズで割る。 -/
noncomputable def divideRationalVector (a : RationalLogVector) (L : PositiveStage) :
    RationalLogVector :=
  a.mapRange (fun q : ℚ => q / (L.val : ℚ)) (by simp)

theorem divideRationalVector_apply (a : RationalLogVector) (L : PositiveStage) (p : Prime) :
    divideRationalVector a L p = a p / (L.val : ℚ) := rfl

/-- 一方向シフト規則族の有理係数正規化列。 -/
noncomputable def shiftRationalizedLogarithmicDensity (L : PositiveStage) :
    RationalLogVector :=
  divideRationalVector
    (rationalEmbedding
      (logarithmicCountSequence 1 shiftRule 1 (shiftPositiveCountStage L)))
    L

/-- 一方向シフトの有理係数正規化列の素数二係数は舞台サイズの逆数である。 -/
theorem shiftRationalizedLogarithmicDensity_at_two (L : PositiveStage) :
    shiftRationalizedLogarithmicDensity L ⟨2, by decide⟩ = 1 / (L.val : ℚ) := by
  rw [shiftRationalizedLogarithmicDensity, divideRationalVector_apply,
    rationalEmbedding_apply, shift_logarithmic_count_at_two]
  norm_num

/-- 任意の開始段階と、その二倍の段階で有理係数正規化列は異なる。 -/
theorem shiftRationalizedLogarithmicDensity_ne_double (L : PositiveStage) :
    shiftRationalizedLogarithmicDensity L ≠
      shiftRationalizedLogarithmicDensity ⟨2 * L.val, by omega⟩ := by
  intro hequal
  have hcoefficient := congrArg (fun a : RationalLogVector => a ⟨2, by decide⟩) hequal
  rw [shiftRationalizedLogarithmicDensity_at_two,
    shiftRationalizedLogarithmicDensity_at_two] at hcoefficient
  have hnonzero : (L.val : ℚ) ≠ 0 := by exact_mod_cast L.property.ne'
  have hdoubleNonzero : ((2 * L.val : ℕ) : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.mul_pos (by decide : 0 < 2) L.property).ne'
  have hdenominators : ((2 * L.val : ℕ) : ℚ) = (L.val : ℚ) := by
    simpa using (div_eq_div_iff hnonzero hdoubleNonzero).mp hcoefficient
  have hnat : 2 * L.val = L.val := by exact_mod_cast hdenominators
  omega

/-- 有理係数へ拡張した一方向シフトの正規化列も、等号では最終的に一定にならない。 -/
theorem shiftRationalizedLogarithmicDensity_not_eventually_constant :
    ¬ ∃ L₀ : PositiveStage, ∃ d : RationalLogVector,
      ∀ L : PositiveStage, L₀.val ≤ L.val → shiftRationalizedLogarithmicDensity L = d := by
  rintro ⟨L₀, d, hconstant⟩
  let L₂ : PositiveStage := ⟨2 * L₀.val, by omega⟩
  have hfirst := hconstant L₀ (by omega)
  have hlater := hconstant L₂ (by change L₀.val ≤ 2 * L₀.val; omega)
  have hdouble : L₂ = (⟨2 * L₀.val, by omega⟩ : PositiveStage) := rfl
  rw [hdouble] at hlater
  exact shiftRationalizedLogarithmicDensity_ne_double L₀ (hfirst.trans hlater.symm)

/-! ## 正有理数の許容誤差による収束 -/

/-- 正有理数だけを許容誤差として量化する、有理数列の有理数値への収束。 -/
def RationallyConverges (u : PositiveStage → ℚ) (q : ℚ) : Prop :=
  ∀ ε : ℚ, 0 < ε → ∃ L₀ : PositiveStage,
    ∀ L : PositiveStage, L₀.val ≤ L.val → |u L - q| < ε

/-- 正整数の逆数列は、正有理数の許容誤差による意味で有理数の零へ収束する。 -/
theorem positiveIntegerReciprocal_rationallyConverges :
    RationallyConverges (fun L : PositiveStage => 1 / (L.val : ℚ)) 0 := by
  intro ε hε
  obtain ⟨n, hn⟩ := exists_nat_gt (1 / ε)
  let L₀ : PositiveStage := ⟨n + 1, by omega⟩
  refine ⟨L₀, ?_⟩
  intro L hL
  have hnL : n < L.val := by
    change n + 1 ≤ L.val at hL
    omega
  have hnLrat : (n : ℚ) < (L.val : ℚ) := by exact_mod_cast hnL
  have hinverseLt : 1 / ε < (L.val : ℚ) := hn.trans hnLrat
  have honeLt : (1 : ℚ) < (L.val : ℚ) * ε :=
    (div_lt_iff₀ hε).mp hinverseLt
  have hLpositive : (0 : ℚ) < (L.val : ℚ) := by exact_mod_cast L.property
  rw [sub_zero, abs_of_pos (one_div_pos.mpr hLpositive)]
  apply (div_lt_iff₀ hLpositive).mpr
  simpa [mul_comm] using honeLt

/-- 一方向シフトの有理係数正規化列から素数二係数だけを取り出す。 -/
def shiftRationalizedPrimeTwoCoefficient (L : PositiveStage) : ℚ :=
  shiftRationalizedLogarithmicDensity L ⟨2, by decide⟩

/-- 一方向シフトの素数二係数列は、正整数の逆数列に一致する。 -/
theorem shiftRationalizedPrimeTwoCoefficient_eq_reciprocal (L : PositiveStage) :
    shiftRationalizedPrimeTwoCoefficient L = 1 / (L.val : ℚ) := by
  exact shiftRationalizedLogarithmicDensity_at_two L

/-- 一方向シフトの素数二係数列は、有理数内で零へ収束する。 -/
theorem shiftRationalizedPrimeTwoCoefficient_rationallyConverges :
    RationallyConverges shiftRationalizedPrimeTwoCoefficient 0 := by
  intro ε hε
  obtain ⟨L₀, htail⟩ := positiveIntegerReciprocal_rationallyConverges ε hε
  refine ⟨L₀, ?_⟩
  intro L hL
  rw [shiftRationalizedPrimeTwoCoefficient_eq_reciprocal]
  exact htail L hL

/-! ## 有限台有理素数ベクトル列の有限和差量による収束 -/

/-- 有限台有理素数ベクトルの零元。 -/
def rationalLogVectorZero : RationalLogVector := 0

/-- 二つの有限台有理素数ベクトルについて、台の合併上の有理絶対差を有限加法した量。 -/
def rationalLogVectorFiniteSumDistance (a b : RationalLogVector) : ℚ :=
  (a.support ∪ b.support).sum fun p => |a p - b p|

/-- 正有理数だけを許容誤差として量化する、有限和差量によるベクトル列の収束。 -/
def RationalLogVectorConverges
    (d : PositiveStage → RationalLogVector) (a : RationalLogVector) : Prop :=
  ∀ ε : ℚ, 0 < ε → ∃ L₀ : PositiveStage,
    ∀ L : PositiveStage, L₀.val ≤ L.val → rationalLogVectorFiniteSumDistance (d L) a < ε

/-- 有限和差量は非負有理数である。 -/
theorem rationalLogVectorFiniteSumDistance_nonnegative (a b : RationalLogVector) :
    0 ≤ rationalLogVectorFiniteSumDistance a b := by
  apply Finset.sum_nonneg
  intro p hp
  exact abs_nonneg (a p - b p)

/-- シフト正規化ベクトルの各素数係数は、素数二だけで非零になる。 -/
theorem shiftRationalizedLogarithmicDensity_apply (L : PositiveStage) (p : Prime) :
    shiftRationalizedLogarithmicDensity L p =
      if p = (⟨2, by decide⟩ : Prime) then 1 / (L.val : ℚ) else 0 := by
  rw [shiftRationalizedLogarithmicDensity, divideRationalVector_apply,
    rationalEmbedding_apply, shift_logarithmic_count, logarithm_nat_apply]
  by_cases hp : p = (⟨2, by decide⟩ : Prime)
  · subst p
    rw [Nat.Prime.factorization_self (by decide : Nat.Prime 2)]
    simp
  · have hnotdiv : ¬p.val ∣ 2 := by
      intro hdiv
      have hle : p.val ≤ 2 := Nat.le_of_dvd (by decide : 0 < 2) hdiv
      have hge : 2 ≤ p.val := p.property.two_le
      have heq : p.val = 2 := by omega
      exact hp (Subtype.ext heq)
    rw [Nat.factorization_eq_zero_of_not_dvd hnotdiv]
    simp [hp]

/-- シフト正規化ベクトルの台は素数二だけからなる。 -/
theorem shiftRationalizedLogarithmicDensity_support (L : PositiveStage) :
    (shiftRationalizedLogarithmicDensity L).support = {⟨2, by decide⟩} := by
  ext p
  rw [Finsupp.mem_support_iff]
  simp only [Finset.mem_singleton]
  rw [shiftRationalizedLogarithmicDensity_apply]
  have hLnonzero : (L.val : ℚ) ≠ 0 := by exact_mod_cast L.property.ne'
  by_cases hp : p = (⟨2, by decide⟩ : Prime)
  · simp [hp, hLnonzero]
  · simp [hp]

/-- シフト正規化ベクトルと零ベクトルの有限和差量は舞台サイズの逆数である。 -/
theorem shiftRationalizedLogarithmicDensity_distance_zero (L : PositiveStage) :
    rationalLogVectorFiniteSumDistance
        (shiftRationalizedLogarithmicDensity L) rationalLogVectorZero =
      1 / (L.val : ℚ) := by
  rw [rationalLogVectorFiniteSumDistance, shiftRationalizedLogarithmicDensity_support]
  simp [rationalLogVectorZero, shiftRationalizedLogarithmicDensity_at_two]

/-- 一方向シフトの正規化列は、有限和差量について零ベクトルへ収束する。 -/
theorem shiftRationalizedLogarithmicDensity_vectorConverges :
    RationalLogVectorConverges shiftRationalizedLogarithmicDensity rationalLogVectorZero := by
  intro ε hε
  obtain ⟨L₀, htail⟩ := positiveIntegerReciprocal_rationallyConverges ε hε
  refine ⟨L₀, ?_⟩
  intro L hL
  rw [shiftRationalizedLogarithmicDensity_distance_zero]
  simpa using htail L hL

/-! ## 有限台有理素数ベクトルの完備性の境界 -/

/-- 正有理数だけを許容誤差として量化する、有限和差量による Cauchy 性。 -/
def RationalLogVectorCauchy (d : PositiveStage → RationalLogVector) : Prop :=
  ∀ ε : ℚ, 0 < ε → ∃ L₀ : PositiveStage,
    ∀ L M : PositiveStage, L₀.val ≤ L.val → L₀.val ≤ M.val →
      rationalLogVectorFiniteSumDistance (d L) (d M) < ε

/-- 自然数で零始まりに添字付けした素数の増加列。 -/
def increasingPrimeIndex (k : ℕ) : Prime :=
  ⟨Nat.nth Nat.Prime k, Nat.nth_mem_of_infinite Nat.infinite_setOf_prime k⟩

theorem increasingPrimeIndex_injective : Function.Injective increasingPrimeIndex := by
  intro k l h
  apply (Nat.nth_injective Nat.infinite_setOf_prime)
  exact congrArg Subtype.val h

/-- 最初の `L` 個の素数へ係数 `2^-(k+1)` を置く有限打ち切りベクトル。 -/
noncomputable def geometricPrimeTruncation (L : PositiveStage) : RationalLogVector :=
  (Finset.range L.val).sum fun k =>
    Finsupp.single (increasingPrimeIndex k) (1 / (2 : ℚ) ^ (k + 1))

theorem geometricPrimeTruncation_apply_index (L : PositiveStage) (k : ℕ) :
    geometricPrimeTruncation L (increasingPrimeIndex k) =
      if k < L.val then 1 / (2 : ℚ) ^ (k + 1) else 0 := by
  classical
  simp [geometricPrimeTruncation, Finsupp.single_apply,
    increasingPrimeIndex_injective.eq_iff]

theorem geometricPrimeTruncation_support_subset (L : PositiveStage) :
    (geometricPrimeTruncation L).support ⊆
      (Finset.range L.val).image increasingPrimeIndex := by
  classical
  intro p hp
  have hpRange : p.val ∈ Set.range (Nat.nth Nat.Prime) := by
    rw [Nat.range_nth_of_infinite Nat.infinite_setOf_prime]
    exact p.property
  obtain ⟨k, hk⟩ := hpRange
  have hkPrime : increasingPrimeIndex k = p := by
    apply Subtype.ext
    exact hk
  have hnonzero := Finsupp.mem_support_iff.mp hp
  rw [← hkPrime, geometricPrimeTruncation_apply_index] at hnonzero
  have hkL : k < L.val := by
    by_contra hnot
    simp [hnot] at hnonzero
  exact Finset.mem_image.mpr ⟨k, Finset.mem_range.mpr hkL, hkPrime⟩

/-- 幾何級数打ち切りベクトルの台は、最初の `L` 個の素数である。 -/
theorem geometricPrimeTruncation_support (L : PositiveStage) :
    (geometricPrimeTruncation L).support =
      (Finset.range L.val).image increasingPrimeIndex := by
  classical
  apply Finset.Subset.antisymm (geometricPrimeTruncation_support_subset L)
  intro p hp
  obtain ⟨k, hk, rfl⟩ := Finset.mem_image.mp hp
  rw [Finsupp.mem_support_iff, geometricPrimeTruncation_apply_index]
  simp [Finset.mem_range.mp hk]

/-- 小さい打ち切り段階が大きい打ち切り段階の台に含まれる。 -/
theorem geometricPrimeTruncation_support_mono
    (L M : PositiveStage) (hLM : L.val ≤ M.val) :
    (geometricPrimeTruncation L).support ⊆ (geometricPrimeTruncation M).support := by
  rw [geometricPrimeTruncation_support, geometricPrimeTruncation_support]
  exact Finset.image_mono increasingPrimeIndex (Finset.range_mono hLM)

/-- 二つの打ち切り段階の有限和差量は、その間の幾何級数の尾である。 -/
theorem geometricPrimeTruncation_distance_of_le
    (L M : PositiveStage) (hLM : L.val ≤ M.val) :
    rationalLogVectorFiniteSumDistance
        (geometricPrimeTruncation L) (geometricPrimeTruncation M) =
      ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) := by
  classical
  rw [rationalLogVectorFiniteSumDistance]
  rw [Finset.union_eq_right.mpr (geometricPrimeTruncation_support_mono L M hLM)]
  rw [geometricPrimeTruncation_support,
    Finset.sum_image (Set.injOn_of_injective increasingPrimeIndex_injective)]
  calc
    ∑ k ∈ Finset.range M.val,
        |geometricPrimeTruncation L (increasingPrimeIndex k) -
          geometricPrimeTruncation M (increasingPrimeIndex k)| =
        ∑ k ∈ Finset.range M.val,
          if L.val ≤ k then 1 / (2 : ℚ) ^ (k + 1) else 0 := by
      apply Finset.sum_congr rfl
      intro k hk
      have hkM : k < M.val := Finset.mem_range.mp hk
      rw [geometricPrimeTruncation_apply_index, geometricPrimeTruncation_apply_index]
      by_cases hkL : k < L.val
      · simp [hkL, hkM, Nat.not_le.mpr hkL]
      · simp [hkL, Nat.le_of_not_gt hkL, hkM]
    _ = ∑ k ∈ (Finset.range M.val).filter (fun k => L.val ≤ k),
        1 / (2 : ℚ) ^ (k + 1) := by
      rw [Finset.sum_filter]
    _ = ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) := by
      congr 1
      ext k
      simp [Finset.mem_Ico, and_comm]

/-- 有限幾何級数の尾は、小さい段階の逆数未満である。 -/
theorem geometricPrimeTruncation_distance_lt_reciprocal
    (L M : PositiveStage) (hLM : L.val ≤ M.val) :
    rationalLogVectorFiniteSumDistance
        (geometricPrimeTruncation L) (geometricPrimeTruncation M) <
      1 / (L.val : ℚ) := by
  rw [geometricPrimeTruncation_distance_of_le L M hLM]
  have hgeom := geom_sum_Ico' (x := (1 : ℚ) / 2) (by norm_num) hLM
  have hsum :
      (∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1)) =
        1 / (2 : ℚ) ^ L.val - 1 / (2 : ℚ) ^ M.val := by
    calc
      ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) =
          (1 / 2 : ℚ) * ∑ k ∈ Finset.Ico L.val M.val, ((1 : ℚ) / 2) ^ k := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro k hk
        rw [pow_succ]
        field_simp
        rw [← mul_pow]
        norm_num
      _ = 1 / (2 : ℚ) ^ L.val - 1 / (2 : ℚ) ^ M.val := by
        rw [hgeom]
        simp only [one_div, inv_pow]
        ring
  rw [hsum]
  have hMpositive : 0 < 1 / (2 : ℚ) ^ M.val := by positivity
  have hpow : (L.val : ℚ) ≤ (2 : ℚ) ^ L.val := by
    exact_mod_cast (Nat.lt_two_pow_self (n := L.val)).le
  have hLpositive : (0 : ℚ) < L.val := by exact_mod_cast L.property
  have hpowPositive : (0 : ℚ) < (2 : ℚ) ^ L.val := by positivity
  have hinv : 1 / (2 : ℚ) ^ L.val ≤ 1 / (L.val : ℚ) := by
    exact one_div_le_one_div_of_le hLpositive hpow
  linarith

/-- 幾何級数打ち切り列は、有限和差量について Cauchy である。 -/
theorem geometricPrimeTruncation_cauchy :
    RationalLogVectorCauchy geometricPrimeTruncation := by
  intro ε hε
  obtain ⟨L₀, htail⟩ := positiveIntegerReciprocal_rationallyConverges ε hε
  refine ⟨L₀, ?_⟩
  intro L M hL hM
  rcases le_total L.val M.val with hLM | hML
  · exact (geometricPrimeTruncation_distance_lt_reciprocal L M hLM).trans_le
      (le_of_lt (by simpa using htail L hL))
  · have hsymmetric :
        rationalLogVectorFiniteSumDistance
            (geometricPrimeTruncation L) (geometricPrimeTruncation M) =
          rationalLogVectorFiniteSumDistance
            (geometricPrimeTruncation M) (geometricPrimeTruncation L) := by
      rw [rationalLogVectorFiniteSumDistance, rationalLogVectorFiniteSumDistance,
        Finset.union_comm]
      apply Finset.sum_congr rfl
      intro p hp
      exact abs_sub_comm _ _
    rw [hsymmetric]
    exact (geometricPrimeTruncation_distance_lt_reciprocal M L hML).trans_le
      (le_of_lt (by simpa using htail M hM))

/-- 有限和差量は差ベクトルの台上の絶対値和に一致する。 -/
theorem rationalLogVectorFiniteSumDistance_eq_support_sum (a b : RationalLogVector) :
    rationalLogVectorFiniteSumDistance a b =
      (a - b).support.sum fun p => |(a - b) p| := by
  classical
  rw [rationalLogVectorFiniteSumDistance]
  symm
  apply Finset.sum_subset Finsupp.support_sub
  intro p hpUnion hpNotSupport
  rw [Finsupp.notMem_support_iff.mp hpNotSupport]
  simp

/-- 任意の一係数の絶対差は有限和差量以下である。 -/
theorem coefficient_abs_le_finiteSumDistance (a b : RationalLogVector) (p : Prime) :
    |a p - b p| ≤ rationalLogVectorFiniteSumDistance a b := by
  classical
  by_cases hp : p ∈ (a - b).support
  · rw [rationalLogVectorFiniteSumDistance_eq_support_sum]
    exact Finset.single_le_sum (fun q _ => abs_nonneg ((a - b) q)) hp
  · have hzero : a p - b p = 0 := by
      simpa using Finsupp.notMem_support_iff.mp hp
    rw [hzero, abs_zero]
    exact rationalLogVectorFiniteSumDistance_nonnegative a b

/-- 幾何級数打ち切り列は、どの有限台有理素数ベクトルにも収束しない。 -/
theorem geometricPrimeTruncation_no_finiteSupport_limit :
    ¬ ∃ a : RationalLogVector,
      RationalLogVectorConverges geometricPrimeTruncation a := by
  classical
  rintro ⟨a, ha⟩
  have hmissing : ∃ k ∈ Finset.range (a.support.card + 1),
      increasingPrimeIndex k ∉ a.support := by
    by_contra h
    push_neg at h
    have hsubset :
        (Finset.range (a.support.card + 1)).image increasingPrimeIndex ⊆ a.support := by
      intro p hp
      obtain ⟨k, hk, rfl⟩ := Finset.mem_image.mp hp
      exact h k hk
    have hcard := Finset.card_le_card hsubset
    rw [Finset.card_image_iff.mpr
      (Set.injOn_of_injective increasingPrimeIndex_injective)] at hcard
    simp at hcard
  obtain ⟨k, hkRange, hp⟩ := hmissing
  let p : Prime := increasingPrimeIndex k
  have hkPrime : increasingPrimeIndex k = p := rfl
  let ε : ℚ := 1 / (2 : ℚ) ^ (k + 1)
  have hε : 0 < ε := by positivity
  obtain ⟨L₀, htail⟩ := ha ε hε
  let L : PositiveStage := ⟨max L₀.val (k + 1), by omega⟩
  have hL₀ : L₀.val ≤ L.val := by simp [L]
  have hkL : k < L.val := by simp [L]
  have hlt := htail L hL₀
  have hcoefficient : geometricPrimeTruncation L p = ε := by
    rw [← hkPrime, geometricPrimeTruncation_apply_index]
    simp [hkL, ε]
  have hap : a p = 0 := Finsupp.notMem_support_iff.mp hp
  have hle := coefficient_abs_le_finiteSumDistance (geometricPrimeTruncation L) a p
  rw [hcoefficient, hap, sub_zero, abs_of_pos hε] at hle
  exact (not_lt_of_ge hle) hlt

/-! ## 互いに漸近一致しない Cauchy 列の非可算族 -/

/-- 二つの有限和差量 Cauchy 列が、正有理数の全許容誤差について漸近一致する。 -/
def RationalLogVectorAsymptoticallyAgrees
    (d e : PositiveStage → RationalLogVector) : Prop :=
  ∀ ε : ℚ, 0 < ε → ∃ L₀ : PositiveStage,
    ∀ L : PositiveStage, L₀.val ≤ L.val →
      rationalLogVectorFiniteSumDistance (d L) (e L) < ε

/-- 二元状態を有理係数零または一へ送る。 -/
def stateRationalWeight : State → ℚ
  | State.zero => 0
  | State.one => 1

theorem stateRationalWeight_nonnegative (a : State) : 0 ≤ stateRationalWeight a := by
  cases a <;> simp [stateRationalWeight]

theorem stateRationalWeight_le_one (a : State) : stateRationalWeight a ≤ 1 := by
  cases a <;> simp [stateRationalWeight]

/-- 二元列に従い、最初の `L` 個の素数へ零または `2^-(k+1)` を置く有限打ち切り。 -/
noncomputable def binaryGeometricPrimeTruncation
    (b : ℕ → State) (L : PositiveStage) : RationalLogVector :=
  (Finset.range L.val).sum fun k =>
    Finsupp.single (increasingPrimeIndex k)
      (stateRationalWeight (b k) / (2 : ℚ) ^ (k + 1))

theorem binaryGeometricPrimeTruncation_apply_index
    (b : ℕ → State) (L : PositiveStage) (k : ℕ) :
    binaryGeometricPrimeTruncation b L (increasingPrimeIndex k) =
      if k < L.val then stateRationalWeight (b k) / (2 : ℚ) ^ (k + 1) else 0 := by
  classical
  simp [binaryGeometricPrimeTruncation, Finsupp.single_apply,
    increasingPrimeIndex_injective.eq_iff]

theorem binaryGeometricPrimeTruncation_support_subset
    (b : ℕ → State) (L : PositiveStage) :
    (binaryGeometricPrimeTruncation b L).support ⊆
      (Finset.range L.val).image increasingPrimeIndex := by
  classical
  intro p hp
  have hpRange : p.val ∈ Set.range (Nat.nth Nat.Prime) := by
    rw [Nat.range_nth_of_infinite Nat.infinite_setOf_prime]
    exact p.property
  obtain ⟨k, hk⟩ := hpRange
  have hkPrime : increasingPrimeIndex k = p := by
    apply Subtype.ext
    exact hk
  have hnonzero := Finsupp.mem_support_iff.mp hp
  rw [← hkPrime, binaryGeometricPrimeTruncation_apply_index] at hnonzero
  have hkL : k < L.val := by
    by_contra hnot
    simp [hnot] at hnonzero
  exact Finset.mem_image.mpr ⟨k, Finset.mem_range.mpr hkL, hkPrime⟩

/-- 小段階から大段階への二元打ち切りの差量は、完全な幾何級数尾以下である。 -/
theorem binaryGeometricPrimeTruncation_distance_le_full_tail
    (b : ℕ → State) (L M : PositiveStage) (hLM : L.val ≤ M.val) :
    rationalLogVectorFiniteSumDistance
        (binaryGeometricPrimeTruncation b L) (binaryGeometricPrimeTruncation b M) ≤
      ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) := by
  classical
  rw [rationalLogVectorFiniteSumDistance]
  let fullSupport := (Finset.range M.val).image increasingPrimeIndex
  have hLsupport : (binaryGeometricPrimeTruncation b L).support ⊆ fullSupport := by
    exact (binaryGeometricPrimeTruncation_support_subset b L).trans
      (Finset.image_mono increasingPrimeIndex (Finset.range_mono hLM))
  have hMsupport : (binaryGeometricPrimeTruncation b M).support ⊆ fullSupport :=
    binaryGeometricPrimeTruncation_support_subset b M
  have hunion :
      (binaryGeometricPrimeTruncation b L).support ∪
          (binaryGeometricPrimeTruncation b M).support ⊆ fullSupport :=
    Finset.union_subset hLsupport hMsupport
  calc
    ∑ p ∈ (binaryGeometricPrimeTruncation b L).support ∪
          (binaryGeometricPrimeTruncation b M).support,
        |binaryGeometricPrimeTruncation b L p - binaryGeometricPrimeTruncation b M p| ≤
        ∑ p ∈ fullSupport,
          |binaryGeometricPrimeTruncation b L p - binaryGeometricPrimeTruncation b M p| := by
      exact Finset.sum_le_sum_of_subset_of_nonneg hunion
        (fun p hp hnot => abs_nonneg _)
    _ = ∑ k ∈ Finset.range M.val,
          |binaryGeometricPrimeTruncation b L (increasingPrimeIndex k) -
            binaryGeometricPrimeTruncation b M (increasingPrimeIndex k)| := by
      rw [Finset.sum_image (Set.injOn_of_injective increasingPrimeIndex_injective)]
    _ ≤ ∑ k ∈ Finset.range M.val,
          if L.val ≤ k then 1 / (2 : ℚ) ^ (k + 1) else 0 := by
      apply Finset.sum_le_sum
      intro k hk
      have hkM : k < M.val := Finset.mem_range.mp hk
      rw [binaryGeometricPrimeTruncation_apply_index,
        binaryGeometricPrimeTruncation_apply_index]
      by_cases hkL : k < L.val
      · simp [hkL, hkM, Nat.not_le.mpr hkL]
      · cases hbk : b k <;>
          simp [hkL, hkM, Nat.le_of_not_gt hkL, stateRationalWeight]
    _ = ∑ k ∈ (Finset.range M.val).filter (fun k => L.val ≤ k),
          1 / (2 : ℚ) ^ (k + 1) := by
      rw [Finset.sum_filter]
    _ = ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) := by
      congr 1
      ext k
      simp [Finset.mem_Ico, and_comm]

/-- 各二元列が定める有限打ち切り列は Cauchy である。 -/
theorem binaryGeometricPrimeTruncation_cauchy (b : ℕ → State) :
    RationalLogVectorCauchy (binaryGeometricPrimeTruncation b) := by
  intro ε hε
  obtain ⟨L₀, htail⟩ := positiveIntegerReciprocal_rationallyConverges ε hε
  refine ⟨L₀, ?_⟩
  intro L M hL hM
  rcases le_total L.val M.val with hLM | hML
  · calc
      rationalLogVectorFiniteSumDistance
          (binaryGeometricPrimeTruncation b L) (binaryGeometricPrimeTruncation b M) ≤
          ∑ k ∈ Finset.Ico L.val M.val, 1 / (2 : ℚ) ^ (k + 1) :=
        binaryGeometricPrimeTruncation_distance_le_full_tail b L M hLM
      _ = rationalLogVectorFiniteSumDistance
          (geometricPrimeTruncation L) (geometricPrimeTruncation M) :=
        (geometricPrimeTruncation_distance_of_le L M hLM).symm
      _ < 1 / (L.val : ℚ) := geometricPrimeTruncation_distance_lt_reciprocal L M hLM
      _ < ε := by simpa using htail L hL
  · have hsymmetric :
        rationalLogVectorFiniteSumDistance
            (binaryGeometricPrimeTruncation b L) (binaryGeometricPrimeTruncation b M) =
          rationalLogVectorFiniteSumDistance
            (binaryGeometricPrimeTruncation b M) (binaryGeometricPrimeTruncation b L) := by
      rw [rationalLogVectorFiniteSumDistance, rationalLogVectorFiniteSumDistance,
        Finset.union_comm]
      apply Finset.sum_congr rfl
      intro p hp
      exact abs_sub_comm _ _
    rw [hsymmetric]
    calc
      rationalLogVectorFiniteSumDistance
          (binaryGeometricPrimeTruncation b M) (binaryGeometricPrimeTruncation b L) ≤
          ∑ k ∈ Finset.Ico M.val L.val, 1 / (2 : ℚ) ^ (k + 1) :=
        binaryGeometricPrimeTruncation_distance_le_full_tail b M L hML
      _ = rationalLogVectorFiniteSumDistance
          (geometricPrimeTruncation M) (geometricPrimeTruncation L) :=
        (geometricPrimeTruncation_distance_of_le M L hML).symm
      _ < 1 / (M.val : ℚ) := geometricPrimeTruncation_distance_lt_reciprocal M L hML
      _ < ε := by simpa using htail M hM

/-- 相異なる二元列の打ち切り列は、相違座標の正有理下界を保つため漸近一致しない。 -/
theorem binaryGeometricPrimeTruncation_not_asymptotically_agree
    {b c : ℕ → State} (hbc : b ≠ c) :
    ¬ RationalLogVectorAsymptoticallyAgrees
      (binaryGeometricPrimeTruncation b) (binaryGeometricPrimeTruncation c) := by
  intro hagree
  have hexists : ∃ k : ℕ, b k ≠ c k := by
    simpa [Function.ne_iff] using hbc
  obtain ⟨k, hk⟩ := hexists
  let ε : ℚ := 1 / (2 : ℚ) ^ (k + 1)
  have hε : 0 < ε := by positivity
  obtain ⟨L₀, htail⟩ := hagree ε hε
  let L : PositiveStage := ⟨max L₀.val (k + 1), by omega⟩
  have hL₀ : L₀.val ≤ L.val := by simp [L]
  have hkL : k < L.val := by simp [L]
  have hlt := htail L hL₀
  have hcoefficient :
      |binaryGeometricPrimeTruncation b L (increasingPrimeIndex k) -
        binaryGeometricPrimeTruncation c L (increasingPrimeIndex k)| = ε := by
    rw [binaryGeometricPrimeTruncation_apply_index,
      binaryGeometricPrimeTruncation_apply_index]
    simp only [if_pos hkL]
    cases hb : b k <;> cases hc : c k <;> simp_all [stateRationalWeight, ε]
  have hle := coefficient_abs_le_finiteSumDistance
    (binaryGeometricPrimeTruncation b L) (binaryGeometricPrimeTruncation c L)
    (increasingPrimeIndex k)
  rw [hcoefficient] at hle
  exact (not_lt_of_ge hle) hlt

/-- 有限和差量 Cauchy 列の型。 -/
def RationalLogVectorCauchySequence :=
  {d : PositiveStage → RationalLogVector // RationalLogVectorCauchy d}

/-- 二元列が定める Cauchy 列。 -/
noncomputable def binaryCauchySequence (b : ℕ → State) :
    RationalLogVectorCauchySequence :=
  ⟨binaryGeometricPrimeTruncation b, binaryGeometricPrimeTruncation_cauchy b⟩

theorem binaryCauchySequence_injective : Function.Injective binaryCauchySequence := by
  intro b c hequal
  by_contra hbc
  have hnot := binaryGeometricPrimeTruncation_not_asymptotically_agree hbc
  apply hnot
  intro ε hε
  refine ⟨⟨1, by decide⟩, ?_⟩
  intro L hL
  have hfunctions := congrArg Subtype.val hequal
  change binaryGeometricPrimeTruncation b = binaryGeometricPrimeTruncation c at hfunctions
  rw [congrFun hfunctions L]
  simpa [rationalLogVectorFiniteSumDistance] using hε

/-- 二元列から構成した有限和差量 Cauchy 列だけからなる族。 -/
def BinaryCauchySequenceFamily :=
  {d : RationalLogVectorCauchySequence // d ∈ Set.range binaryCauchySequence}

/-- 各二元列を、そこから構成した Cauchy 列の族へ送る。 -/
noncomputable def binaryCauchySequenceFamilyElement (b : ℕ → State) :
    BinaryCauchySequenceFamily :=
  ⟨binaryCauchySequence b, ⟨b, rfl⟩⟩

theorem binaryCauchySequenceFamilyElement_injective :
    Function.Injective binaryCauchySequenceFamilyElement := by
  intro b c hequal
  apply binaryCauchySequence_injective
  exact congrArg (fun d : BinaryCauchySequenceFamily => d.val) hequal

/-- 構成した族の相異なる二列は漸近一致しない。 -/
theorem binaryCauchySequenceFamily_pairwise_not_asymptotically_agree
    (d e : BinaryCauchySequenceFamily) (hde : d ≠ e) :
    ¬ RationalLogVectorAsymptoticallyAgrees d.val.val e.val.val := by
  obtain ⟨b, hb⟩ := d.property
  obtain ⟨c, hc⟩ := e.property
  have hbc : b ≠ c := by
    intro h
    apply hde
    apply Subtype.ext
    exact hb.symm.trans ((congrArg binaryCauchySequence h).trans hc)
  rw [← hb, ← hc]
  exact binaryGeometricPrimeTruncation_not_asymptotically_agree hbc

/-- 二元列の全体が単射されるため、構成した Cauchy 列の族は非可算である。 -/
theorem binaryCauchySequenceFamily_uncountable :
    Uncountable BinaryCauchySequenceFamily := by
  have hbinary : Uncountable (ℕ → State) := by
    letI : Nonempty (ℕ → State) := ⟨fun _ => State.zero⟩
    rw [uncountable_iff_forall_not_surjective]
    intro q hsurjective
    let diagonal : ℕ → State := fun n => nu (q n n)
    obtain ⟨n, hn⟩ := hsurjective diagonal
    have hat := congrFun hn n
    cases hstate : q n n <;> simp_all [diagonal, nu]
  letI : Uncountable (ℕ → State) := hbinary
  exact binaryCauchySequenceFamilyElement_injective.uncountable

end

end CellularAutomata.CyclicStageLogarithmicDensity
