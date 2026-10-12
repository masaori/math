/-
「正錐と乗法の両立」の必要十分版。
積の表示公式と係数の乗法・加法の可換性から転送を証明し、
三条件の九場合を六つの既証補題へ分ける。順序・環・体構造は要求しない。
-/

namespace Ising2DLambda.NecSuf.FisherZero

universe u v

/-- 本文の表示の四等号と、表示だけで決まる所属の転送。 -/
theorem positive_cone_mul_transfer_necSuf
    {X : Type u} {A : Type v} (mul : X → X → X)
    (addA mulA : A → A → A) (two : A) (rep : X → A × A)
    (hRepMul : ∀ x y, rep (mul x y) =
      (addA (mulA (rep x).1 (rep y).1) (mulA two (mulA (rep x).2 (rep y).2)),
       addA (mulA (rep x).1 (rep y).2) (mulA (rep x).2 (rep y).1)))
    (hMulComm : ∀ a b, mulA a b = mulA b a)
    (hAddComm : ∀ a b, addA a b = addA b a)
    (positive : A × A → Prop) (x y : X)
    (h : positive (rep (mul y x))) : positive (rep (mul x y)) := by
  let a : A := (rep x).1
  let b : A := (rep x).2
  let a' : A := (rep y).1
  let b' : A := (rep y).2
  have hrep : rep (mul x y) = rep (mul y x) := by
    calc
      rep (mul x y) =
          (addA (mulA a a') (mulA two (mulA b b')), addA (mulA a b') (mulA b a')) :=
        hRepMul x y
      _ = (addA (mulA a' a) (mulA two (mulA b' b)), addA (mulA b' a) (mulA a' b)) := by
        rw [hMulComm a a', hMulComm b b', hMulComm a b', hMulComm b a']
      _ = (addA (mulA a' a) (mulA two (mulA b' b)), addA (mulA a' b) (mulA b' a)) :=
        congrArg (fun z : A => (addA (mulA a' a) (mulA two (mulA b' b)), z))
          (hAddComm (mulA b' a) (mulA a' b))
      _ = rep (mul y x) := (hRepMul y x).symm
  exact hrep.symm ▸ h

/-- 六つの補題は任意の二元へ適用できる形で要求する。
転送の結論は仮定にせず、積の表示公式と係数の乗法・加法の可換性から導く。 -/
theorem positive_cone_mul_closed_necSuf
    {X : Type u} {A : Type v} (mul : X → X → X)
    (addA mulA : A → A → A) (two : A) (rep : X → A × A)
    (hRepMul : ∀ x y, rep (mul x y) =
      (addA (mulA (rep x).1 (rep y).1) (mulA two (mulA (rep x).2 (rep y).2)),
       addA (mulA (rep x).1 (rep y).2) (mulA (rep x).2 (rep y).1)))
    (hMulComm : ∀ a b, mulA a b = mulA b a)
    (hAddComm : ∀ a b, addA a b = addA b a)
    (C1 C2 C3 : A × A → Prop)
    (h11 : ∀ x y, C1 (rep x) → C1 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (h12 : ∀ x y, C1 (rep x) → C2 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (h13 : ∀ x y, C1 (rep x) → C3 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (h22 : ∀ x y, C2 (rep x) → C2 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (h23 : ∀ x y, C2 (rep x) → C3 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (h33 : ∀ x y, C3 (rep x) → C3 (rep y) →
      C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)))
    (x y : X)
    (hx : C1 (rep x) ∨ C2 (rep x) ∨ C3 (rep x))
    (hy : C1 (rep y) ∨ C2 (rep y) ∨ C3 (rep y)) :
    C1 (rep (mul x y)) ∨ C2 (rep (mul x y)) ∨ C3 (rep (mul x y)) := by
  have transfer := positive_cone_mul_transfer_necSuf mul addA mulA two rep
    hRepMul hMulComm hAddComm
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
