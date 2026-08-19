/-
章「安定ファイバー根付き木族の数値プロファイルは共役を決定しない」の必要十分版。

具体版の非共役性の証明と同じ手順（不動点の移送、反復の移送による子孫所属の移送、
単射像の個数比較、全単射候補の有限走査）を保ち、実際に使う構造だけを残す。

* 不動点の移送と有界反復での到達の移送には、二つの型 X, Y、自己写像 F : X → X,
  G : Y → Y、写像 h : X → Y と共役条件 h ∘ F = G ∘ h だけが要る。h の単射性・全射性・
  両型の有限性・等号判定は要らない。反復の移送は共役不変性の章の必要十分版をそのまま使う。
* 子孫集合を有限表として持つには、その型の有限性と等号判定だけが要る
  （高々 n 回の到達という存在文を有限走査で判定するため）。
* 子孫有限表の像の包含には、両型の有限性・等号判定と共役条件だけが要る。
* 子孫個数の不等式には h の単射性だけを追加する（個数を単射像で移すため）。
  具体版が全単射を仮定するのは共役の定義のためであり、この不等式には単射性しか使わない。
* 共役全単射の存在の有限決定にだけ、両型の有限性と等号判定の全てが要る。
反例の具体表、二値状態、セル、近傍、局所規則、根付き木の内部構造、R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance

namespace CellularAutomata.NecSuf.IterateMonoidConjugacyNumericalProfile

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidConjugacyInvariance

/-- 不動点の移送には共役条件だけが要る。 -/
theorem conjugate_fixedPoint {X Y : Type} (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ x, h (F x) = G (h x)) {x : X} (hx : F x = x) :
    G (h x) = h x := by
  rw [← hconj, hx]

/-- 有界回数の反復での到達の移送には共役条件だけが要る。 -/
theorem conjugate_reaches {X Y : Type} (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ x, h (F x) = G (h x)) {n : ℕ} {y z : X}
    (hreach : iterateMap F n y = z) :
    iterateMap G n (h y) = h z :=
  (conjugate_iterateMap F G h hconj n y).symm.trans (congrArg h hreach)

/-- 高々 n 回の反復で z へ到達する元の有限表。
有限性と等号判定は、この表を有限走査で持つためだけに要る。 -/
def descendantTable {X : Type} [Fintype X] [DecidableEq X]
    (F : X → X) (n : ℕ) (z : X) : Finset X :=
  Finset.univ.filter fun y => ∃ k ∈ Finset.range n, iterateMap F k y = z

/-- 子孫有限表の像の包含には、両型の有限性・等号判定と共役条件だけが要る。 -/
theorem descendantTable_image_subset {X Y : Type} [Fintype X] [DecidableEq X]
    [Fintype Y] [DecidableEq Y] (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ x, h (F x) = G (h x)) (n : ℕ) (z : X) :
    (descendantTable F n z).image h ⊆ descendantTable G n (h z) := by
  intro w hw
  obtain ⟨y, hy, rfl⟩ := Finset.mem_image.mp hw
  simp only [descendantTable, Finset.mem_filter, Finset.mem_univ, true_and] at hy ⊢
  obtain ⟨k, hk, hreach⟩ := hy
  exact ⟨k, hk, conjugate_reaches F G h hconj hreach⟩

/-- 子孫個数の不等式には、さらに h の単射性だけを追加する。 -/
theorem descendantTable_card_le {X Y : Type} [Fintype X] [DecidableEq X]
    [Fintype Y] [DecidableEq Y] (F : X → X) (G : Y → Y) (h : X → Y)
    (hconj : ∀ x, h (F x) = G (h x)) (hinj : Function.Injective h) (n : ℕ) (z : X) :
    (descendantTable F n z).card ≤ (descendantTable G n (h z)).card := by
  calc (descendantTable F n z).card
      = ((descendantTable F n z).image h).card :=
        (Finset.card_image_of_injective _ hinj).symm
    _ ≤ (descendantTable G n (h z)).card :=
        Finset.card_le_card (descendantTable_image_subset F G h hconj n z)

/-- 共役全単射の存在の有限決定にだけ、両型の有限性と等号判定の全てが要る。 -/
def conjugacyDecidable {X Y : Type} [Fintype X] [DecidableEq X]
    [Fintype Y] [DecidableEq Y] (F : X → X) (G : Y → Y) :
    Decidable (∃ h : X → Y, Function.Bijective h ∧ ∀ x, h (F x) = G (h x)) := by
  infer_instance

end CellularAutomata.NecSuf.IterateMonoidConjugacyNumericalProfile
