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
def_integer_offset_interval                    → Offset, signedOffset
def_cyclic_offset_projection                   → cyclicProjection
claim_cyclic_offset_collision                  → cyclicProjection_collision_iff_dvd
claim_cyclic_offset_image_count                → card_cyclicProjection_image
claim_cyclic_offset_injective_boundary         → cyclicProjection_injective_iff
claim_cyclic_rule_realization_fiber_count      → card_cyclic_global_realization_fiber
def_cyclic_elementary_encoding                 → elementaryTable
claim_cyclic_elementary_encoding_bijection     → elementaryTable_bijective
claim_cyclic_radius_one_comparison              → elementaryGlobalRealizedMap_apply
claim_cyclic_radius_one_collapse                → card_radius_one_* / card_radius_one_fiber_*

有限巡回舞台の各セルで整数オフセットを射影した写像を q として固定する。
このファイルは本文の証明が q の有限像と同じ像を持つオフセットの一致だけを使う部分を、
演算を持たない二元状態 State 上で同じ順序により形式化する。整数剰余による q 自体の算術は
content/cyclic-offset-projection.ts の別の主張であり、このファイルでは仮定として一般化しない。
全セルの射影 q_v が同じ衝突関係を持つことを仮定し、その条件から局所核を
全セルの大域写像の等号へ接着する。後半で整数オフセットの具体的な巡回射影を定め、
衝突と周期整除の同値から、この共通衝突仮定と大域接着の特殊化を導く。
像の元数、単射境界、実現繊維の個数、初等規則番号と半径一比較までを
具体的な巡回射影について導く。

住処は有限型と自然数だけであり、実数体・複素数体は現れない。
-/
import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.ZMod.Basic
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
  exact Subtype.fintype _

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

/-- 単射な写像の定義域と像の間の全単射。 -/
noncomputable def imageEquivOfInjective (q : D → C) (hinj : Function.Injective q) :
    D ≃ Image q where
  toFun j := ⟨q j, ⟨j, rfl⟩⟩
  invFun := representative q
  left_inv j := hinj (representative_projects q ⟨q j, ⟨j, rfl⟩⟩)
  right_inv w := Subtype.ext (representative_projects q w)

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

/-- 周期境界と両立しないオフセット入力。 -/
def InadmissibleInput (q : D → C) :=
  {a : D → State // ¬ ∀ j k : D, q j = q k → a j = a k}

noncomputable instance (q : D → C) : Fintype (InadmissibleInput q) :=
  Subtype.fintype _

/-- 基準表 g と両立入力上で一致する表の繊維。 -/
def RestrictionFiber (q : D → C) (g : (D → State) → State) :=
  {h : (D → State) → State // SameRestriction q h g}

noncomputable instance (q : D → C) (g : (D → State) → State) :
    Fintype (RestrictionFiber q g) := by
  classical
  exact Subtype.fintype _

/-- 両立入力では g、両立しない入力では c を使って真理値表を貼り合わせる。 -/
noncomputable def extendInadmissibleTable (q : D → C) (g : (D → State) → State)
    (c : InadmissibleInput q → State) : (D → State) → State :=
  fun a => if ha : ∀ j k : D, q j = q k → a j = a k then g a else c ⟨a, ha⟩

/-- 基準表と同じ制限を持つ表は、両立しない入力上の値と全単射で対応する。 -/
noncomputable def inadmissibleTableEquivRestrictionFiber (q : D → C)
    (g : (D → State) → State) :
    (InadmissibleInput q → State) ≃ RestrictionFiber q g where
  toFun c := ⟨extendInadmissibleTable q g c, fun a => by
    simp only [extendInadmissibleTable, dif_pos a.property]⟩
  invFun h a := h.val a.val
  left_inv c := by
    funext a
    simp only [extendInadmissibleTable, dif_neg a.property]
    apply congrArg c
    exact Subtype.ext rfl
  right_inv h := by
    apply Subtype.ext
    funext a
    by_cases ha : ∀ j k : D, q j = q k → a j = a k
    · simpa only [extendInadmissibleTable, dif_pos ha] using (h.property ⟨a, ha⟩).symm
    · simp only [extendInadmissibleTable, dif_neg ha]

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

/-- 基準表 g と同じ大域写像を与えるオフセット表の繊維。 -/
def GlobalRealizationFiber (q : C → D → C) (g : (D → State) → State) :=
  {h : (D → State) → State // globalRealizedMap q h = globalRealizedMap q g}

noncomputable instance (q : C → D → C) (g : (D → State) → State) :
    Fintype (GlobalRealizationFiber q g) := by
  classical
  exact Subtype.fintype _

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

/-- 共通の衝突関係の下で、大域実現繊維と制限繊維は同じ表を台に持つ全単射である。 -/
noncomputable def globalFiberEquivRestrictionFiber (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) (g : (D → State) → State) :
    GlobalRealizationFiber q g ≃ RestrictionFiber (q v₀) g where
  toFun h := ⟨h.val,
    (globalRealizedMap_eq_iff_restriction q v₀ hcollision h.val g).mp h.property⟩
  invFun h := ⟨h.val,
    (globalRealizedMap_eq_iff_restriction q v₀ hcollision h.val g).mpr h.property⟩
  left_inv h := Subtype.ext rfl
  right_inv h := Subtype.ext rfl

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

/-- 同じ制限を持つ表の個数は、両立しない入力への自由な二元値割り当ての個数である。 -/
theorem card_restriction_fiber (q : D → C) (g : (D → State) → State) :
    Fintype.card (RestrictionFiber q g) =
      2 ^ (2 ^ Fintype.card D - 2 ^ Fintype.card (Image q)) := by
  classical
  have hcomplement : Fintype.card (InadmissibleInput q) =
      Fintype.card (D → State) - Fintype.card (AdmissibleInput q) := by
    exact Fintype.card_subtype_compl
      (fun a : D → State => ∀ j k : D, q j = q k → a j = a k)
  calc
    Fintype.card (RestrictionFiber q g) =
        Fintype.card (InadmissibleInput q → State) :=
      Fintype.card_congr (inadmissibleTableEquivRestrictionFiber q g).symm
    _ = Fintype.card State ^ Fintype.card (InadmissibleInput q) := Fintype.card_fun
    _ = 2 ^ Fintype.card (InadmissibleInput q) := by rw [card_state]
    _ = 2 ^ (Fintype.card (D → State) - Fintype.card (AdmissibleInput q)) := by
      rw [hcomplement]
    _ = 2 ^ (2 ^ Fintype.card D - 2 ^ Fintype.card (Image q)) := by
      rw [Fintype.card_fun, card_state, card_admissible_inputs]

/-- 同じ大域写像を与える表の個数を、オフセット数と射影像の元数で数える。 -/
theorem card_global_realization_fiber (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) (g : (D → State) → State) :
    Fintype.card (GlobalRealizationFiber q g) =
      2 ^ (2 ^ Fintype.card D - 2 ^ Fintype.card (Image (q v₀))) := by
  calc
    Fintype.card (GlobalRealizationFiber q g) =
        Fintype.card (RestrictionFiber (q v₀) g) :=
      Fintype.card_congr (globalFiberEquivRestrictionFiber q v₀ hcollision g)
    _ = 2 ^ (2 ^ Fintype.card D - 2 ^ Fintype.card (Image (q v₀))) :=
      card_restriction_fiber (q v₀) g

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

/-- 半径 r の整数オフセットを -r,…,r の順で持つ有限添字型。 -/
abbrev Offset (r : ℕ) := Fin (2 * r + 1)

/-- 有限添字を実際の整数オフセット -r,…,r へ送る。 -/
def signedOffset (r : ℕ) (j : Offset r) : ℤ := (j.val : ℤ) - (r : ℤ)

theorem signedOffset_mem_interval (r : ℕ) (j : Offset r) :
    -(r : ℤ) ≤ signedOffset r j ∧ signedOffset r j ≤ (r : ℤ) := by
  have hj := j.isLt
  simp only [signedOffset]
  omega

theorem signedOffset_injective (r : ℕ) : Function.Injective (signedOffset r) := by
  intro j k h
  apply Fin.ext
  simp only [signedOffset] at h
  omega

/-- 周期 L の巡回舞台で、セル v から整数オフセットを見た射影。 -/
def cyclicProjection (L r : ℕ) [NeZero L] (v : ZMod L) (j : Offset r) : ZMod L :=
  v + (signedOffset r j : ZMod L)

/--
同じセルへ射影されることは、二つの整数オフセットの差が周期 L で
整除されることと同値である。セル位置 v は両辺から消去される。
-/
theorem cyclicProjection_collision_iff_dvd (L r : ℕ) [NeZero L]
    (v : ZMod L) (j k : Offset r) :
    cyclicProjection L r v j = cyclicProjection L r v k ↔
      (L : ℤ) ∣ signedOffset r j - signedOffset r k := by
  rw [cyclicProjection, cyclicProjection, add_left_cancel_iff]
  constructor
  · intro h
    have hd : (L : ℤ) ∣ signedOffset r k - signedOffset r j :=
      (ZMod.intCast_eq_intCast_iff_dvd_sub (signedOffset r j) (signedOffset r k) L).mp h
    simpa only [neg_sub] using hd.neg_right
  · intro hd
    apply (ZMod.intCast_eq_intCast_iff_dvd_sub (signedOffset r j) (signedOffset r k) L).mpr
    simpa only [neg_sub] using hd.neg_right

/-- オフセット数が周期以下なら、巡回射影は単射である。 -/
theorem cyclicProjection_injective_of_width_le (L r : ℕ) [NeZero L]
    (v : ZMod L) (hwidth : 2 * r + 1 ≤ L) :
    Function.Injective (cyclicProjection L r v) := by
  intro j k hjk
  have hd : (L : ℤ) ∣ signedOffset r j - signedOffset r k :=
    (cyclicProjection_collision_iff_dvd L r v j k).mp hjk
  have hj := signedOffset_mem_interval r j
  have hk := signedOffset_mem_interval r k
  have habs : |signedOffset r j - signedOffset r k| < (L : ℤ) := by
    rw [abs_lt]
    omega
  have hzero : signedOffset r j - signedOffset r k = 0 :=
    Int.eq_zero_of_abs_lt_dvd hd habs
  exact signedOffset_injective r (sub_eq_zero.mp hzero)

/-- 巡回射影の像の元数は、周期とオフセット数の小さい方である。 -/
theorem card_cyclicProjection_image (L r : ℕ) [NeZero L] (v : ZMod L) :
    Fintype.card (Image (cyclicProjection L r v)) = min L (2 * r + 1) := by
  by_cases hwidth : 2 * r + 1 ≤ L
  · have hinj := cyclicProjection_injective_of_width_le L r v hwidth
    have hcard : Fintype.card (Image (cyclicProjection L r v)) =
        Fintype.card (Offset r) := by
      exact Fintype.card_congr (imageEquivOfInjective (cyclicProjection L r v) hinj).symm
    simpa [Nat.min_eq_right hwidth] using hcard
  · have hperiod : L < 2 * r + 1 := Nat.lt_of_not_ge hwidth
    let firstPeriod : Fin L → Image (cyclicProjection L r v) := fun i =>
      ⟨cyclicProjection L r v ⟨i.val, i.isLt.trans hperiod⟩,
        ⟨⟨i.val, i.isLt.trans hperiod⟩, rfl⟩⟩
    have hfirst : Function.Injective firstPeriod := by
      intro i k hik
      have hprojection :
          cyclicProjection L r v ⟨i.val, i.isLt.trans hperiod⟩ =
            cyclicProjection L r v ⟨k.val, k.isLt.trans hperiod⟩ :=
        congrArg Subtype.val hik
      have hd : (L : ℤ) ∣
          signedOffset r ⟨i.val, i.isLt.trans hperiod⟩ -
            signedOffset r ⟨k.val, k.isLt.trans hperiod⟩ :=
        (cyclicProjection_collision_iff_dvd L r v _ _).mp hprojection
      have habs :
          |signedOffset r ⟨i.val, i.isLt.trans hperiod⟩ -
            signedOffset r ⟨k.val, k.isLt.trans hperiod⟩| < (L : ℤ) := by
        simp only [signedOffset]
        rw [abs_lt]
        omega
      have hzero :
          signedOffset r ⟨i.val, i.isLt.trans hperiod⟩ -
            signedOffset r ⟨k.val, k.isLt.trans hperiod⟩ = 0 :=
        Int.eq_zero_of_abs_lt_dvd hd habs
      apply Fin.ext
      simp only [signedOffset] at hzero
      omega
    have hlower : L ≤ Fintype.card (Image (cyclicProjection L r v)) := by
      simpa using Fintype.card_le_of_injective firstPeriod hfirst
    have hupper : Fintype.card (Image (cyclicProjection L r v)) ≤ L := by
      simpa using Fintype.card_le_of_injective
        (fun w : Image (cyclicProjection L r v) => w.val) Subtype.val_injective
    have hcard : Fintype.card (Image (cyclicProjection L r v)) = L :=
      Nat.le_antisymm hupper hlower
    simpa [Nat.min_eq_left hperiod.le] using hcard

/-- オフセットの巡回射影が単射であるための必要十分条件。 -/
theorem cyclicProjection_injective_iff (L r : ℕ) [NeZero L] (v : ZMod L) :
    Function.Injective (cyclicProjection L r v) ↔ 2 * r + 1 ≤ L := by
  constructor
  · intro hinj
    have hcard : Fintype.card (Image (cyclicProjection L r v)) =
        Fintype.card (Offset r) := by
      exact Fintype.card_congr (imageEquivOfInjective (cyclicProjection L r v) hinj).symm
    rw [card_cyclicProjection_image] at hcard
    simpa using hcard
  · exact cyclicProjection_injective_of_width_le L r v

/-- 巡回舞台のオフセット衝突関係は基準セルの選び方に依存しない。 -/
theorem cyclicProjection_same_collision (L r : ℕ) [NeZero L] (v₀ : ZMod L) :
    SameCollisionRelation (fun v => cyclicProjection L r v) v₀ := by
  intro v j k
  rw [cyclicProjection_collision_iff_dvd, cyclicProjection_collision_iff_dvd]

/-- 具体的な巡回射影では、大域写像の等号を基準セルの両立入力上で判定できる。 -/
theorem cyclicGlobalRealizedMap_eq_iff_restriction (L r : ℕ) [NeZero L]
    (v₀ : ZMod L) (g h : (Offset r → State) → State) :
    globalRealizedMap (fun v => cyclicProjection L r v) g =
        globalRealizedMap (fun v => cyclicProjection L r v) h ↔
      SameRestriction (cyclicProjection L r v₀) g h :=
  globalRealizedMap_eq_iff_restriction
    (fun v => cyclicProjection L r v) v₀ (cyclicProjection_same_collision L r v₀) g h

/-- 具体的な巡回射影が実現する異なる大域写像の個数。 -/
theorem card_cyclic_global_realized_maps (L r : ℕ) [NeZero L] (v₀ : ZMod L) :
    Fintype.card (GlobalRealizedMap (fun v => cyclicProjection L r v)) =
      2 ^ (2 ^ min L (2 * r + 1)) := by
  rw [card_global_realized_maps
    (fun v => cyclicProjection L r v) v₀ (cyclicProjection_same_collision L r v₀)]
  rw [card_cyclicProjection_image]

/-- 具体的な巡回射影で同じ大域写像を与えるオフセット表の個数。 -/
theorem card_cyclic_global_realization_fiber (L r : ℕ) [NeZero L]
    (v₀ : ZMod L) (g : (Offset r → State) → State) :
    Fintype.card
      (GlobalRealizationFiber (fun v => cyclicProjection L r v) g) =
        2 ^ (2 ^ (2 * r + 1) - 2 ^ min L (2 * r + 1)) := by
  rw [card_global_realization_fiber
    (fun v => cyclicProjection L r v) v₀ (cyclicProjection_same_collision L r v₀) g]
  rw [Fintype.card_fin, card_cyclicProjection_image]

/-- 演算を持たない二元状態を、初等規則番号の二進桁を読むための自然数へ送る。 -/
def stateNat : State → ℕ
  | State.zero => 0
  | State.one => 1

/-- 自然数の偶奇を二元状態へ戻す。 -/
def parityState (n : ℕ) : State :=
  if n % 2 = 0 then State.zero else State.one

/-- 半径一の左・自身・右の状態を三桁の二進数へ送る。 -/
def elementaryInputIndex (a : Offset 1 → State) : ℕ :=
  4 * stateNat (a ⟨0, by decide⟩) +
    2 * stateNat (a ⟨1, by decide⟩) +
      stateNat (a ⟨2, by decide⟩)

/-- 初等規則番号 R の k(a) 桁目を読んだ半径一のオフセット表。 -/
def elementaryTable (R : Fin 256) : (Offset 1 → State) → State :=
  fun a => parityState (R.val / 2 ^ elementaryInputIndex a)

/-- 半径一表の八つの出力桁を二進数として再合成する。 -/
def elementaryRuleNumberValue (g : (Offset 1 → State) → State) : ℕ :=
  ∑ a : Offset 1 → State, stateNat (g a) * 2 ^ elementaryInputIndex a

/-- 半径一表の二進桁を再合成した初等規則番号。 -/
def elementaryRuleNumber (g : (Offset 1 → State) → State) : Fin 256 :=
  ⟨elementaryRuleNumberValue g % 256, Nat.mod_lt _ (by decide)⟩

/-- 桁の取り出しと再合成を相互逆として持つ明示的な全単射。 -/
def elementaryTableEquiv : Fin 256 ≃ ((Offset 1 → State) → State) where
  toFun := elementaryTable
  invFun := elementaryRuleNumber
  left_inv := by native_decide
  right_inv := by native_decide

/-- 0,…,255 の初等規則番号と半径一の二元値表は全単射で対応する。 -/
theorem elementaryTable_bijective : Function.Bijective elementaryTable := by
  exact elementaryTableEquiv.bijective

/-- 半径一の大域写像は、左・自身・右の三値から読んだ規則番号の桁に等しい。 -/
theorem elementaryGlobalRealizedMap_apply (L : ℕ) [NeZero L] (R : Fin 256)
    (x : ZMod L → State) (v : ZMod L) :
    globalRealizedMap (fun w => cyclicProjection L 1 w) (elementaryTable R) x v =
      parityState (R.val / 2 ^
        (4 * stateNat (x (v - 1)) + 2 * stateNat (x v) + stateNat (x (v + 1)))) := by
  simp [globalRealizedMap, elementaryTable, elementaryInputIndex, cyclicProjection,
    signedOffset, sub_eq_add_neg]

/-- 一セル巡回舞台の半径一表が実現する大域写像は 4 個である。 -/
theorem card_radius_one_global_maps_one_cell :
    Fintype.card (GlobalRealizedMap
      (fun v : ZMod 1 => cyclicProjection 1 1 v)) = 4 := by
  simpa using card_cyclic_global_realized_maps 1 1 (0 : ZMod 1)

/-- 二セル巡回舞台の半径一表が実現する大域写像は 16 個である。 -/
theorem card_radius_one_global_maps_two_cells :
    Fintype.card (GlobalRealizedMap
      (fun v : ZMod 2 => cyclicProjection 2 1 v)) = 16 := by
  simpa using card_cyclic_global_realized_maps 2 1 (0 : ZMod 2)

/-- 三セル以上では半径一表 256 個が相異な大域写像を与える。 -/
theorem card_radius_one_global_maps_of_three_le (L : ℕ) [NeZero L]
    (hL : 3 ≤ L) (v₀ : ZMod L) :
    Fintype.card (GlobalRealizedMap
      (fun v : ZMod L => cyclicProjection L 1 v)) = 256 := by
  rw [card_cyclic_global_realized_maps L 1 v₀]
  simp [Nat.min_eq_right hL]

/-- 一セル巡回舞台で同じ大域写像を与える半径一表は 64 個である。 -/
theorem card_radius_one_fiber_one_cell (g : (Offset 1 → State) → State) :
    Fintype.card (GlobalRealizationFiber
      (fun v : ZMod 1 => cyclicProjection 1 1 v) g) = 64 := by
  simpa using card_cyclic_global_realization_fiber 1 1 (0 : ZMod 1) g

/-- 二セル巡回舞台で同じ大域写像を与える半径一表は 16 個である。 -/
theorem card_radius_one_fiber_two_cells (g : (Offset 1 → State) → State) :
    Fintype.card (GlobalRealizationFiber
      (fun v : ZMod 2 => cyclicProjection 2 1 v) g) = 16 := by
  simpa using card_cyclic_global_realization_fiber 2 1 (0 : ZMod 2) g

/-- 三セル以上では半径一の大域実現繊維は一元集合である。 -/
theorem card_radius_one_fiber_of_three_le (L : ℕ) [NeZero L]
    (hL : 3 ≤ L) (v₀ : ZMod L) (g : (Offset 1 → State) → State) :
    Fintype.card (GlobalRealizationFiber
      (fun v : ZMod L => cyclicProjection L 1 v) g) = 1 := by
  rw [card_cyclic_global_realization_fiber L 1 v₀ g]
  simp [Nat.min_eq_right hL]

end

end CellularAutomata.CyclicRuleRestriction
