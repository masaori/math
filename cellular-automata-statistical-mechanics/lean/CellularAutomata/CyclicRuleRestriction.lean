/-
正本: content/cyclic-rule-restriction.ts の具体版。

def_cyclic_admissible_inputs                 → AdmissibleInput
def_cyclic_input_pullback                    → pullback
claim_cyclic_input_pullback_bijection        → pullbackEquiv
claim_cyclic_input_realization               → realized_inputs
def_cyclic_uniform_rule_map                  → realizedMap
claim_cyclic_rule_global_equality の局所核    → realizedMap_eq_iff_restriction
claim_cyclic_admissible_input_count           → card_admissible_inputs
claim_cyclic_rule_table_count                 → card_truth_tables
def_cyclic_uniform_rule_map の全セル版        → globalRealizedMap
claim_cyclic_rule_global_equality              → globalRealizedMap_eq_iff_restriction

有限巡回舞台の各セルで整数オフセットを射影した写像を q として固定する。
このファイルは本文の証明が q の有限像と同じ像を持つオフセットの一致だけを使う部分を、
演算を持たない二元状態 State 上で同じ順序により形式化する。整数剰余による q 自体の算術は
content/cyclic-offset-projection.ts の別の主張であり、このファイルでは仮定として一般化しない。
全セルの射影 q_v が同じ衝突関係を持つことを仮定し、その条件から局所核を
全セルの大域写像の等号へ接着するところまでを形式化する。整数剰余射影が実際にこの仮定を
満たすこと、射影算術と残る個数公式は後半へ残す。

住処は有限型と自然数だけであり、実数体・複素数体は現れない。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import CellularAutomata.EssentialDependency

namespace CellularAutomata.CyclicRuleRestriction

open CellularAutomata.EssentialDependency

noncomputable section

variable {D C : Type} [Fintype D] [DecidableEq D] [Fintype C] [DecidableEq C]

/-- オフセット射影 q の有限像 M。 -/
def Image (q : D → C) := {w : C // ∃ j : D, q j = w}

instance (q : D → C) : DecidableEq (Image q) := Classical.decEq (Image q)

instance (q : D → C) : Fintype (Image q) := by
  classical
  exact Fintype.ofFinset (Finset.univ.image q) (fun w => by
    change w ∈ Finset.univ.image q ↔ ∃ j : D, q j = w
    simp)

/-- 周期境界と両立する入力。同じセルへ射影されるオフセットの値は一致する。 -/
def AdmissibleInput (q : D → C) :=
  {a : D → State // ∀ j k : D, q j = q k → a j = a k}

instance (q : D → C) : Fintype (AdmissibleInput q) := by
  classical
  exact Fintype.ofFinset
    (Finset.univ.filter (fun a : D → State => ∀ j k : D, q j = q k → a j = a k))
    (fun a => by
      change a ∈ Finset.univ.filter (fun b : D → State =>
        ∀ j k : D, q j = q k → b j = b k) ↔
        ∀ j k : D, q j = q k → a j = a k
      simp)

/-- 像 M 上の値をオフセット入力へ戻す写像 U。 -/
def pullback (q : D → C) (y : Image q → State) : AdmissibleInput q :=
  ⟨fun j => y ⟨q j, ⟨j, rfl⟩⟩, fun j k hjk => by
    apply congrArg y
    exact Subtype.ext hjk⟩

/-- 各像 w に対して、その像を持つオフセットを一つ選ぶ。本文の最小代表 s_v に対応する。 -/
noncomputable def representative (q : D → C) (w : Image q) : D :=
  Classical.choose w.property

theorem representative_projects (q : D → C) (w : Image q) :
    q (representative q w) = w.val :=
  Classical.choose_spec w.property

/-- 両立入力を像 M 上の値へ戻す写像 T。 -/
noncomputable def descend (q : D → C) (a : AdmissibleInput q) : Image q → State :=
  fun w => a.val (representative q w)

theorem pullback_descend (q : D → C) (a : AdmissibleInput q) :
    pullback q (descend q a) = a := by
  apply Subtype.ext
  funext j
  exact a.property (representative q ⟨q j, ⟨j, rfl⟩⟩) j
    (representative_projects q ⟨q j, ⟨j, rfl⟩⟩)

theorem descend_pullback (q : D → C) (y : Image q → State) :
    descend q (pullback q y) = y := by
  funext w
  apply congrArg y
  apply Subtype.ext
  exact representative_projects q w

/-- 実現可能入力と重複を除いた近傍値の全単射。 -/
noncomputable def pullbackEquiv (q : D → C) :
    (Image q → State) ≃ AdmissibleInput q where
  toFun := pullback q
  invFun := descend q
  left_inv := descend_pullback q
  right_inv := pullback_descend q

/-- 像の外を状態零で埋め、像上の値を全配位へ延長する。零は演算ではなく State の一要素である。 -/
noncomputable def extendConfiguration (q : D → C) (y : Image q → State) : C → State :=
  fun w => if h : ∃ j : D, q j = w then y ⟨w, h⟩ else State.zero

theorem extendConfiguration_on_image (q : D → C) (y : Image q → State) (j : D) :
    extendConfiguration q y (q j) = y ⟨q j, ⟨j, rfl⟩⟩ := by
  simp [extendConfiguration]

/-- 両立入力は全配位から得られる入力を尽くす。 -/
theorem realized_inputs (q : D → C) :
    Set.range (fun x : C → State => fun j => x (q j)) =
      {a : D → State | ∀ j k, q j = q k → a j = a k} := by
  ext a
  constructor
  · rintro ⟨x, rfl⟩ j k hjk
    exact congrArg x hjk
  · intro ha
    let aa : AdmissibleInput q := ⟨a, ha⟩
    let y : Image q → State := descend q aa
    refine ⟨extendConfiguration q y, ?_⟩
    funext j
    calc
      extendConfiguration q y (q j) = y ⟨q j, ⟨j, rfl⟩⟩ :=
        extendConfiguration_on_image q y j
      _ = (pullback q y).val j := rfl
      _ = aa.val j := congrFun (congrArg Subtype.val (pullback_descend q aa)) j
      _ = a j := rfl

/-- オフセット表 g が有限舞台上で実現する写像。 -/
def realizedMap (q : D → C) (g : (D → State) → State) : (C → State) → State :=
  fun x => g (fun j => x (q j))

/-- 表の両立入力上の制限。 -/
def SameRestriction (q : D → C) (g h : (D → State) → State) : Prop :=
  ∀ a : AdmissibleInput q, g a.val = h a.val

/-- 実現写像の等号は両立入力上の表の等号と同値である。 -/
theorem realizedMap_eq_iff_restriction (q : D → C)
    (g h : (D → State) → State) :
    realizedMap q g = realizedMap q h ↔ SameRestriction q g h := by
  constructor
  · intro hmap a
    let y : Image q → State := descend q a
    let x : C → State := extendConfiguration q y
    have hinput : (fun j => x (q j)) = a.val := by
      funext j
      calc
        x (q j) = y ⟨q j, ⟨j, rfl⟩⟩ := extendConfiguration_on_image q y j
        _ = (pullback q y).val j := rfl
        _ = a.val j := congrFun (congrArg Subtype.val (pullback_descend q a)) j
    have hx := congrFun hmap x
    simpa [realizedMap, hinput] using hx
  · intro hrestriction
    funext x
    let a : AdmissibleInput q :=
      ⟨fun j => x (q j), fun j k hjk => congrArg x hjk⟩
    exact hrestriction a

/-- 各セル v のオフセット射影 q v を一つの局所表へ入れて得る大域写像。 -/
def globalRealizedMap (q : C → D → C) (g : (D → State) → State) :
    (C → State) → (C → State) :=
  fun x v => g (fun j => x (q v j))

/-- 全セルの射影が基準セルと同じオフセット衝突関係を持つという仮定。 -/
def SameCollisionRelation (q : C → D → C) (v₀ : C) : Prop :=
  ∀ v j k, q v j = q v k ↔ q v₀ j = q v₀ k

/--
全セルの射影が同じ衝突関係を持つなら、大域写像の等号は基準セルの両立入力上の
表制限の等号と同値である。前向きは基準セルでの評価、後ろ向きは各セルの入力を
共通の両立入力へ移すという、本文と同じ順序で示す。
-/
theorem globalRealizedMap_eq_iff_restriction (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀)
    (g h : (D → State) → State) :
    globalRealizedMap q g = globalRealizedMap q h ↔
      SameRestriction (q v₀) g h := by
  constructor
  · intro hglobal
    apply (realizedMap_eq_iff_restriction (q v₀) g h).mp
    funext x
    exact congrFun (congrFun hglobal x) v₀
  · intro hrestriction
    funext x v
    let a : AdmissibleInput (q v₀) :=
      ⟨fun j => x (q v j), fun j k hjk => congrArg x ((hcollision v j k).mpr hjk)⟩
    exact hrestriction a

/-- 両立入力上の表を、両立しない入力では状態零として全入力へ延長する。 -/
noncomputable def extendRestriction (q₀ : D → C)
    (b : AdmissibleInput q₀ → State) : (D → State) → State :=
  fun a => if ha : ∀ j k, q₀ j = q₀ k → a j = a k then b ⟨a, ha⟩ else State.zero

theorem extendRestriction_on_admissible (q₀ : D → C)
    (b : AdmissibleInput q₀ → State) (a : AdmissibleInput q₀) :
    extendRestriction q₀ b a.val = b a := by
  unfold extendRestriction
  rw [dif_pos a.property]
  congr

/-- 大域写像を基準セルで実現した配位に評価し、両立入力上の表へ戻す。 -/
noncomputable def restrictGlobalMap (q : C → D → C) (v₀ : C)
    (F : (C → State) → (C → State)) : AdmissibleInput (q v₀) → State :=
  fun a => F (extendConfiguration (q v₀) (descend (q v₀) a)) v₀

theorem restrictGlobalMap_of_realized (q : C → D → C) (v₀ : C)
    (g : (D → State) → State) (a : AdmissibleInput (q v₀)) :
    restrictGlobalMap q v₀ (globalRealizedMap q g) a = g a.val := by
  change g (fun j => extendConfiguration (q v₀) (descend (q v₀) a) (q v₀ j)) = g a.val
  congr 1
  funext j
  calc
    extendConfiguration (q v₀) (descend (q v₀) a) (q v₀ j) =
        (descend (q v₀) a) ⟨q v₀ j, ⟨j, rfl⟩⟩ :=
      extendConfiguration_on_image (q v₀) (descend (q v₀) a) j
    _ = (pullback (q v₀) (descend (q v₀) a)).val j := rfl
    _ = a.val j := congrFun (congrArg Subtype.val (pullback_descend (q v₀) a)) j

/-- 与えた一様局所表から実現される大域写像全体。 -/
def GlobalRealizedMap (q : C → D → C) :=
  {F : (C → State) → (C → State) // ∃ g : (D → State) → State,
    globalRealizedMap q g = F}

noncomputable instance (q : C → D → C) : Fintype (GlobalRealizedMap q) := by
  classical
  change Fintype {F : (C → State) → (C → State) //
    ∃ g : (D → State) → State, globalRealizedMap q g = F}
  exact Fintype.ofFinset
    (Finset.univ.filter (fun F : (C → State) → (C → State) =>
      ∃ g : (D → State) → State, globalRealizedMap q g = F))
    (fun F => by
      change F ∈ Finset.univ.filter (fun H : (C → State) → (C → State) =>
        ∃ g : (D → State) → State, globalRealizedMap q g = H) ↔
        ∃ g : (D → State) → State, globalRealizedMap q g = F
      simp)

/--
同じ衝突関係を持つ全セル射影について、異なる大域写像は基準セルの両立入力上の
二元値表と全単射で対応する。
-/
noncomputable def restrictionGlobalEquiv (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) :
    (AdmissibleInput (q v₀) → State) ≃ GlobalRealizedMap q where
  toFun b :=
    ⟨globalRealizedMap q (extendRestriction (q v₀) b),
      ⟨extendRestriction (q v₀) b, rfl⟩⟩
  invFun F := restrictGlobalMap q v₀ F.val
  left_inv b := by
    funext a
    change restrictGlobalMap q v₀
      (globalRealizedMap q (extendRestriction (q v₀) b)) a = b a
    rw [restrictGlobalMap_of_realized]
    exact extendRestriction_on_admissible (q v₀) b a
  right_inv F := by
    apply Subtype.ext
    obtain ⟨g, hg⟩ := F.property
    change globalRealizedMap q
      (extendRestriction (q v₀) (restrictGlobalMap q v₀ F.val)) = F.val
    rw [← hg]
    apply (globalRealizedMap_eq_iff_restriction q v₀ hcollision _ _).mpr
    intro a
    rw [extendRestriction_on_admissible, restrictGlobalMap_of_realized]

/-- 実現可能入力は像 M 上の二元値写像と全単射なので 2^{|M|} 個である。 -/
theorem card_admissible_inputs (q : D → C) :
    Fintype.card (AdmissibleInput q) = 2 ^ Fintype.card (Image q) := by
  calc
    Fintype.card (AdmissibleInput q) = Fintype.card (Image q → State) :=
      Fintype.card_congr (pullbackEquiv q).symm
    _ = Fintype.card State ^ Fintype.card (Image q) := Fintype.card_fun
    _ = 2 ^ Fintype.card (Image q) := by rw [card_state]

/-- D 上の二元値真理値表は 2^{2^{|D|}} 個である。 -/
theorem card_truth_tables :
    Fintype.card ((D → State) → State) = 2 ^ (2 ^ Fintype.card D) := by
  rw [Fintype.card_fun, Fintype.card_fun, card_state]

/-- 異なる一様大域写像の個数は 2^{2^{|M|}} である。 -/
theorem card_global_realized_maps (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) :
    Fintype.card (GlobalRealizedMap q) = 2 ^ (2 ^ Fintype.card (Image (q v₀))) := by
  classical
  calc
    Fintype.card (GlobalRealizedMap q) =
        Fintype.card (AdmissibleInput (q v₀) → State) :=
      Fintype.card_congr (restrictionGlobalEquiv q v₀ hcollision).symm
    _ = Fintype.card State ^ Fintype.card (AdmissibleInput (q v₀)) := Fintype.card_fun
    _ = 2 ^ Fintype.card (AdmissibleInput (q v₀)) := by rw [card_state]
    _ = 2 ^ (2 ^ Fintype.card (Image (q v₀))) := by
      rw [card_admissible_inputs]

end

end CellularAutomata.CyclicRuleRestriction
