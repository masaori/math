/-
章「共役類の集合と写像符号の像の全単射」の必要十分版。

商集合と符号の像の全単射に実際に要るのは、集合 X 上の同値関係 s、符号写像 code : X → C、
および「s で同値であること」と「符号が等しいこと」の同値だけである。X と C の有限性、
等号判定、自己写像、共役全単射、二値状態、セル、近傍、局所規則、符号の内部構造は使わない。

有限性と等号判定が要るのは、具体版で X を有限列挙し、符号の像を Finset として計算して
その元数を求める段だけである。R / C は現れない。
-/

import Mathlib.Data.Set.Image
import Mathlib.Logic.Equiv.Defs
import Mathlib.Logic.Equiv.Basic

namespace CellularAutomata.NecSuf.ConjugacyClassCodeImageBijection

variable {X C : Type}

/-- 同値類から符号へ送る写像。代表非依存性だけで定義できる。 -/
def quotientCode (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y) : Quotient s → C :=
  Quotient.lift code (fun x y hxy => hinvariant hxy)

theorem quotientCode_mk (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y) (x : X) :
    quotientCode s code hinvariant (Quotient.mk s x) = code x :=
  rfl

/-- 同値関係が符号の等号と一致するとき、商から符号への写像は単射である。 -/
theorem quotientCode_injective (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y)
    (hcomplete : ∀ {x y}, code x = code y → s.r x y) :
    Function.Injective (quotientCode s code hinvariant) := by
  intro K L hKL
  induction K using Quotient.inductionOn with
  | h x =>
    induction L using Quotient.inductionOn with
    | h y =>
      rw [quotientCode_mk, quotientCode_mk] at hKL
      exact Quotient.sound (hcomplete hKL)

/-- 商から符号の集合論的な像への写像。有限性も等号判定も要らない。 -/
def codeRangeMap (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y) :
    Quotient s → Set.range code :=
  fun K => ⟨quotientCode s code hinvariant K, by
    induction K using Quotient.inductionOn with
    | h x => exact ⟨x, rfl⟩⟩

theorem codeRangeMap_injective (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y)
    (hcomplete : ∀ {x y}, code x = code y → s.r x y) :
    Function.Injective (codeRangeMap s code hinvariant) := by
  intro K L hKL
  exact quotientCode_injective s code hinvariant hcomplete (congrArg Subtype.val hKL)

theorem codeRangeMap_surjective (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y) :
    Function.Surjective (codeRangeMap s code hinvariant) := by
  rintro ⟨c, x, rfl⟩
  exact ⟨Quotient.mk s x, rfl⟩

/-- 商集合と符号の像の全単射。必要十分な情報は、同値関係と符号等号の両方向だけである。 -/
noncomputable def quotientEquivCodeRange (s : Setoid X) (code : X → C)
    (hinvariant : ∀ {x y}, s.r x y → code x = code y)
    (hcomplete : ∀ {x y}, code x = code y → s.r x y) :
    Quotient s ≃ Set.range code :=
  Equiv.ofBijective (codeRangeMap s code hinvariant)
    ⟨codeRangeMap_injective s code hinvariant hcomplete,
      codeRangeMap_surjective s code hinvariant⟩

end CellularAutomata.NecSuf.ConjugacyClassCodeImageBijection
