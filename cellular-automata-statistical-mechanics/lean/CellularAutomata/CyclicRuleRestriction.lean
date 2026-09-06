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

有限巡回舞台の各セルで整数オフセットを射影した写像を q として固定する。
このファイルは本文の証明が q の有限像と同じ像を持つオフセットの一致だけを使う部分を、
演算を持たない二元状態 State 上で同じ順序により形式化する。整数剰余による q 自体の算術は
content/cyclic-offset-projection.ts の別の主張であり、このファイルでは仮定として一般化しない。
全セルの射影 q_v が同じ両立条件を持つことを使う大域的な接着も後半へ残す。

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

end

end CellularAutomata.CyclicRuleRestriction
