/-
章「有限巡回舞台の族と有限段階の量の列」の Lean 必要十分版。

必要な構造の検査結果:
  - 比較写像の加法保存には、始域と終域の加法と保存則だけを要る。
  - 終域の群法則には加法群だけを要り、有限性、巡回性、整数剰余は要らない。
  - 有限窓上の等号関係の一致は、その窓上の比較写像の単射性と同値である。
    窓の有限性はこの同値には要らない。
  - 大域非単射には、相異なる二元が同じ像を持つことだけを要る。
  - 正値域と素因数指数ベクトル値列には、添字集合上の自然数値写像だけを要る。
    添字集合の有限性、二値状態、局所規則、反復、群構造は要らない。
  - 有限性は具体版の舞台元数と不動点の有限走査にだけ残る。
  実数体、複素数体、全配位の逆極限、規格化、極限、収束は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement

namespace CellularAutomata.NecSuf.CyclicStageLocalAgreement

universe uS uT uD uC uI

/-- 加法を持つ二つの型の間で、比較写像が加法を保存するという最小の仮定。 -/
theorem projection_preserves_addition
    {S : Type uS} {T : Type uT} [Add S] [Add T]
    (q : S → T) (hadd : ∀ a b, q (a + b) = q a + q b) (a b : S) :
    q (a + b) = q a + q b :=
  hadd a b

/-- 終域の群法則には加法群構造だけが要る。 -/
theorem additive_group_laws {T : Type uT} [AddGroup T] (a b c : T) :
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

/-- 比較写像が有限窓へ引き戻す等号関係。有限性は定義に要らない。 -/
def PulledBackEquality {D : Type uD} {C : Type uC} (q : D → C) : Set (D × D) :=
  {jk | q jk.1 = q jk.2}

/-- 有限窓自身の等号関係。有限性は定義に要らない。 -/
def NativeEquality {D : Type uD} : Set (D × D) :=
  {jk | jk.1 = jk.2}

/-- 引き戻した等号関係が元の等号と一致するための必要十分条件は比較写像の単射性である。 -/
theorem pulledBackEquality_eq_nativeEquality_iff_injective
    {D : Type uD} {C : Type uC} (q : D → C) :
    PulledBackEquality q = NativeEquality ↔ Function.Injective q := by
  constructor
  · intro h a b hab
    have hpull : (a, b) ∈ PulledBackEquality q := hab
    have hnative : (a, b) ∈ NativeEquality := by simpa [h] using hpull
    exact hnative
  · intro hinjective
    ext jk
    simp only [PulledBackEquality, NativeEquality, Set.mem_setOf_eq]
    constructor
    · intro h
      exact hinjective h
    · intro h
      exact congrArg q h

/-- 相異なる二元が同じ像を持てば比較写像は単射でない。 -/
theorem not_injective_of_collision
    {D : Type uD} {C : Type uC} (q : D → C) {a b : D}
    (hne : a ≠ b) (hcollision : q a = q b) : ¬ Function.Injective q := by
  intro hinjective
  exact hne (hinjective hcollision)

/-- 自然数値写像が正になる添字だけを残した定義域。 -/
def PositiveCountIndex {I : Type uI} (count : I → ℕ) :=
  {i : I // 0 < count i}

/-- 正値域だけに定義する素因数指数ベクトル値写像。 -/
noncomputable def logarithmicCountSequence {I : Type uI} (count : I → ℕ)
    (i : PositiveCountIndex count) : PrimeLogarithm.LogVector :=
  PrimeLogarithm.logarithm (PrimeLogarithm.positiveNat (count i.val) i.property)

/-- 対数順序群値写像の各素数成分は自然数値の素因数指数である。 -/
theorem logarithmicCountSequence_apply {I : Type uI} (count : I → ℕ)
    (i : PositiveCountIndex count) (p : PrimeLogarithm.Prime) :
    logarithmicCountSequence count i p = ((count i.val).factorization p.val : ℤ) := by
  exact PrimeLogarithm.logarithm_nat_apply (count i.val) i.property p

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.CyclicRuleRestriction
open CellularAutomata.CyclicStageLocalAgreement
open CellularAutomata.EssentialDependency

/-- 具体版の加法保存は、加法と保存則だけを使う一般主張の特殊化である。 -/
theorem projection_preserves_addition_of_necSuf
    (L : PositiveStage) (z w : ℤ) :
    projection L (z + w) = projection L z + projection L w :=
  projection_preserves_addition (projection L)
    (CellularAutomata.CyclicStageLocalAgreement.projection_preserves_addition L) z w

/-- 具体版の群法則は有限性を使わない加法群法則の特殊化である。 -/
theorem stage_group_laws_of_necSuf (L : PositiveStage) (a b c : Stage L) :
    (a + b) + c = a + (b + c) ∧
      0 + a = a ∧ a + 0 = a ∧ a + (-a) = 0 ∧ (-a) + a = 0 :=
  additive_group_laws a b c

/-- 具体版の有限窓一致は、窓上の比較写像の単射性が必要十分であることの特殊化である。 -/
theorem finite_window_exact_agreement_of_necSuf
    (L : PositiveStage) (s : ℕ) (hwidth : 2 * s + 1 ≤ L.val) :
    finiteWindowRelation L s = integerWindowRelation s := by
  have hinjective : Function.Injective (fun j : Offset s =>
      projection L (signedOffset s j)) := by
    intro j k hjk
    apply cyclicProjection_injective_of_width_le L.val s (0 : ZMod L.val) hwidth
    simpa [projection, cyclicProjection] using hjk
  have hfinite : finiteWindowRelation L s = NativeEquality := by
    change PulledBackEquality (fun j : Offset s => projection L (signedOffset s j)) =
      NativeEquality
    exact (pulledBackEquality_eq_nativeEquality_iff_injective _).2 hinjective
  calc
    finiteWindowRelation L s = NativeEquality := hfinite
    _ = integerWindowRelation s := by
      ext jk
      simp only [NativeEquality, integerWindowRelation, Set.mem_setOf_eq]
      constructor
      · intro h
        exact congrArg (signedOffset s) h
      · intro h
        exact signedOffset_injective s h

/-- 具体版の大域非単射は、零と周期が衝突するという一つの証人だけから従う。 -/
theorem projection_not_injective_of_necSuf (L : PositiveStage) :
    ¬ Function.Injective (projection L) := by
  apply not_injective_of_collision (projection L)
    (a := (0 : ℤ)) (b := (L.val : ℤ))
  · exact ne_of_lt (by exact_mod_cast L.property)
  · simp [projection]

/-- 具体版の素因数指数ベクトル値列は、任意の自然数値写像に対する一般構成の特殊化である。 -/
theorem logarithmicCountSequence_apply_of_necSuf
    (r : ℕ) (g : (Offset r → State) → State) (n : ℕ)
    (L : PositiveCountStage r g n) (p : PrimeLogarithm.Prime) :
    CellularAutomata.CyclicStageLocalAgreement.logarithmicCountSequence r g n L p =
      ((fixedPointCountSequence r g n L.val).factorization p.val : ℤ) := by
  exact logarithmicCountSequence_apply (fixedPointCountSequence r g n)
    ⟨L.val, L.property⟩ p

end Derivation

end CellularAutomata.NecSuf.CyclicStageLocalAgreement
