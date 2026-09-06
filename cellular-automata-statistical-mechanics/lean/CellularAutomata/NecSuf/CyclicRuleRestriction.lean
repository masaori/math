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

/-! ### 有限性が要る個数 -/

section Finite

variable [Fintype D] [DecidableEq D] [Fintype C] [DecidableEq C]
  [Fintype A] [DecidableEq A] [Fintype B] [DecidableEq B]

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
    exact Fintype.ofEquiv (ProjectionImage q → A) (pullbackEquiv q)

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

end Derivation

end CellularAutomata.NecSuf.CyclicRuleRestriction
