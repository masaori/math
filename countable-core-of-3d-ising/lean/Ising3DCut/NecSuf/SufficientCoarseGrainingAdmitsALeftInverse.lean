/-
左逆写像の構成に必要十分な仮定だけを残した版。

正の有理数・順序・代数構造は使わない。必要なのは、対象となる元を指定する述語と、
その元どうしを区別する写像だけである。具体版と同じ五段を同じ順で辿る。
-/
import Mathlib

namespace Ising3DCut.NecSuf

def goodImage {A S : Type*} (Good : A → Prop) (π : A → S) : Type _ :=
  {s : S // ∃ a : A, Good a ∧ π a = s}

def toGoodImage {A S : Type*} (Good : A → Prop) (π : A → S)
    (a : A) (ha : Good a) : goodImage Good π :=
  ⟨π a, a, ha, rfl⟩

theorem exists_good_preimage {A S : Type*} (Good : A → Prop) (π : A → S)
    (s : goodImage Good π) : ∃ a : A, Good a ∧ π a = s.val :=
  s.property

theorem good_preimage_unique {A S : Type*} (Good : A → Prop) (π : A → S)
    (hfree : ∀ a b : A, Good a → Good b → π a = π b → a = b)
    (s : goodImage Good π) {a b : A}
    (ha : Good a) (hb : Good b) (has : π a = s.val) (hbs : π b = s.val) : a = b :=
  hfree a b ha hb (has.trans hbs.symm)

noncomputable def goodLeftInverse {A S : Type*} (Good : A → Prop) (π : A → S)
    (s : goodImage Good π) : A :=
  Classical.choose s.property

theorem goodLeftInverse_spec {A S : Type*} (Good : A → Prop) (π : A → S)
    (s : goodImage Good π) :
    Good (goodLeftInverse Good π s) ∧ π (goodLeftInverse Good π s) = s.val :=
  Classical.choose_spec s.property

theorem goodLeftInverse_leftInverse {A S : Type*} (Good : A → Prop) (π : A → S)
    (hfree : ∀ a b : A, Good a → Good b → π a = π b → a = b)
    (a : A) (ha : Good a) :
    goodLeftInverse Good π (toGoodImage Good π a ha) = a := by
  obtain ⟨hgood, hval⟩ := goodLeftInverse_spec Good π (toGoodImage Good π a ha)
  exact good_preimage_unique Good π hfree (toGoodImage Good π a ha) hgood ha hval rfl

theorem goodLeftInverse_unique {A S : Type*} (Good : A → Prop) (π : A → S)
    (hfree : ∀ a b : A, Good a → Good b → π a = π b → a = b)
    (τ : goodImage Good π → A)
    (hτ : ∀ (a : A) (ha : Good a), τ (toGoodImage Good π a ha) = a) :
    τ = goodLeftInverse Good π := by
  funext s
  obtain ⟨a, ha, has⟩ := exists_good_preimage Good π s
  have hs : s = toGoodImage Good π a ha := Subtype.ext has.symm
  rw [hs, hτ a ha, goodLeftInverse_leftInverse Good π hfree a ha]

end Ising3DCut.NecSuf
