/-
正本: content/cyclic-stage-local-agreement.ts の具体版。

有限巡回舞台を ZMod L、整数からの比較写像を整数キャストとして固定し、
加法保存・群法則・全射性・有限窓での完全一致を本文と同じ順序で示す。
同じ有限巡回舞台上の二元配位に真理値表が定める自己写像を固定し、
反復不動点数の自然数値列と、正値の段階だけに定義した素因数指数ベクトル値列を作る。

有限型・整数・自然数・有理数・有限台整数ベクトルだけを使う。
実数体・複素数体、全配位の逆極限、極限値、規格化、収束は使わない。
-/
import CellularAutomata.CyclicRuleRestriction
import CellularAutomata.NecSuf.PeriodicPointCount
import CellularAutomata.PrimeLogarithm

namespace CellularAutomata.CyclicStageLocalAgreement

open CellularAutomata.EssentialDependency
open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.NecSuf.PeriodicPointCount

noncomputable section

/-- 正の周期で添字づけるための有限巡回舞台サイズ。 -/
abbrev PositiveStage := {L : ℕ // 0 < L}

instance (L : PositiveStage) : NeZero L.val := ⟨L.property.ne'⟩

/-- 周期 L の有限巡回舞台。 -/
abbrev Stage (L : PositiveStage) := ZMod L.val

/-- 整数を周期 L の有限巡回舞台へ送る比較写像。 -/
def projection (L : PositiveStage) (z : ℤ) : Stage L := z

/-- 比較写像は整数の加法を有限巡回舞台の加法へ移す。 -/
theorem projection_preserves_addition (L : PositiveStage) (z w : ℤ) :
    projection L (z + w) = projection L z + projection L w := by
  exact Int.cast_add z w

/-- 有限巡回舞台の加法は、整数の加法から一段ずつ群法則を受け取る。 -/
theorem stage_group_laws (L : PositiveStage) (a b c : Stage L) :
    (a + b) + c = a + (b + c) ∧
      0 + a = a ∧ a + 0 = a ∧ a + (-a) = 0 ∧ (-a) + a = 0 := by
  constructor
  · exact add_assoc a b c
  constructor
  · exact zero_add a
  constructor
  · exact add_zero a
  constructor
  · exact add_neg_cancel a
  · exact neg_add_cancel a

/-- 比較写像は全射であり、従って一の像が有限巡回舞台を生成する。 -/
theorem projection_surjective (L : PositiveStage) : Function.Surjective (projection L) := by
  exact ZMod.intCast_surjective

/-- 有限巡回舞台の元数は周期 L である。 -/
theorem stage_card (L : PositiveStage) : Fintype.card (Stage L) = L.val := by
  exact ZMod.card L.val

/-- 有限窓上で有限巡回舞台が定める等号関係。 -/
def finiteWindowRelation (L : PositiveStage) (s : ℕ) : Set (Offset s × Offset s) :=
  {jk | projection L (signedOffset s jk.1) = projection L (signedOffset s jk.2)}

/-- 同じ有限窓上で整数が定める等号関係。 -/
def integerWindowRelation (s : ℕ) : Set (Offset s × Offset s) :=
  {jk | signedOffset s jk.1 = signedOffset s jk.2}

/-- 周期が窓幅以上なら、二つの有限な等号関係は完全に一致する。 -/
theorem finite_window_exact_agreement (L : PositiveStage) (s : ℕ)
    (hwidth : 2 * s + 1 ≤ L.val) :
    finiteWindowRelation L s = integerWindowRelation s := by
  have hinjective : Function.Injective (fun j : Offset s =>
      projection L (signedOffset s j)) := by
    intro j k hjk
    apply cyclicProjection_injective_of_width_le L.val s (0 : ZMod L.val) hwidth
    simpa [projection, cyclicProjection] using hjk
  ext jk
  simp only [finiteWindowRelation, integerWindowRelation, Set.mem_setOf_eq]
  constructor
  · intro hjk
    exact congrArg (signedOffset s) (hinjective hjk)
  · intro hjk
    exact congrArg (projection L) hjk

/-- 有限窓の等号関係が各半径で安定する、本文の局所収束の定義。 -/
def LocallyConverges : Prop :=
  ∀ s : ℕ, ∃ L₀ : PositiveStage, ∀ L : PositiveStage,
    L₀.val ≤ L.val → finiteWindowRelation L s = integerWindowRelation s

/-- 有限巡回舞台の族は、安定段階 `2s+1` により整数舞台へ局所収束する。 -/
theorem stage_family_locally_converges : LocallyConverges := by
  intro s
  let L₀ : PositiveStage := ⟨2 * s + 1, by omega⟩
  refine ⟨L₀, ?_⟩
  intro L hL
  exact finite_window_exact_agreement L s hL

/-- 半径と、その有限窓上の二元状態表からなる有限局所観測の総体。 -/
def FiniteObservationCatalogue := Σ s : ℕ, Offset s → State

/-- 半径 `s` の有限局所観測は `2^(2s+1)` 個である。 -/
theorem finite_observation_stage_card (s : ℕ) :
    Fintype.card (Offset s → State) = 2 ^ (2 * s + 1) := by
  rw [Fintype.card_fun, card_state]
  rfl

/-- 自然数で添字づけた有限局所観測の総体は高々可算である。 -/
theorem finite_observation_catalogue_countable : Countable FiniteObservationCatalogue := by
  infer_instance

/-- 各有限段階の比較写像は整数全体では単射でない。 -/
theorem projection_not_injective (L : PositiveStage) :
    ¬ Function.Injective (projection L) := by
  intro hinjective
  have heq : projection L 0 = projection L (L.val : ℤ) := by
    simp [projection]
  have hzero : (0 : ℤ) = (L.val : ℤ) := hinjective heq
  have hpositive : (0 : ℤ) < (L.val : ℤ) := by exact_mod_cast L.property
  exact (ne_of_lt hpositive) hzero

/-- 一つの有限真理値表が周期 L の舞台に定める大域自己写像。 -/
def stageMap (L : PositiveStage) (r : ℕ) (g : (Offset r → State) → State) :
    (Stage L → State) → (Stage L → State) :=
  globalRealizedMap (fun v => cyclicProjection L.val r v) g

/-- 固定した規則と反復回数について、各有限段階の反復不動点数。 -/
def fixedPointCountSequence (r : ℕ) (g : (Offset r → State) → State) (n : ℕ)
    (L : PositiveStage) : ℕ :=
  fixedPointCount (stageMap L r g) n

/-- 不動点数が正である有限巡回段階だけを残した定義域。 -/
def PositiveCountStage (r : ℕ) (g : (Offset r → State) → State) (n : ℕ) :=
  {L : PositiveStage // 0 < fixedPointCountSequence r g n L}

/-- 正の有限巡回段階だけに定義する素因数指数ベクトル値の列。 -/
def logarithmicCountSequence (r : ℕ) (g : (Offset r → State) → State) (n : ℕ)
    (L : PositiveCountStage r g n) : PrimeLogarithm.LogVector :=
  PrimeLogarithm.logarithm
    (PrimeLogarithm.positiveNat (fixedPointCountSequence r g n L.val) L.property)

/-- 対数順序群値列の各項は、その段階の正の不動点数の素因数指数ベクトルである。 -/
theorem logarithmicCountSequence_apply (r : ℕ) (g : (Offset r → State) → State) (n : ℕ)
    (L : PositiveCountStage r g n) (p : PrimeLogarithm.Prime) :
    logarithmicCountSequence r g n L p =
      ((fixedPointCountSequence r g n L.val).factorization p.val : ℤ) := by
  exact PrimeLogarithm.logarithm_nat_apply
    (fixedPointCountSequence r g n L.val) L.property p

end

end CellularAutomata.CyclicStageLocalAgreement
