/-
「正錐と加法の両立」の必要十分版。
表示の加法保存と係数加法の可換性から転送を証明し、
三条件の九場合を六つの既証補題へ分ける。順序・環・体構造は要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u v

/-- 本文の表示の四等号と、表示だけで決まる所属の転送。 -/
theorem positive_cone_add_transfer_necSuf
    {X : Type u} {A : Type v} (add : X → X → X) (addA : A → A → A)
    (rep : X → A × A)
    (hRepAdd : ∀ x y, rep (add x y) =
      (addA (rep x).1 (rep y).1, addA (rep x).2 (rep y).2))
    (hComm : ∀ a b, addA a b = addA b a)
    (positive : A × A → Prop) (x y : X)
    (h : positive (rep (add y x))) : positive (rep (add x y)) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  let a' : A := (rep y).1
  let b' : A := (rep y).2
  have hrep : rep (add x y) = rep (add y x) := by
    calc
      rep (add x y) = (addA a a', addA b b') := hRepAdd x y
      _ = (addA a' a, addA b b') :=
        congrArg (fun z : A => (z, addA b b')) (hComm a a')
      _ = (addA a' a, addA b' b) :=
        congrArg (fun z : A => (addA a' a, z)) (hComm b b')
      _ = rep (add y x) := (hRepAdd y x).symm
  exact hrep.symm ▸ h

/-- 六つの補題は任意の二元へ適用できる形で要求する。
転送の結論は仮定にせず、表示の加法保存と係数加法の可換性から導く。 -/
theorem positive_cone_add_closed_necSuf
    {X : Type u} {A : Type v} (add : X → X → X) (addA : A → A → A)
    (rep : X → A × A)
    (hRepAdd : ∀ x y, rep (add x y) =
      (addA (rep x).1 (rep y).1, addA (rep x).2 (rep y).2))
    (hComm : ∀ a b, addA a b = addA b a)
    (C1 C2 C3 : A × A → Prop)
    (h11 : ∀ x y, C1 (rep x) → C1 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (h12 : ∀ x y, C1 (rep x) → C2 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (h13 : ∀ x y, C1 (rep x) → C3 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (h22 : ∀ x y, C2 (rep x) → C2 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (h23 : ∀ x y, C2 (rep x) → C3 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (h33 : ∀ x y, C3 (rep x) → C3 (rep y) →
      C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)))
    (x y : X)
    (hx : C1 (rep x) ∨ C2 (rep x) ∨ C3 (rep x))
    (hy : C1 (rep y) ∨ C2 (rep y) ∨ C3 (rep y)) :
    C1 (rep (add x y)) ∨ C2 (rep (add x y)) ∨ C3 (rep (add x y)) := by
  have transfer := positive_cone_add_transfer_necSuf add addA rep hRepAdd hComm
    (fun ab => C1 ab ∨ C2 ab ∨ C3 ab) x y
  rcases hx with hx1 | hx2 | hx3
  · rcases hy with hy1 | hy2 | hy3
    · exact h11 x y hx1 hy1
    · exact h12 x y hx1 hy2
    · exact h13 x y hx1 hy3
  · rcases hy with hy1 | hy2 | hy3
    · have hrev := h12 y x hy1 hx2
      exact transfer hrev
    · exact h22 x y hx2 hy2
    · exact h23 x y hx2 hy3
  · rcases hy with hy1 | hy2 | hy3
    · have hrev := h13 y x hy1 hx3
      exact transfer hrev
    · have hrev := h23 y x hy2 hx3
      exact transfer hrev
    · exact h33 x y hx3 hy3

end Ising2DLambda.NecSuf.FisherZero
