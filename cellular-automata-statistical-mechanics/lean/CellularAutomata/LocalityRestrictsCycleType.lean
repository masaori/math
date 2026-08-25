/-
章「局所性による巡回型の制限」の Lean 具体版。
人手証明の正本は structured-latex/content/locality-restricts-cycle-type.ts。

対応表（人手証明 → この file）
  def_stage_global_maps                                 `stageGlobalMaps`
  claim_stage_global_maps_count                         `localRuleFamily_injective`,
                                                        `card_stageGlobalMaps`
  def_stage_reversible_global_maps                      `stageReversibleGlobalMaps`
  def_stage_realized_cycle_types                        `realizedCycleTypes`
  def_self_neighborhood_stage                           `SelfCell`, `selfNbhd`
  claim_self_neighborhood_injective_iff_pointwise_bijective
                                                        `globalMap_self_apply`,
                                                        `selfGlobal_injective_iff`
  claim_self_neighborhood_involution                    `selfRule_eq_id_or_neg`,
                                                        `selfGlobal_involution`

この tick で形式化した範囲は上表までである。実現巡回型の決定
（claim_self_neighborhood_realized_cycle_types）と真部分集合性
（claim_locality_restricts_cycle_type）は未形式化である。

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。
抽象度は人手証明に固定する。
-/
import CellularAutomata.TimeExpansionDependency
import CellularAutomata.ReversibleGlobalMapCycleType

namespace CellularAutomata.LocalityRestrictsCycleType

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限舞台 (V, N) 上の局所規則の族（`def_finite_ca`）。 -/
abbrev LocalRuleFamily (N : V → Finset V) :=
  (v : V) → (↥(N v) → State) → State

/-- `claim_stage_global_maps_count` の前段。局所規則の族に大域写像を対応させる写像は単射である。
    人手証明と同じく、各 v と z ∈ A^{N(v)} について基準値延長 ι で証人配位 x を作り、
    ρ ∘ ι = id で f_v(z) を (F x)(v) へ書き換え、F = G で移してから戻す。 -/
theorem localRuleFamily_injective (N : V → Finset V) :
    Function.Injective (fun f : LocalRuleFamily N => globalMap N f) := by
  intro f g hfg
  have hfg' : globalMap N f = globalMap N g := hfg
  funext v z
  -- x := ι^V_{N(v)} z（`def_base_value_extension`）
  have hx : restrict (N v) (baseExtend (N v) z) = z := restrict_baseExtend (N v) z
  have h : globalMap N f (baseExtend (N v) z) v = globalMap N g (baseExtend (N v) z) v := by
    rw [hfg']
  -- (F x)(v) = f_v(ρ x) = f_v(z)（`def_global_map` と ρ ∘ ι = id）
  simpa [globalMap, hx] using h

/-- `def_stage_global_maps` の M(V,N)。局所規則の族の像として定める。 -/
noncomputable def stageGlobalMaps (N : V → Finset V) :
    Finset ((V → State) → (V → State)) := by
  classical
  exact Finset.univ.image (fun f : LocalRuleFamily N => globalMap N f)

/-- `claim_stage_global_maps_count` の後段。|M(V,N)| = ∏_v 2^{2^{|N(v)|}}。
    単射性から像の個数が定義域の個数に等しく、族の個数は各 v の局所真理値表の個数の積である。 -/
theorem card_stageGlobalMaps (N : V → Finset V) :
    (stageGlobalMaps N).card = ∏ v : V, 2 ^ 2 ^ (N v).card := by
  classical
  rw [stageGlobalMaps, Finset.card_image_of_injective _ (localRuleFamily_injective N),
    Finset.card_univ]
  rw [Fintype.card_pi]
  refine Finset.prod_congr rfl ?_
  intro v _
  rw [Fintype.card_fun, Fintype.card_fun, card_state, Fintype.card_coe]

/-- `def_stage_reversible_global_maps` の M^×(V,N)。 -/
noncomputable def stageReversibleGlobalMaps (N : V → Finset V) :
    Finset ((V → State) → (V → State)) := by
  classical
  exact (stageGlobalMaps N).filter (fun F => Function.Injective F)

/-- `def_stage_realized_cycle_types` の CT(V,N)。 -/
noncomputable def realizedCycleTypes (N : V → Finset V) : Set (Multiset ℕ) :=
  {m | ∃ F : ReversibleGlobalMapCycleType.ReversibleMap V,
        F.1 ∈ stageGlobalMaps N ∧ ReversibleGlobalMapCycleType.cycleType F = m}

/-- `def_self_neighborhood_stage` の舞台のセル集合 V• = {v₁, v₂, v₃}。 -/
abbrev SelfCell := Fin 3

/-- `def_self_neighborhood_stage` の近傍 N•(v) = {v}。 -/
def selfNbhd : SelfCell → Finset SelfCell := fun v => {v}

/-- 局所規則 f_v から `claim_self_neighborhood_injective_iff_pointwise_bijective` の
    値写像 g_v : A → A を作る。g_v(a) := f_v(z_a)、z_a(v) := a。 -/
def valueMap (f : LocalRuleFamily selfNbhd) (v : SelfCell) : State → State :=
  fun a => f v (fun _ => a)

/-- `claim_self_neighborhood_injective_iff_pointwise_bijective` の前段。
    (F y)(v) = g_v(y(v))。制限写像の値が y(v) であること（N•(v) = {v}）と外延性による。 -/
theorem globalMap_self_apply (f : LocalRuleFamily selfNbhd) (y : SelfCell → State)
    (v : SelfCell) : globalMap selfNbhd f y v = valueMap f v (y v) := by
  have h : restrict (selfNbhd v) y = fun _ => y v := by
    funext u
    have : u.val = v := Finset.mem_singleton.mp u.property
    simp [restrict, this]
  simp [globalMap, valueMap, h]

/-- `claim_self_neighborhood_injective_iff_pointwise_bijective` の本体。
    F が単射 ⟺ 全ての v で g_v が単射（A は有限なので単射と全単射は同値）。 -/
theorem selfGlobal_injective_iff (f : LocalRuleFamily selfNbhd) :
    Function.Injective (globalMap selfNbhd f) ↔
      ∀ v : SelfCell, Function.Injective (valueMap f v) := by
  constructor
  · -- F 単射 ⇒ g_v 単射。人手証明どおり ι で証人配位を作る。
    intro hF v a a' ha
    -- 証人配位 x := ι^{V•}_{{v}} z_a（`def_base_value_extension`）。x(v) = a、他のセルは 0。
    set x : SelfCell → State := baseExtend (selfNbhd v) (fun _ => a) with hxdef
    set x' : SelfCell → State := baseExtend (selfNbhd v) (fun _ => a') with hx'def
    have hxv : x v = a := by simp [hxdef, baseExtend, selfNbhd]
    have hx'v : x' v = a' := by simp [hx'def, baseExtend, selfNbhd]
    have hxu : ∀ u : SelfCell, u ≠ v → x u = x' u := by
      intro u hu
      simp [hxdef, hx'def, baseExtend, selfNbhd, hu]
    have hx : globalMap selfNbhd f x = globalMap selfNbhd f x' := by
      funext u
      rw [globalMap_self_apply, globalMap_self_apply]
      by_cases huv : u = v
      · subst huv; rw [hxv, hx'v]; exact ha
      · rw [hxu u huv]
    have hxx' := hF hx
    calc a = x v := hxv.symm
      _ = x' v := by rw [hxx']
      _ = a' := hx'v
  · -- 各 g_v 単射 ⇒ F 単射。
    intro hg y y' hyy
    funext v
    have := congrArg (fun z => z v) hyy
    rw [globalMap_self_apply, globalMap_self_apply] at this
    exact hg v this

/-- A 上の単射な自己写像は恒等写像か否定写像である（`claim_self_neighborhood_involution` の前段）。
    g(0) の値で場合分けし、単射性から残りの値が定まる。 -/
theorem selfRule_eq_id_or_neg {g : State → State} (hg : Function.Injective g) :
    g = id ∨ g = nu := by
  cases hg0 : g State.zero with
  | zero =>
      left
      funext a
      cases a with
      | zero => simpa using hg0
      | one =>
          cases hg1 : g State.one with
          | zero => exact absurd (hg (hg1.trans hg0.symm)) (by decide)
          | one => simpa using hg1
  | one =>
      right
      funext a
      cases a with
      | zero => simpa [nu] using hg0
      | one =>
          cases hg1 : g State.one with
          | zero => simpa [nu] using hg1
          | one => exact absurd (hg (hg1.trans hg0.symm)) (by decide)

/-- `claim_self_neighborhood_involution`。この舞台の可逆な大域写像は F² = id である。
    各 g_v が id か ν であり、どちらも g ∘ g = id であることから従う。 -/
theorem selfGlobal_involution (f : LocalRuleFamily selfNbhd)
    (hF : Function.Injective (globalMap selfNbhd f)) (y : SelfCell → State) :
    globalMap selfNbhd f (globalMap selfNbhd f y) = y := by
  funext v
  have hg : Function.Injective (valueMap f v) := (selfGlobal_injective_iff f).1 hF v
  rw [globalMap_self_apply, globalMap_self_apply]
  rcases selfRule_eq_id_or_neg hg with h | h
  · rw [h]; rfl
  · rw [h]; cases y v <;> rfl

end CellularAutomata.LocalityRestrictsCycleType
