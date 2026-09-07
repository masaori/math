/-
章「有限巡回舞台の族・局所収束・有限段階の量の列」の Lean 必要十分版。

必要な構造の検査結果:
  - 比較写像の加法保存には、始域と終域の加法と保存則だけを要る。
  - 終域の群法則には加法群だけを要り、有限性、巡回性、整数剰余は要らない。
  - 有限窓上の等号関係の一致は、その窓上の比較写像の単射性と同値である。
    窓の有限性はこの同値には要らない。
  - 大域非単射には、相異なる二元が同じ像を持つことだけを要る。
  - 正値域と素因数指数ベクトル値列には、添字集合上の自然数値写像だけを要る。
    添字集合の有限性、二値状態、局所規則、反復、群構造は要らない。
  - 局所収束には、窓の添字、段階の添字、段階の前後関係、各窓上の二つの関係が
    最終的に一致することだけを要る。有限性、距離、誤差、群構造は要らない。
  - 有限局所観測の総体が高々可算であることには、添字型の可算性と各繊維の有限性だけを要る。
    添字が自然数であること、繊維が二元状態表であることは要らない。
  - 近傍間の全単射不在には二つの有限型の元数が異なることだけを要る。
  - 写像が目標と異なることには、目標に属し写像に属さない一元だけを要る。
  - 局所入力型の元数には、近傍型と状態型の有限性、および有限関数表を
    列挙するための近傍型の等号判定だけを要る。
    状態が二値であることや、近傍が同じ舞台の部分集合であることは要らない。
  - 有限性は具体版の舞台元数と不動点の有限走査にだけ残る。
  実数体、複素数体、全配位の逆極限、規格化、極限、収束は使わない。
-/
import CellularAutomata.CyclicStageLocalAgreement

namespace CellularAutomata.NecSuf.CyclicStageLocalAgreement

universe uS uT uD uC uI uR uStage uW uO

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

/-- 窓ごとの関係が、段階の前後関係に沿って最終的に極限側の関係と一致すること。 -/
def EventuallyAgrees
    {R : Type uR} {StageIndex : Type uStage} (Window : R → Type uW)
    (atOrBeyond : StageIndex → StageIndex → Prop)
    (stageRelation : (i : StageIndex) → (r : R) → Set (Window r × Window r))
    (limitRelation : (r : R) → Set (Window r × Window r)) : Prop :=
  ∀ r : R, ∃ i₀ : StageIndex, ∀ i : StageIndex,
    atOrBeyond i₀ i → stageRelation i r = limitRelation r

/-- 最終一致の定義は、窓ごとに安定段階が存在するという量化条件と必要十分である。 -/
theorem eventuallyAgrees_iff
    {R : Type uR} {StageIndex : Type uStage} (Window : R → Type uW)
    (atOrBeyond : StageIndex → StageIndex → Prop)
    (stageRelation : (i : StageIndex) → (r : R) → Set (Window r × Window r))
    (limitRelation : (r : R) → Set (Window r × Window r)) :
    EventuallyAgrees Window atOrBeyond stageRelation limitRelation ↔
      ∀ r : R, ∃ i₀ : StageIndex, ∀ i : StageIndex,
        atOrBeyond i₀ i → stageRelation i r = limitRelation r := by
  rfl

/-- 窓ごとに安定段階と、それ以後の関係一致を与えれば最終一致が従う。 -/
theorem eventuallyAgrees_of_witness
    {R : Type uR} {StageIndex : Type uStage} (Window : R → Type uW)
    (atOrBeyond : StageIndex → StageIndex → Prop)
    (stageRelation : (i : StageIndex) → (r : R) → Set (Window r × Window r))
    (limitRelation : (r : R) → Set (Window r × Window r))
    (witness : R → StageIndex)
    (hagrees : ∀ r i, atOrBeyond (witness r) i → stageRelation i r = limitRelation r) :
    EventuallyAgrees Window atOrBeyond stageRelation limitRelation := by
  intro r
  exact ⟨witness r, fun i hi => hagrees r i hi⟩

/-- 可算な添字に有限な繊維を載せた、有限局所観測の一般形。 -/
def ObservationCatalogue {R : Type uR} (Observation : R → Type uO) :=
  Σ r : R, Observation r

/-- 可算個の有限繊維の非交和は高々可算である。 -/
theorem observationCatalogue_countable
    {R : Type uR} [Countable R] (Observation : R → Type uO)
    [∀ r : R, Finite (Observation r)] :
    Countable (ObservationCatalogue Observation) := by
  change Countable (Σ r : R, Observation r)
  letI (r : R) : Countable (Observation r) := Finite.to_countable
  infer_instance

/-! ### 一般の舞台で失われる近傍輸送に必要な構造 -/

/-- 二つの有限型の元数が異なれば、それらの間に全単射は存在しない。 -/
theorem no_bijection_of_card_ne
    {S : Type uS} {T : Type uT} [Fintype S] [Fintype T]
    (hcard : Fintype.card S ≠ Fintype.card T) :
    ¬ ∃ h : S → T, Function.Bijective h := by
  rintro ⟨h, hb⟩
  exact hcard (Fintype.card_congr (Equiv.ofBijective h hb))

/-- 目標に属し写像に属さない元があれば、写像と目標は等しくない。 -/
theorem image_ne_target_of_witness
    {V : Type uS} [DecidableEq V] (source target : Finset V) (transport : V → V)
    {w : V} (htarget : w ∈ target) (himage : w ∉ source.image transport) :
    source.image transport ≠ target := by
  intro h
  apply himage
  rw [h]
  exact htarget

/-- 有限な近傍型から有限な状態型への局所入力型の元数。 -/
theorem localInput_card
    {N : Type uS} {A : Type uT} [Fintype N] [DecidableEq N] [Fintype A] :
    Fintype.card (N → A) = Fintype.card A ^ Fintype.card N := by
  exact Fintype.card_fun

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

/-- 具体版の局所収束は、窓ごとの最終一致だけを使う一般主張の特殊化である。 -/
theorem stage_family_locally_converges_of_necSuf :
    CellularAutomata.CyclicStageLocalAgreement.LocallyConverges := by
  change EventuallyAgrees (fun s : ℕ => Offset s)
    (fun L₀ L : PositiveStage => L₀.val ≤ L.val)
    (fun L s => finiteWindowRelation L s) integerWindowRelation
  apply eventuallyAgrees_of_witness
    (fun s : ℕ => Offset s)
    (fun L₀ L : PositiveStage => L₀.val ≤ L.val)
    (fun L s => finiteWindowRelation L s) integerWindowRelation
    (fun s => ⟨2 * s + 1, by omega⟩)
  intro s L hL
  exact CellularAutomata.CyclicStageLocalAgreement.finite_window_exact_agreement L s hL

/-- 具体版の有限局所観測総体の可算性は、可算添字と有限繊維だけを使う一般主張の特殊化である。 -/
theorem finite_observation_catalogue_countable_of_necSuf :
    Countable CellularAutomata.CyclicStageLocalAgreement.FiniteObservationCatalogue := by
  change Countable (ObservationCatalogue (fun s : ℕ => Offset s → State))
  exact observationCatalogue_countable (fun s : ℕ => Offset s → State)

/-- 具体版の近傍間の全単射不在は、二つの近傍型の元数の差だけから従う。 -/
theorem no_bare_neighborhood_bijection_of_necSuf :
    ¬ ∃ h : (↥(bareNeighborhood bareU)) → (↥(bareNeighborhood bareV)),
      Function.Bijective h := by
  apply no_bijection_of_card_ne
  simpa [bare_neighborhood_u_card, bare_neighborhood_v_card]

/-- 具体版の近傍非保存は、目標にだけ属するセル `u` を証人とする。 -/
theorem bare_swap_not_neighborhood_preserving_of_necSuf :
    (bareNeighborhood bareU).image bareSwap ≠ bareNeighborhood (bareSwap bareU) := by
  apply image_ne_target_of_witness
    (bareNeighborhood bareU) (bareNeighborhood (bareSwap bareU)) bareSwap
    (w := bareU)
  · rw [bare_swap_target_u]
    simp
  · rw [bare_swap_image_u]
    decide

/-- 小さい近傍の具体的な局所入力数は、有限関数型の一般式の特殊化である。 -/
theorem bare_local_input_u_card_of_necSuf :
    Fintype.card (↥(bareNeighborhood bareU) → State) = 2 := by
  rw [localInput_card, card_state]
  simp [bare_neighborhood_u_card]

/-- 大きい近傍の具体的な局所入力数は、有限関数型の一般式の特殊化である。 -/
theorem bare_local_input_v_card_of_necSuf :
    Fintype.card (↥(bareNeighborhood bareV) → State) = 4 := by
  rw [localInput_card, card_state]
  simp [bare_neighborhood_v_card]

/-- 局所入力間の全単射不在も、二つの関数型の元数の差だけから従う。 -/
theorem no_bare_local_input_bijection_of_necSuf :
    ¬ ∃ h : (↥(bareNeighborhood bareU) → State) →
        (↥(bareNeighborhood bareV) → State), Function.Bijective h := by
  apply no_bijection_of_card_ne
  rw [bare_local_input_u_card_of_necSuf, bare_local_input_v_card_of_necSuf]
  decide

end Derivation

end CellularAutomata.NecSuf.CyclicStageLocalAgreement
