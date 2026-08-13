/-
「正錐の非負係数条件どうしの和」の必要十分版。
二座標の加法単調性と、非負な二項の和が零なら各項が零であることだけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_necSuf
    {A : Type} (zero : A) (add : A → A → A) (le : A → A → Prop)
    (a b a' b' : A)
    (ha : le zero a) (hb : le zero b) (hap : le zero a') (hbp : le zero b')
    (hab : (a, b) ≠ (zero, zero))
    (hAddNonneg : ∀ x y, le zero x → le zero y → le zero (add x y))
    (hAddEqZero : ∀ x y, le zero x → le zero y → add x y = zero → x = zero ∧ y = zero) :
    le zero (add a a') ∧ le zero (add b b') ∧
      (add a a', add b b') ≠ (zero, zero) := by
  refine ⟨hAddNonneg a a' ha hap, hAddNonneg b b' hb hbp, ?_⟩
  intro hPair
  have hA : add a a' = zero := congrArg Prod.fst hPair
  have hB : add b b' = zero := congrArg Prod.snd hPair
  have ha0 : a = zero := (hAddEqZero a a' ha hap hA).1
  have hb0 : b = zero := (hAddEqZero b b' hb hbp hB).1
  exact hab (Prod.ext ha0 hb0)

end Ising2DLambda.NecSuf.FisherZero
