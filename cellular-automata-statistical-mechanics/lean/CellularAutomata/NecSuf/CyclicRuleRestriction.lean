/-
章「周期境界で重なる近傍入力と規則表の制限」の Lean 必要十分版。

必要な構造の検査結果:
  - 射影像、両立入力、引き戻し、入力実現、表制限による写像の等号判定には、
    舞台・オフセット・入力値・出力値の有限性も、入力値が二値であることも要らない。
  - 入力実現には、射影像の外を埋める入力値を一つだけ要る。
  - 全セルへの接着には、基準セルと同じ衝突関係だけを要る。
  - 個数式には各型の有限性を要り、二の冪になるのは入力値と出力値が二元だからである。
  - 整数剰余、半径、初等規則番号は具体的な巡回舞台との比較にだけ要る。
  - 状態上の演算、局所規則の物理的意味、時間、実数体、複素数体は使わない。
-/
import CellularAutomata.CyclicRuleRestriction

namespace CellularAutomata.NecSuf.CyclicRuleRestriction

universe uD uC uA uB

variable {D : Type uD} {C : Type uC} {A : Type uA} {B : Type uB}

/-- 射影の像。有限性は定義には要らない。 -/
def ProjectionImage (q : D → C) := {w : C // ∃ j : D, q j = w}

/-- 同じ像を持つ入力位置で値が一致する入力。 -/
def CompatibleInput (q : D → C) :=
  {a : D → A // ∀ j k : D, q j = q k → a j = a k}

/-- 射影像上の値を両立入力へ引き戻す。 -/
def pullback (q : D → C) (y : ProjectionImage q → A) : CompatibleInput (A := A) q :=
  ⟨fun j => y ⟨q j, ⟨j, rfl⟩⟩, fun j k hjk => by
    apply congrArg y
    exact Subtype.ext hjk⟩

/-- 像の元を与える入力位置を一つ選ぶ。 -/
noncomputable def representative (q : D → C) (w : ProjectionImage q) : D :=
  Classical.choose w.property

theorem representative_projects (q : D → C) (w : ProjectionImage q) :
    q (representative q w) = w.val :=
  Classical.choose_spec w.property

/-- 両立入力を射影像上の値へ降ろす。 -/
noncomputable def descend (q : D → C) (a : CompatibleInput (A := A) q) :
    ProjectionImage q → A :=
  fun w => a.val (representative q w)

theorem pullback_descend (q : D → C) (a : CompatibleInput (A := A) q) :
    pullback q (descend q a) = a := by
  apply Subtype.ext
  funext j
  exact a.property (representative q ⟨q j, ⟨j, rfl⟩⟩) j
    (representative_projects q ⟨q j, ⟨j, rfl⟩⟩)

theorem descend_pullback (q : D → C) (y : ProjectionImage q → A) :
    descend q (pullback q y) = y := by
  funext w
  apply congrArg y
  exact Subtype.ext (representative_projects q w)

/-- 両立入力と射影像上の値の全単射。 -/
noncomputable def pullbackEquiv (q : D → C) :
    (ProjectionImage q → A) ≃ CompatibleInput (A := A) q where
  toFun := pullback q
  invFun := descend q
  left_inv := descend_pullback q
  right_inv := pullback_descend q

/-- 像外を指定値で埋め、像上の値を全舞台へ延長する。 -/
noncomputable def extendConfiguration (a₀ : A) (q : D → C)
    (y : ProjectionImage q → A) : C → A :=
  by
    classical
    exact fun w => if h : ∃ j : D, q j = w then y ⟨w, h⟩ else a₀

theorem extendConfiguration_on_image (a₀ : A) (q : D → C)
    (y : ProjectionImage q → A) (j : D) :
    extendConfiguration a₀ q y (q j) = y ⟨q j, ⟨j, rfl⟩⟩ := by
  simp [extendConfiguration]

/-- 両立入力は全舞台上の入力から得られるものを尽くす。 -/
theorem realized_inputs (a₀ : A) (q : D → C) :
    Set.range (fun x : C → A => fun j => x (q j)) =
      {a : D → A | ∀ j k, q j = q k → a j = a k} := by
  ext a
  constructor
  · rintro ⟨x, rfl⟩ j k hjk
    exact congrArg x hjk
  · intro ha
    let aa : CompatibleInput (A := A) q := ⟨a, ha⟩
    let y : ProjectionImage q → A := descend q aa
    refine ⟨extendConfiguration a₀ q y, ?_⟩
    funext j
    calc
      extendConfiguration a₀ q y (q j) = y ⟨q j, ⟨j, rfl⟩⟩ :=
        extendConfiguration_on_image a₀ q y j
      _ = (pullback q y).val j := rfl
      _ = aa.val j := congrFun (congrArg Subtype.val (pullback_descend q aa)) j
      _ = a j := rfl

/-- 入力値 A の表が出力値 B を返す、一つの射影上の実現写像。 -/
def realizedMap (q : D → C) (g : (D → A) → B) : (C → A) → B :=
  fun x => g (fun j => x (q j))

/-- 二つの表が両立入力上で一致すること。 -/
def SameRestriction (q : D → C) (g h : (D → A) → B) : Prop :=
  ∀ a : CompatibleInput (A := A) q, g a.val = h a.val

/-- 実現写像の等号に必要十分なのは両立入力上の表の等号である。 -/
theorem realizedMap_eq_iff_restriction (a₀ : A) (q : D → C)
    (g h : (D → A) → B) :
    realizedMap q g = realizedMap q h ↔ SameRestriction q g h := by
  constructor
  · intro hmap a
    let y : ProjectionImage q → A := descend q a
    let x : C → A := extendConfiguration a₀ q y
    have hinput : (fun j => x (q j)) = a.val := by
      funext j
      calc
        x (q j) = y ⟨q j, ⟨j, rfl⟩⟩ := extendConfiguration_on_image a₀ q y j
        _ = (pullback q y).val j := rfl
        _ = a.val j := congrFun (congrArg Subtype.val (pullback_descend q a)) j
    have hx := congrFun hmap x
    simpa [realizedMap, hinput] using hx
  · intro hrestriction
    funext x
    exact hrestriction ⟨fun j => x (q j), fun j k hjk => congrArg x hjk⟩

/-- 各セルの射影と一つの表から得る全セルの写像。 -/
def globalRealizedMap (q : C → D → C) (g : (D → A) → B) :
    (C → A) → (C → B) :=
  fun x v => g (fun j => x (q v j))

/-- 全セルの射影が基準セルと同じ衝突関係を持つこと。 -/
def SameCollisionRelation (q : C → D → C) (v₀ : C) : Prop :=
  ∀ v j k, q v j = q v k ↔ q v₀ j = q v₀ k

/-- 共通衝突関係の下で、全セルの写像の等号も基準セルでの表制限だけで決まる。 -/
theorem globalRealizedMap_eq_iff_restriction (a₀ : A) (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) (g h : (D → A) → B) :
    globalRealizedMap q g = globalRealizedMap q h ↔ SameRestriction (q v₀) g h := by
  constructor
  · intro hglobal
    apply (realizedMap_eq_iff_restriction a₀ (q v₀) g h).mp
    funext x
    exact congrFun (congrFun hglobal x) v₀
  · intro hrestriction
    funext x v
    exact hrestriction
      ⟨fun j => x (q v j), fun j k hjk => congrArg x ((hcollision v j k).mpr hjk)⟩

/-- 射影の衝突と両立しない入力。 -/
def IncompatibleInput (q : D → C) :=
  {a : D → A // ¬ ∀ j k : D, q j = q k → a j = a k}

/-- 基準表 `g` と両立入力上で一致する表の繊維。 -/
def RestrictionFiber (q : D → C) (g : (D → A) → B) :=
  {h : (D → A) → B // SameRestriction q h g}

/-- 両立入力では `g`、両立しない入力では `c` を使う。 -/
noncomputable def extendIncompatibleTable (q : D → C) (g : (D → A) → B)
    (c : IncompatibleInput (A := A) q → B) : (D → A) → B :=
  by
    classical
    exact fun a => if ha : ∀ j k : D, q j = q k → a j = a k then g a else c ⟨a, ha⟩

/-- 同じ制限を持つ表は、両立しない入力上の出力値と全単射で対応する。 -/
noncomputable def incompatibleTableEquivRestrictionFiber (q : D → C)
    (g : (D → A) → B) :
    (IncompatibleInput (A := A) q → B) ≃ RestrictionFiber q g where
  toFun c := ⟨extendIncompatibleTable q g c, fun a => by
    simp only [extendIncompatibleTable, dif_pos a.property]⟩
  invFun h a := h.val a.val
  left_inv c := by
    funext a
    simp only [extendIncompatibleTable, dif_neg a.property]
    apply congrArg c
    exact Subtype.ext rfl
  right_inv h := by
    apply Subtype.ext
    funext a
    by_cases ha : ∀ j k : D, q j = q k → a j = a k
    · simpa only [extendIncompatibleTable, dif_pos ha] using (h.property ⟨a, ha⟩).symm
    · simp only [extendIncompatibleTable, dif_neg ha]

/-- 基準表 `g` と同じ全セル写像を与える表の繊維。 -/
def GlobalRealizationFiber (q : C → D → C) (g : (D → A) → B) :=
  {h : (D → A) → B // globalRealizedMap q h = globalRealizedMap q g}

/-- 共通の衝突関係の下で、大域実現繊維と制限繊維は同じ台を持つ。 -/
noncomputable def globalFiberEquivRestrictionFiber (a₀ : A) (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) (g : (D → A) → B) :
    GlobalRealizationFiber q g ≃ RestrictionFiber (q v₀) g where
  toFun h := ⟨h.val,
    (globalRealizedMap_eq_iff_restriction a₀ q v₀ hcollision h.val g).mp h.property⟩
  invFun h := ⟨h.val,
    (globalRealizedMap_eq_iff_restriction a₀ q v₀ hcollision h.val g).mpr h.property⟩
  left_inv h := Subtype.ext rfl
  right_inv h := Subtype.ext rfl

/-- 両立入力上の表を、それ以外では指定値として全入力へ延長する。 -/
noncomputable def extendRestriction (b₀ : B) (q₀ : D → C)
    (b : CompatibleInput (A := A) q₀ → B) : (D → A) → B :=
  by
    classical
    exact fun a => if ha : ∀ j k, q₀ j = q₀ k → a j = a k then b ⟨a, ha⟩ else b₀

theorem extendRestriction_on_compatible (b₀ : B) (q₀ : D → C)
    (b : CompatibleInput (A := A) q₀ → B) (a : CompatibleInput (A := A) q₀) :
    extendRestriction b₀ q₀ b a.val = b a := by
  unfold extendRestriction
  rw [dif_pos a.property]
  congr

/-- 一つの入力値から作る両立入力。出力値を延長する際の基準入力に使う。 -/
def constantCompatibleInput (a₀ : A) (q₀ : D → C) : CompatibleInput (A := A) q₀ :=
  ⟨fun _ => a₀, fun _ _ _ => rfl⟩

/-- 大域写像を基準セルで評価し、両立入力上の表へ戻す。 -/
noncomputable def restrictGlobalMap (a₀ : A) (q : C → D → C) (v₀ : C)
    (F : (C → A) → (C → B)) : CompatibleInput (A := A) (q v₀) → B :=
  fun a => F (extendConfiguration a₀ (q v₀) (descend (q v₀) a)) v₀

theorem restrictGlobalMap_of_realized (a₀ : A) (q : C → D → C) (v₀ : C)
    (g : (D → A) → B) (a : CompatibleInput (A := A) (q v₀)) :
    restrictGlobalMap a₀ q v₀ (globalRealizedMap q g) a = g a.val := by
  change g (fun j => extendConfiguration a₀ (q v₀) (descend (q v₀) a) (q v₀ j)) = g a.val
  congr 1
  funext j
  calc
    extendConfiguration a₀ (q v₀) (descend (q v₀) a) (q v₀ j) =
        (descend (q v₀) a) ⟨q v₀ j, ⟨j, rfl⟩⟩ :=
      extendConfiguration_on_image a₀ (q v₀) (descend (q v₀) a) j
    _ = (pullback (q v₀) (descend (q v₀) a)).val j := rfl
    _ = a.val j := congrFun (congrArg Subtype.val (pullback_descend (q v₀) a)) j

/-- 一つの局所表から実現される大域写像全体。 -/
def GlobalRealizedMap (q : C → D → C) :=
  {F : (C → A) → (C → B) // ∃ g : (D → A) → B, globalRealizedMap q g = F}

/-- 共通の衝突関係の下で、異なる大域写像は基準セルの両立入力上の表と対応する。 -/
noncomputable def restrictionGlobalEquiv (a₀ : A) (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) :
    (CompatibleInput (A := A) (q v₀) → B) ≃ GlobalRealizedMap (A := A) (B := B) q where
  toFun b :=
    ⟨globalRealizedMap q (extendRestriction (b (constantCompatibleInput a₀ (q v₀))) (q v₀) b),
      ⟨extendRestriction (b (constantCompatibleInput a₀ (q v₀))) (q v₀) b, rfl⟩⟩
  invFun F := restrictGlobalMap a₀ q v₀ F.val
  left_inv b := by
    funext a
    change restrictGlobalMap a₀ q v₀
      (globalRealizedMap q
        (extendRestriction (b (constantCompatibleInput a₀ (q v₀))) (q v₀) b)) a = b a
    rw [restrictGlobalMap_of_realized]
    exact extendRestriction_on_compatible
      (b (constantCompatibleInput a₀ (q v₀))) (q v₀) b a
  right_inv F := by
    apply Subtype.ext
    obtain ⟨g, hg⟩ := F.property
    change globalRealizedMap q
      (extendRestriction
        (restrictGlobalMap a₀ q v₀ F.val (constantCompatibleInput a₀ (q v₀)))
        (q v₀) (restrictGlobalMap a₀ q v₀ F.val)) = F.val
    rw [← hg]
    apply (globalRealizedMap_eq_iff_restriction a₀ q v₀ hcollision _ _).mpr
    intro a
    rw [extendRestriction_on_compatible, restrictGlobalMap_of_realized]

/-! ### 有限性が要る個数 -/

section Finite

variable [Fintype D] [DecidableEq D] [DecidableEq C]
  [Fintype A] [DecidableEq A] [Fintype B]

noncomputable instance (q : D → C) : DecidableEq (ProjectionImage q) :=
  Classical.decEq _

noncomputable instance (q : D → C) : Fintype (ProjectionImage q) :=
  by
    classical
    exact Fintype.ofFinset (Finset.univ.image q) (fun w => by
      change w ∈ Finset.univ.image q ↔ ∃ j : D, q j = w
      simp)

noncomputable instance (q : D → C) : Fintype (CompatibleInput (A := A) q) :=
  by
    classical
    exact Subtype.fintype _

noncomputable instance (q : D → C) : Fintype (IncompatibleInput (A := A) q) :=
  by
    classical
    exact Subtype.fintype _

noncomputable instance (q : D → C) (g : (D → A) → B) :
    Fintype (RestrictionFiber q g) := by
  classical
  exact Subtype.fintype _

noncomputable instance (q : C → D → C) (g : (D → A) → B) :
    Fintype (GlobalRealizationFiber q g) := by
  classical
  exact Subtype.fintype _

noncomputable instance (q : C → D → C) : Fintype (GlobalRealizedMap (A := A) (B := B) q) := by
  classical
  change Fintype {F : (C → A) → (C → B) //
    ∃ g : (D → A) → B, globalRealizedMap q g = F}
  exact Fintype.ofFinset
    (Finset.univ.image (globalRealizedMap q))
    (fun F => by
      change F ∈ Finset.univ.image (globalRealizedMap q) ↔
        ∃ g : (D → A) → B, globalRealizedMap q g = F
      simp)

/-- 両立入力の個数。二元性を仮定する前の一般式。 -/
theorem card_compatible_inputs (q : D → C) :
    Fintype.card (CompatibleInput (A := A) q) =
      Fintype.card A ^ Fintype.card (ProjectionImage q) := by
  calc
    Fintype.card (CompatibleInput (A := A) q) =
        Fintype.card (ProjectionImage q → A) :=
      Fintype.card_congr (pullbackEquiv q).symm
    _ = Fintype.card A ^ Fintype.card (ProjectionImage q) := Fintype.card_fun

/-- 入力表の総数。底は出力値の個数、内側の底は入力値の個数である。 -/
theorem card_truth_tables :
    Fintype.card ((D → A) → B) =
      Fintype.card B ^ (Fintype.card A ^ Fintype.card D) := by
  rw [Fintype.card_fun, Fintype.card_fun]

/-- 同じ制限を持つ表の個数。入出力集合の元数を分離した一般式。 -/
theorem card_restriction_fiber (q : D → C) (g : (D → A) → B) :
    Fintype.card (RestrictionFiber q g) =
      Fintype.card B ^
        (Fintype.card A ^ Fintype.card D -
          Fintype.card A ^ Fintype.card (ProjectionImage q)) := by
  classical
  have hcomplement : Fintype.card (IncompatibleInput (A := A) q) =
      Fintype.card (D → A) - Fintype.card (CompatibleInput (A := A) q) := by
    let compatibleSubtype :=
      {a : D → A // ∀ j k : D, q j = q k → a j = a k}
    let incompatibleSubtype :=
      {a : D → A // ¬ ∀ j k : D, q j = q k → a j = a k}
    let compatibleEquiv : compatibleSubtype ≃ CompatibleInput (A := A) q :=
      {
        toFun := fun a => ⟨a.val, a.property⟩
        invFun := fun a => ⟨a.val, a.property⟩
        left_inv := fun a => Subtype.ext rfl
        right_inv := fun a => Subtype.ext rfl
      }
    calc
      Fintype.card (IncompatibleInput (A := A) q) = Fintype.card incompatibleSubtype :=
        Fintype.card_congr (Equiv.refl _)
      _ = Fintype.card (D → A) - Fintype.card compatibleSubtype :=
        Fintype.card_subtype_compl
          (fun a : D → A => ∀ j k : D, q j = q k → a j = a k)
      _ = Fintype.card (D → A) - Fintype.card (CompatibleInput (A := A) q) := by
        rw [Fintype.card_congr compatibleEquiv]
  calc
    Fintype.card (RestrictionFiber q g) =
        Fintype.card (IncompatibleInput (A := A) q → B) :=
      Fintype.card_congr (incompatibleTableEquivRestrictionFiber q g).symm
    _ = Fintype.card B ^ Fintype.card (IncompatibleInput (A := A) q) := Fintype.card_fun
    _ = Fintype.card B ^
        (Fintype.card (D → A) - Fintype.card (CompatibleInput (A := A) q)) := by
      rw [hcomplement]
    _ = Fintype.card B ^
        (Fintype.card A ^ Fintype.card D -
          Fintype.card A ^ Fintype.card (ProjectionImage q)) := by
      rw [Fintype.card_fun, card_compatible_inputs]

/-- 同じ大域写像を与える表の個数。 -/
theorem card_global_realization_fiber (a₀ : A) (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) (g : (D → A) → B) :
    Fintype.card (GlobalRealizationFiber q g) =
      Fintype.card B ^
        (Fintype.card A ^ Fintype.card D -
          Fintype.card A ^ Fintype.card (ProjectionImage (q v₀))) := by
  calc
    Fintype.card (GlobalRealizationFiber q g) =
        Fintype.card (RestrictionFiber (q v₀) g) :=
      Fintype.card_congr (globalFiberEquivRestrictionFiber a₀ q v₀ hcollision g)
    _ = Fintype.card B ^
        (Fintype.card A ^ Fintype.card D -
          Fintype.card A ^ Fintype.card (ProjectionImage (q v₀))) :=
      card_restriction_fiber (q v₀) g

/-- 異なる大域写像の個数。 -/
theorem card_global_realized_maps (a₀ : A) (q : C → D → C) (v₀ : C)
    (hcollision : SameCollisionRelation q v₀) :
    Fintype.card (GlobalRealizedMap (A := A) (B := B) q) =
      Fintype.card B ^
        (Fintype.card A ^ Fintype.card (ProjectionImage (q v₀))) := by
  classical
  calc
    Fintype.card (GlobalRealizedMap (A := A) (B := B) q) =
        Fintype.card (CompatibleInput (A := A) (q v₀) → B) :=
      Fintype.card_congr (restrictionGlobalEquiv a₀ q v₀ hcollision).symm
    _ = Fintype.card B ^ Fintype.card (CompatibleInput (A := A) (q v₀)) :=
      Fintype.card_fun
    _ = Fintype.card B ^
        (Fintype.card A ^ Fintype.card (ProjectionImage (q v₀))) := by
      rw [card_compatible_inputs]

end Finite

/-! ### 具体版の導出 -/

section Derivation

open CellularAutomata.EssentialDependency
open CellularAutomata.CyclicRuleRestriction

variable {X Y : Type} [Fintype X] [DecidableEq X] [Fintype Y] [DecidableEq Y]

noncomputable def concreteImageEquiv (q : X → Y) :
    CellularAutomata.CyclicRuleRestriction.Image q ≃ ProjectionImage q where
  toFun w := ⟨w.val, w.property⟩
  invFun w := ⟨w.val, w.property⟩
  left_inv w := Subtype.ext rfl
  right_inv w := Subtype.ext rfl

noncomputable def concreteCompatibleEquiv (q : X → Y) :
    CellularAutomata.CyclicRuleRestriction.AdmissibleInput q ≃
      CompatibleInput (A := State) q where
  toFun a := ⟨a.val, a.property⟩
  invFun a := ⟨a.val, a.property⟩
  left_inv a := Subtype.ext rfl
  right_inv a := Subtype.ext rfl

noncomputable def concreteGlobalFiberEquiv (q : Y → X → Y)
    (g : (X → State) → State) :
    CellularAutomata.CyclicRuleRestriction.GlobalRealizationFiber q g ≃
      GlobalRealizationFiber q g where
  toFun h := ⟨h.val, h.property⟩
  invFun h := ⟨h.val, h.property⟩
  left_inv h := Subtype.ext rfl
  right_inv h := Subtype.ext rfl

noncomputable def concreteGlobalRealizedEquiv (q : Y → X → Y) :
    CellularAutomata.CyclicRuleRestriction.GlobalRealizedMap q ≃
      GlobalRealizedMap (A := State) (B := State) q where
  toFun F := ⟨F.val, F.property⟩
  invFun F := ⟨F.val, F.property⟩
  left_inv F := Subtype.ext rfl
  right_inv F := Subtype.ext rfl

/-- 具体版の局所等号判定は、入力値と出力値を State に一致させた特殊化である。 -/
theorem realizedMap_eq_iff_restriction_of_necSuf (q : X → Y)
    (g h : (X → State) → State) :
    CellularAutomata.CyclicRuleRestriction.realizedMap q g =
      CellularAutomata.CyclicRuleRestriction.realizedMap q h ↔
      CellularAutomata.CyclicRuleRestriction.SameRestriction q g h := by
  change realizedMap q g = realizedMap q h ↔ SameRestriction q g h
  exact realizedMap_eq_iff_restriction State.zero q g h

/-- 具体版の全セル等号判定は、二元状態を入出力へ使った特殊化である。 -/
theorem globalRealizedMap_eq_iff_restriction_of_necSuf
    (q : Y → X → Y) (v₀ : Y)
    (hcollision : CellularAutomata.CyclicRuleRestriction.SameCollisionRelation q v₀)
    (g h : (X → State) → State) :
    CellularAutomata.CyclicRuleRestriction.globalRealizedMap q g =
        CellularAutomata.CyclicRuleRestriction.globalRealizedMap q h ↔
      CellularAutomata.CyclicRuleRestriction.SameRestriction (q v₀) g h := by
  change globalRealizedMap q g = globalRealizedMap q h ↔ SameRestriction (q v₀) g h
  exact globalRealizedMap_eq_iff_restriction State.zero q v₀ hcollision g h

/-- 具体版の両立入力個数は、入力値の元数を二とした一般式の特殊化である。 -/
theorem card_admissible_inputs_of_necSuf (q : X → Y) :
    Fintype.card (CellularAutomata.CyclicRuleRestriction.AdmissibleInput q) =
      2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image q) := by
  calc
    Fintype.card (CellularAutomata.CyclicRuleRestriction.AdmissibleInput q) =
        Fintype.card (CompatibleInput (A := State) q) :=
      Fintype.card_congr (concreteCompatibleEquiv q)
    _ = 2 ^ Fintype.card (ProjectionImage q) := by
      simpa only [card_state] using card_compatible_inputs (A := State) q
    _ = 2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image q) := by
      rw [Fintype.card_congr (concreteImageEquiv q).symm]

/-- 具体版の真理値表個数は、入出力値の元数を二とした一般式の特殊化である。 -/
theorem card_truth_tables_of_necSuf :
    Fintype.card ((X → State) → State) = 2 ^ (2 ^ Fintype.card X) := by
  simpa only [card_state] using card_truth_tables (D := X) (A := State) (B := State)

/-- 具体版の実現繊維個数は、入出力値を二元とした特殊化である。 -/
theorem card_global_realization_fiber_of_necSuf (q : Y → X → Y) (v₀ : Y)
    (hcollision : CellularAutomata.CyclicRuleRestriction.SameCollisionRelation q v₀)
    (g : (X → State) → State) :
    Fintype.card (CellularAutomata.CyclicRuleRestriction.GlobalRealizationFiber q g) =
      2 ^ (2 ^ Fintype.card X -
        2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image (q v₀))) := by
  change SameCollisionRelation q v₀ at hcollision
  calc
    Fintype.card (CellularAutomata.CyclicRuleRestriction.GlobalRealizationFiber q g) =
        Fintype.card (GlobalRealizationFiber q g) :=
      Fintype.card_congr (concreteGlobalFiberEquiv q g)
    _ = 2 ^ (2 ^ Fintype.card X - 2 ^ Fintype.card (ProjectionImage (q v₀))) := by
      simpa only [card_state] using
        card_global_realization_fiber State.zero q v₀ hcollision g
    _ = 2 ^ (2 ^ Fintype.card X -
        2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image (q v₀))) := by
      rw [Fintype.card_congr (concreteImageEquiv (q v₀)).symm]

/-- 具体版の大域写像個数は、入出力値を二元とした特殊化である。 -/
theorem card_global_realized_maps_of_necSuf (q : Y → X → Y) (v₀ : Y)
    (hcollision : CellularAutomata.CyclicRuleRestriction.SameCollisionRelation q v₀) :
    Fintype.card (CellularAutomata.CyclicRuleRestriction.GlobalRealizedMap q) =
      2 ^ (2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image (q v₀))) := by
  change SameCollisionRelation q v₀ at hcollision
  calc
    Fintype.card (CellularAutomata.CyclicRuleRestriction.GlobalRealizedMap q) =
        Fintype.card (GlobalRealizedMap (A := State) (B := State) q) :=
      Fintype.card_congr (concreteGlobalRealizedEquiv q)
    _ = 2 ^ (2 ^ Fintype.card (ProjectionImage (q v₀))) := by
      have hgeneral := card_global_realized_maps
        (A := State) (B := State) State.zero q v₀ hcollision
      have hstate : Fintype.card State = 2 :=
        CellularAutomata.EssentialDependency.card_state
      rw [hstate] at hgeneral
      exact hgeneral
    _ = 2 ^ (2 ^ Fintype.card (CellularAutomata.CyclicRuleRestriction.Image (q v₀))) := by
      rw [Fintype.card_congr (concreteImageEquiv (q v₀)).symm]

end Derivation

end CellularAutomata.NecSuf.CyclicRuleRestriction
