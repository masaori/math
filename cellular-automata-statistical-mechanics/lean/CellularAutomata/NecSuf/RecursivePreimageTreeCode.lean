/-
章「周期成分に付随する再帰的前像木符号の完全性」の必要十分版のうち、
完全不変量と有限決定の段。

具体版（`CellularAutomata.RecursivePreimageTreeCode` の節 `CompleteInvariant`）と
同じ手順を保つ。すなわち、完全性（符号の等号から共役全単射を構成する）と
共役不変性（共役全単射から符号の等号を得る）の二つの含意を合わせて同値を作り、
その同値を通して共役全単射の存在の判定を符号の等号の判定へ移し、
等号の場合に構成した全単射を一つ固定して `Option` の値として返す。

実際に使う構造は次だけである。

* 同値の構成には、二つの型 X, Y、その上の自己写像 F, G、符号型 C の二つの値
  cX, cY、および上記二つの含意だけが要る。X, Y の有限性・等号判定、
  符号型が多重集合であること、符号が再帰的に作られたことは使わない。
* 共役全単射の存在の判定には、さらに符号型 C の等号判定だけを足す。
  具体版が使う「全単射を全数走査しないで済む」という性質は、この同値と
  C の等号判定だけから出る。X, Y の有限性はここでも要らない。
* 一致時の全単射の固定には、C の等号判定と、等号から全単射を作る写像だけが要る。
  その写像が共役条件を満たすことは、`isSome` と存在の同値には使わない
  （具体版でも使っていない）。

具体版の符号型は `Multiset (Finset (List ℕ))` であり、その等号判定は選択公理を
使わずに得られる。この事実だけが有限決定の中身であることを
`mapCodeTypeDecidableEq` で明示する。

二値状態、セル、近傍、局所規則、前像木の内部構造、周期成分、R / C は使わない。
-/

import Mathlib.Logic.Equiv.Defs
import Mathlib.Data.Multiset.Basic
import Mathlib.Data.Finset.Basic

namespace CellularAutomata.NecSuf.RecursivePreimageTreeCode

variable {X Y C : Type}

/-- 共役全単射の存在。具体版の結論と同じ形に固定する。 -/
def HasConjugacy (F : X → X) (G : Y → Y) : Prop :=
  ∃ h : X ≃ Y, ∀ x, h (F x) = G (h x)

/-- 完全不変量。要るのは完全性と不変性の二つの含意だけであり、
符号型の等号判定も型の有限性も使わない。 -/
theorem code_eq_iff_hasConjugacy (F : X → X) (G : Y → Y) (cX cY : C)
    (hcomplete : cY = cX → HasConjugacy F G)
    (hinvariant : HasConjugacy F G → cY = cX) :
    cY = cX ↔ HasConjugacy F G :=
  ⟨hcomplete, hinvariant⟩

/-- 符号の等号の判定に要るのは符号型の等号判定だけである。
自己写像も型の有限性も使わないので、引数に取らない。 -/
def codeEqualityDecidable [DecidableEq C] (cX cY : C) : Decidable (cY = cX) :=
  ‹DecidableEq C› cY cX

/-- 共役全単射の存在の判定。符号型の等号判定と完全不変量の同値だけを使い、
全単射 X ≃ Y を全数走査しない。X, Y の有限性・等号判定は使わない。 -/
def hasConjugacyDecidable [DecidableEq C] (F : X → X) (G : Y → Y) (cX cY : C)
    (hiff : cY = cX ↔ HasConjugacy F G) :
    Decidable (HasConjugacy F G) :=
  letI : Decidable (cY = cX) := codeEqualityDecidable cX cY
  decidable_of_iff (cY = cX) hiff

/-- 符号の等号の判定が一致を返したときに固定する全単射。不一致なら `none`。
要るのは C の等号判定と、等号から全単射を作る写像だけである。 -/
def conjugacyFromDecision [DecidableEq C] (cX cY : C) (mk : cY = cX → X ≃ Y) :
    Option (X ≃ Y) :=
  if hc : cY = cX then some (mk hc) else none

/-- 符号が等しい場合に返る値は、与えた構成そのものである。 -/
theorem conjugacyFromDecision_eq_some [DecidableEq C] (cX cY : C)
    (mk : cY = cX → X ≃ Y) (hc : cY = cX) :
    conjugacyFromDecision cX cY mk = some (mk hc) := by
  simp [conjugacyFromDecision, hc]

/-- 判定が値を返すことと共役全単射の存在は同値である。
`mk` が共役条件を満たすことは使わない（具体版でも使っていない）。 -/
theorem conjugacyFromDecision_isSome_iff [DecidableEq C] (F : X → X) (G : Y → Y)
    (cX cY : C) (mk : cY = cX → X ≃ Y) (hiff : cY = cX ↔ HasConjugacy F G) :
    (conjugacyFromDecision cX cY mk).isSome ↔ HasConjugacy F G := by
  rw [← hiff]
  by_cases hc : cY = cX
  · simp [conjugacyFromDecision, hc]
  · simp [conjugacyFromDecision, hc]

/-- 具体版の符号型 `Multiset (Finset (List ℕ))` の等号判定。
上の判定はこの一つの性質しか使わず、選択公理を使わずに得られる。 -/
def mapCodeTypeDecidableEq : DecidableEq (Multiset (Finset (List ℕ))) :=
  inferInstance

end CellularAutomata.NecSuf.RecursivePreimageTreeCode
