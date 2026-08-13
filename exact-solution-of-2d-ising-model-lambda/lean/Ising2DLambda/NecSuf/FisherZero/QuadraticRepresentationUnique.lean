/-
「二次体の表示の一意性」の論理的な手順だけを残した必要十分版。
係数側と値側の加法可換群、係数の加法を保つ写像、右から掛ける操作の加法保存と
零元保存、および一と s の一次独立性だけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem quadratic_representation_unique_necSuf
    {A K S : Type} [AddCommGroup A] [AddCommGroup K]
    (embed : A →+ K) (smul : K → S → K)
    (hSmulAdd : ∀ x y : K, ∀ t : S, smul (x + y) t = smul x t + smul y t)
    (hSmulZero : ∀ t : S, smul 0 t = 0)
    (s : S)
    (hIndependent : ∀ α β : A, embed α + smul (embed β) s = 0 → α = 0 ∧ β = 0)
    (a b a' b' : A)
    (hab : embed a + smul (embed b) s = embed a' + smul (embed b') s) :
    a = a' ∧ b = b' := by
  let α : A := a + (-a')
  let β : A := b + (-b')
  have hzero : embed α + smul (embed β) s = 0 := by
    calc
      embed α + smul (embed β) s =
          (embed a + (-embed a')) + smul (embed b + (-embed b')) s := by
            rw [show α = a + (-a') by rfl, show β = b + (-b') by rfl,
              map_add, map_neg, map_add, map_neg]
      _ = (embed a + (-embed a')) + (smul (embed b) s + smul (-embed b') s) := by
            rw [hSmulAdd]
      _ = embed a + ((-embed a') + (smul (embed b) s + smul (-embed b') s)) := by
            rw [add_assoc]
      _ = embed a + ((smul (embed b) s + smul (-embed b') s) + (-embed a')) := by
            rw [add_comm (-embed a')]
      _ = embed a + (smul (embed b) s + (smul (-embed b') s + (-embed a'))) := by
            rw [add_assoc]
      _ = (embed a + smul (embed b) s) + (smul (-embed b') s + (-embed a')) := by
            rw [add_assoc]
      _ = (embed a' + smul (embed b') s) + (smul (-embed b') s + (-embed a')) := by
            rw [hab]
      _ = embed a' + (smul (embed b') s + (smul (-embed b') s + (-embed a'))) := by
            rw [add_assoc]
      _ = embed a' + ((smul (embed b') s + smul (-embed b') s) + (-embed a')) := by
            rw [add_assoc]
      _ = embed a' + (smul (embed b' + (-embed b')) s + (-embed a')) := by
            rw [hSmulAdd]
      _ = embed a' + (smul 0 s + (-embed a')) := by rw [add_neg_cancel]
      _ = embed a' + (0 + (-embed a')) := by rw [hSmulZero]
      _ = embed a' + (-embed a') := by rw [zero_add]
      _ = 0 := by rw [add_neg_cancel]
  have hcoeff : α = 0 ∧ β = 0 := hIndependent α β hzero
  constructor
  · calc
      a = a + 0 := by rw [add_zero]
      _ = a + ((-a') + a') := by rw [neg_add_cancel]
      _ = (a + (-a')) + a' := by rw [add_assoc]
      _ = α + a' := by rfl
      _ = 0 + a' := by rw [hcoeff.1]
      _ = a' := by rw [zero_add]
  · calc
      b = b + 0 := by rw [add_zero]
      _ = b + ((-b') + b') := by rw [neg_add_cancel]
      _ = (b + (-b')) + b' := by rw [add_assoc]
      _ = β + b' := by rfl
      _ = 0 + b' := by rw [hcoeff.2]
      _ = b' := by rw [zero_add]

end Ising2DLambda.NecSuf.FisherZero
