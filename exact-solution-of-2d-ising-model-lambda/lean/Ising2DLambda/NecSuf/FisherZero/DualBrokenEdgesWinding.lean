/-
有限置換に沿う二値変化の必要十分版。
有限性は和を取るため、置換は再添字付けのため、二値への単射は変化の指示子を
二つの自然数符号の和の余りへ移すために必要である。符号化の全射性は使わない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open Finset

/-- 本文の自然数の計算列を、有限添字集合・二値符号化・置換へ一般化する。 -/
theorem cyclic_change_parity_zero_necSuf {α β : Type*} [Fintype α]
    [DecidableEq β] (encode : β → Fin 2) (hencode : Function.Injective encode)
    (f : α → β) (p : α ≃ α) :
    (∑ i : α, if f i = f (p i) then (0 : ℕ) else 1) % 2 = 0 := by
  have hchange (a b : β) :
      (if a = b then (0 : ℕ) else 1) = ((encode a).val + (encode b).val) % 2 := by
    have ha := (encode a).isLt
    have hb := (encode b).isLt
    by_cases h : a = b
    · subst b
      simp only [ite_true]
      omega
    · have hval : (encode a).val ≠ (encode b).val := by
        intro heq
        exact h (hencode (Fin.ext heq))
      simp only [if_neg h]
      omega
  calc
    _ = (∑ i : α, ((encode (f i)).val + (encode (f (p i))).val) % 2) % 2 := by
      simp_rw [hchange]
    _ = (∑ i : α, ((encode (f i)).val + (encode (f (p i))).val)) % 2 :=
      (Finset.sum_nat_mod univ 2 _).symm
    _ = ((∑ i : α, (encode (f i)).val) +
        (∑ i : α, (encode (f (p i))).val)) % 2 := by rw [sum_add_distrib]
    _ = ((∑ i : α, (encode (f i)).val) +
        (∑ i : α, (encode (f i)).val)) % 2 := by
      rw [p.sum_comp (fun i => (encode (f i)).val)]
    _ = (2 * ∑ i : α, (encode (f i)).val) % 2 := by rw [two_mul]
    _ = 0 := by simp

end Ising2DLambda.NecSuf.FisherZero
