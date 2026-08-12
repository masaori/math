/-
閉じた巡回の隣接値が変わる回数の偶奇が零であることの必要十分版。
格子・辺・スピンを外すと、有限集合上の置換と二値写像だけが残る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

private def boolParity : Bool → Fin 2
  | false => 0
  | true => 1

/-- 有限集合を置換に沿って一周すると、二値が変わる回数は偶数である。 -/
private theorem bool_cyclic_change_parity_zero {α : Type*} [Fintype α] [DecidableEq α]
    (f : α → Bool) (p : α ≃ α) :
    (∑ i : α, if f i = f (p i) then (0 : Fin 2) else 1) = 0 := by
  have hchange (a b : Bool) :
      (if a = b then (0 : Fin 2) else 1) = boolParity a + boolParity b := by
    cases a <;> cases b <;> decide
  simp_rw [hchange, Finset.sum_add_distrib]
  have hsum : (∑ i : α, boolParity (f (p i))) = ∑ i : α, boolParity (f i) :=
    p.sum_comp (fun i => boolParity (f i))
  rw [hsum]
  change (∑ i : α, boolParity (f i)) + (∑ i : α, boolParity (f i)) = 0
  omega

/-- 二元集合を有限置換に沿って一周すると、値が変わる回数は偶数である。 -/
theorem cyclic_change_parity_zero_necSuf {α β : Type*} [Fintype α] [DecidableEq α]
    [DecidableEq β]
    (encode : β ≃ Bool) (f : α → β) (p : α ≃ α) :
    (∑ i : α, if f i = f (p i) then (0 : Fin 2) else 1) = 0 := by
  simpa only [encode.injective.eq_iff] using
    bool_cyclic_change_parity_zero (fun i => encode (f i)) p

end Ising2DLambda.NecSuf.FisherZero
